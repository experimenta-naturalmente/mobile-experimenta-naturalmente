import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/data/models/experience_registration.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final IExperienceRepository experienceRepository;
  final ITagRepository tagRepository;
  Set<ExperienceCategory> categoriesCache = {};
  Map<int, bool> selectedTagsCache = {};
  Set<Tag> availableTags = {};
  Set<Tag> filteredTags = {};
  final ExperienceRegistration registration = ExperienceRegistration();
  SignUpBloc({required this.experienceRepository, required this.tagRepository})
      : super(SignUpLoading()) {
    on<SignUpChangePage>(_onSignUpChangePage);
    on<SignUpToggleTag>(_onToggleTag);
    on<LoadSignUp>(_onLoadSignUp);
    on<SignUpChangeWorkingHours>(_onSignUpChangeWorkingHours);
  }

  Future<void> _onSignUpChangeWorkingHours(
    SignUpChangeWorkingHours event,
    Emitter<SignUpState> emit,
  ) async {
    final day = event.day;
    final workingHours = event.workingHours;
    registration.workingHours[day] = workingHours;
    emit(SignUpPageWorkingHoursState(workingHours: registration.workingHours));
  }

  Future<void> _onLoadSignUp(
    LoadSignUp event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      if (categoriesCache.isEmpty) {
        categoriesCache =
            await experienceRepository.fetchExperienceCategories();
      }
      await _initTags();
      emit(SignUpPageInitialState());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> _onSignUpChangePage(
    SignUpChangePage event,
    Emitter<SignUpState> emit,
  ) async {
    final previous = event.previous;
    if (state is SignUpPageInitialState) {
      if (!previous) {
        emit(
          SignUpPageDescriptionState(selectedCategory: registration.category!),
        );
      }
      emit(
        SignUpPageDescriptionState(selectedCategory: registration.category!),
      );
    } else if (state is SignUpPageDescriptionState) {
      if (previous) {
        emit(SignUpPageInitialState());
      } else {
        emit(SignUpPageFormState());
      }
    } else if (state is SignUpPageFormState) {
      if (previous) {
        emit(
          SignUpPageDescriptionState(selectedCategory: registration.category!),
        );
      } else {
        if (registration.category?.name == 'Evento') {
          emit(SignUpPageDateRangeState());
        } else {
          emit(
            SignUpPageWorkingHoursState(
              workingHours: registration.workingHours,
            ),
          );
        }
      }
    } else if (state is SignUpPageDateRangeState) {
      if (previous) {
        emit(SignUpPageFormState());
      } else {
        await _showTags();
        emit(SignUpPageTagSelectionState(selectedTags: selectedTagsCache));
      }
    } else if (state is SignUpPageWorkingHoursState) {
      if (previous) {
        emit(SignUpPageFormState());
      } else {
        await _showTags();
        emit(SignUpPageTagSelectionState(selectedTags: selectedTagsCache));
      }
    } else if (state is SignUpPageTagSelectionState) {
      if (previous) {
        selectedTagsCache = (state as SignUpPageTagSelectionState).selectedTags;
        if (registration.category?.name == 'Evento') {
          emit(SignUpPageDateRangeState());
        } else {
          emit(
            SignUpPageWorkingHoursState(
              workingHours: registration.workingHours,
            ),
          );
        }
      }
    }
  }

  Future<void> _onToggleTag(
    SignUpToggleTag event,
    Emitter<SignUpState> emit,
  ) async {
    final toggledTag = event.tag;
    final selectedTags = Map<int, bool>.from(event.selectedTags);
    selectedTags.update(
      toggledTag.id,
      (value) => !value,
      ifAbsent: () => false,
    );
    emit(SignUpPageTagSelectionState(selectedTags: selectedTags));
  }

  Future<void> _initTags() async {
    availableTags = await tagRepository.fetchAllTags();
    selectedTagsCache = {};
  }

  Future<void> _showTags() async {
    filteredTags = {};

    for (final tag in availableTags) {
      if (tag.type.id == registration.category?.id) {
        filteredTags.add(tag);
      }
      selectedTagsCache[tag.id] = false;
    }
  }
}
