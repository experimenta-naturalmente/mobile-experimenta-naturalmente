import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/data/attachment.dart';
import 'package:turismo_rural_frontend/features/signup/data/experience_registration.dart';

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
    on<SignUpAttachmentUpload>(_onSignUpAttachmentUpload);
    on<SignUpErrorEvent>(_onSignUpErrorEvent);
  }

  Future<void> _onSignUpAttachmentUpload(
    SignUpAttachmentUpload event,
    Emitter<SignUpState> emit,
  ) async {
    final attachment = event.attachment;
    final localFile = attachment.localFile;
    final type = attachment.type;
    final attachmentList = List<Attachment>.from(
      (state as SignUpPageDescriptionState).attachments,
    );
    attachmentList.add(attachment);
    emit(
      (state as SignUpPageDescriptionState)
          .copyWith(attachments: attachmentList),
    );

    switch (type) {
      case AttachmentType.image:
        final convertedFile = await _preprocessImage(localFile);
        if (convertedFile != null) {
          await _handleImageUpload(
            attachment,
            convertedFile,
            (progressAttachment) {
              final updatedList = List<Attachment>.from(attachmentList);
              final index = updatedList.indexWhere((a) => a == attachment);
              if (index != -1) {
                updatedList[index] = progressAttachment;
              }
              emit(
                (state as SignUpPageDescriptionState)
                    .copyWith(attachments: updatedList),
              );
            },
          );
        } else {
          attachmentList.remove(attachment);
          emit(
            (state as SignUpPageDescriptionState).copyWith(
              attachments: attachmentList,
            ),
          );
        }

      case AttachmentType.video:
        break;
    }
  }

  Future<void> _handleImageUpload(
    Attachment attachment,
    XFile newFile,
    Function(Attachment) onProgress,
  ) async {
    final url = await experienceRepository.uploadImage(newFile, (progress) {
      final updatedAttachment = attachment.copyWith(progress: progress);
      onProgress(updatedAttachment);
    });

    if (url != null) {
      final updatedAttachment = attachment.copyWith(
        url: url,
        isUploading: false,
        progress: 100,
        file: newFile,
      );
      onProgress(updatedAttachment);
    }
  }

  Future<XFile?> _preprocessImage(XFile file) async {
    try {
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final newPath = '${directory.path}/$timestamp.jpg';

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.path,
        newPath,
        quality: 50,
      );
      if (compressedFile == null) {
        return null;
      }
      final bytesCount = await compressedFile.length();

      print(
        'Image successfully converted to JPG and saved at ${compressedFile.path}, size: ${bytesCount / 1000} KB',
      );

      return compressedFile;
    } catch (e) {
      print('Error processing image: $e');
      return null;
    }
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
      emit(SignUpError(error: e.toString()));
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
          const SignUpPageDescriptionState(),
        );
      }
      emit(
        const SignUpPageDescriptionState(),
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
          const SignUpPageDescriptionState(),
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
      for (final categoryTag in tag.type) {
        if (categoryTag.id == registration.category?.id) {
          filteredTags.add(tag);
        }
        selectedTagsCache[tag.id] = false;
      }
    }
  }

  Future<void> _onSignUpErrorEvent(
    SignUpErrorEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const SignUpError());
  }
}
