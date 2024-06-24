import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/data/attachment.dart';

class SignUpPageDescription extends StatefulWidget {
  final SignUpPageDescriptionState state;

  const SignUpPageDescription({super.key, required this.state});

  @override
  _SignUpPageDescriptionState createState() => _SignUpPageDescriptionState();
}

class _SignUpPageDescriptionState extends State<SignUpPageDescription> {
  final ScrollController _descriptionScrollController = ScrollController();
  final TextEditingController _descriptionController = TextEditingController();
  final ScrollController _detailsScrollController = ScrollController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionController.text =
        context.read<SignUpBloc>().registration.description ?? '';
    _descriptionController.addListener(_scrollToBottom);
    _detailsController.text =
        context.read<SignUpBloc>().registration.description ?? '';
    _detailsController.addListener(_scrollToBottomDetails);
  }

  @override
  void dispose() {
    _descriptionController.removeListener(_scrollToBottom);
    _descriptionController.dispose();
    _descriptionScrollController.dispose();
    _detailsController.removeListener(_scrollToBottomDetails);
    _detailsController.dispose();
    _detailsScrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_descriptionScrollController.hasClients) {
        final cursorPosition = _descriptionController.selection.baseOffset;
        if (cursorPosition == _descriptionController.text.length) {
          _descriptionScrollController
              .jumpTo(_descriptionScrollController.position.maxScrollExtent);
        }
      }
    });
  }

  void _scrollToBottomDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_detailsScrollController.hasClients) {
        final cursorPosition = _detailsController.selection.baseOffset;
        if (cursorPosition == _detailsController.text.length) {
          _detailsScrollController
              .jumpTo(_detailsScrollController.position.maxScrollExtent);
        }
      }
    });
  }

  Future<void> _pickAttachment(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null && context.mounted) {
      final AttachmentUpload attachment = AttachmentUpload(
        localFile: XFile(pickedFile.path),
        type: AttachmentType.image,
      );
      context.read<SignUpBloc>().add(
            SignUpAttachmentUpload(attachment: attachment),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = context.read<SignUpBloc>().registration.category ??
        context.read<SignUpBloc>().categoriesCache.first;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionField(context),
          const SizedBox(height: 32),
          _buildAttachmentsField(context, widget.state.attachments),
          if (selectedCategory.name == 'Evento') ...[
            const SizedBox(height: 32),
            _buildDetailsField(context),
          ],
        ],
      ),
    );
  }

  Widget _buildAttachmentsField(
    BuildContext context,
    List<AttachmentUpload> attachments,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adicione algumas fotos',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: attachments.map((attachment) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Opacity(
                    opacity: attachment.isUploading ? 0.5 : 1,
                    child: _buildImage(attachment.localFile),
                  ),
                ),
                Visibility(
                  visible: attachment.isUploading,
                  child: CircularProgressIndicator(
                    value: attachment.progress.toDouble(),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            );
          }).toList()
            ..add(
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickAttachment(context);
                    },
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        size: 50,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ),
      ],
    );
  }

  Widget _buildImage(XFile file) {
    return FutureBuilder<Uint8List>(
      future: file.readAsBytes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dê uma breve descrição',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: Scrollbar(
            controller: _descriptionScrollController,
            child: SingleChildScrollView(
              controller: _descriptionScrollController,
              child: TextField(
                controller: _descriptionController,
                onChanged: (value) {
                  context.read<SignUpBloc>().registration.description = value;
                },
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                maxLength: 560,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Qual a programação do evento?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: Scrollbar(
            controller: _detailsScrollController,
            child: SingleChildScrollView(
              controller: _detailsScrollController,
              child: TextField(
                controller: _detailsController,
                onChanged: (value) {
                  context.read<SignUpBloc>().registration.eventDetails = value;
                },
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                maxLength: 560,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
