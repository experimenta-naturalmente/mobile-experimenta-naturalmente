import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/main_screen.dart';

class SignUpDescription extends StatefulWidget {
  const SignUpDescription({super.key});

  @override
  State<SignUpDescription> createState() => _SignUpDescriptionState();
}

class _SignUpDescriptionState extends State<SignUpDescription> {
  final List<XFile> _imageFiles = [];

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFiles.add(pickedFile);
      } else {
        print('No image selected.');
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        DoubleCircle(),
        Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDescriptionField(),
                    const SizedBox(height: 32),
                    _buildAttachmentsField(),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: SubmitButton(
                        text: 'Avançar',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentsField() {
    return Column(
      children: [
        Text(
          'Adicione algumas fotos',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: getImage,
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

  Widget _buildDescriptionField() {
    return Column(
      children: [
        Text(
          'Adicione uma descrição',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: Theme.of(context).textTheme.bodyLarge,
          controller: _controller,
          keyboardType: TextInputType.multiline,
          maxLines: 7,
          maxLength: 560,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
