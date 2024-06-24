import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
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
    final attachmentList = List<AttachmentUpload>.from(
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
              final updatedList = List<AttachmentUpload>.from(attachmentList);
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

  Future<void> _submitRegistration(
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      final _ = await experienceRepository.registerExperience(registration);
      registration.clear();
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(error: e.toString()));
    }
  }

  Future<void> _handleImageUpload(
    AttachmentUpload attachment,
    XFile newFile,
    Function(AttachmentUpload) onProgress,
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

  Future<XFile?> compressImage(XFile file, String targetPath) async {
    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      return XFile.fromData(
        bytes,
        name: targetPath.split('/').last,
        mimeType: 'image/jpeg',
      );
    }
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 50,
    );
    return compressedFile;
  }

  Future<XFile?> _preprocessImage(XFile file) async {
    try {
      String directoryPath = '';
      try {
        final directory = await getTemporaryDirectory();
        directoryPath = directory.path;
      } catch (e) {
        directoryPath = '/temp';
      }
      final timestampStr = DateTime.now().millisecondsSinceEpoch.toString();
      final lastFiveDigits = timestampStr.substring(timestampStr.length - 5);
      final newPath = '$directoryPath/$lastFiveDigits.jpg';

      final compressedFile = await compressImage(XFile(file.path), newPath);
      if (compressedFile == null) {
        return null;
      }
      return compressedFile;
    } catch (e) {
      return null;
    }
  }

  Future<void> _onSignUpChangeWorkingHours(
    SignUpChangeWorkingHours event,
    Emitter<SignUpState> emit,
  ) async {
    final day = event.day;
    final workingHours = event.workingHours;

    const autofillWeekdays = [
      WeekDay.monday,
      WeekDay.tuesday,
      WeekDay.wednesday,
      WeekDay.thursday,
      WeekDay.friday,
    ];

    final isFirstSet = registration.workingHours.entries
        .where((entry) => autofillWeekdays.contains(entry.key))
        .every((entry) => entry.value.isEmpty);

    registration.workingHours[day] = workingHours;
    if (isFirstSet) {
      for (final weekday in autofillWeekdays) {
        if (registration.workingHours[weekday]?.isEmpty ?? true) {
          registration.workingHours[weekday] = workingHours;
        }
      }
    }

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
      registration.clear();
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
      await _updateAttachments(
        (state as SignUpPageDescriptionState).attachments,
      );
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
      selectedTagsCache = (state as SignUpPageTagSelectionState).selectedTags;
      if (previous) {
        if (registration.category?.name == 'Evento') {
          emit(SignUpPageDateRangeState());
        } else {
          emit(
            SignUpPageWorkingHoursState(
              workingHours: registration.workingHours,
            ),
          );
        }
      } else {
        _updateTags();
        await _submitRegistration(emit);
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
      toggledTag.tagId,
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
        if (categoryTag.categoryId == registration.category?.categoryId) {
          filteredTags.add(tag);
        }
        selectedTagsCache[tag.tagId] = false;
      }
    }
  }

  Future<void> _onSignUpErrorEvent(
    SignUpErrorEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const SignUpError());
  }

  Future<void> _updateAttachments(
    List<AttachmentUpload> attachments,
  ) async {
    final attachmentsRegistration = List<AttachmentUpload>.from(attachments)
        .map(
          (attachment) {
            final url = attachment.url;
            if (url != null) {
              return attachment;
            }
          },
        )
        .nonNulls
        .toList();
    registration.attachments = attachmentsRegistration;
  }

  void _updateTags() {
    registration.selectedTags = selectedTagsCache.keys
        .where((key) => selectedTagsCache[key] == true)
        .map((key) => availableTags.firstWhere((tag) => tag.tagId == key))
        .toList();
  }
}
