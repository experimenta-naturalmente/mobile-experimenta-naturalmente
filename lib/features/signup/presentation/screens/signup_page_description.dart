import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_state.dart';

class SignUpPageDescription extends StatelessWidget {
  final SignUpPageDescriptionState state;

  const SignUpPageDescription({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final selectedCategory = state.selectedCategory;
    return SingleChildScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDescriptionField(context),
            const SizedBox(height: 32),
            _buildAttachmentsField(context),
            if (selectedCategory.name == 'Evento') ...[
              const SizedBox(height: 32),
              _buildDetailsField(context),
            ],
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Widget _buildAttachmentsField(BuildContext context) {
    return Column(
      children: [
        Text(
          'Adicione algumas fotos',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            getImage().then((file) {
              if (file != null) {
                context.read<SignUpBloc>().add(SignUpAttachmentUpload(file));
              }
            });
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 75,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 16),
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return Column(
      children: [
        Text(
          'Adicione uma descrição',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: TextEditingController(
            text: context.read<SignUpBloc>().registration.description,
          ),
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
      ],
    );
  }

  Widget _buildDetailsField(BuildContext context) {
    return Column(
      children: [
        Text(
          'Adicione a programação do evento',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: TextEditingController(
            text: context.read<SignUpBloc>().registration.description,
          ),
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
      ],
    );
  }
}
