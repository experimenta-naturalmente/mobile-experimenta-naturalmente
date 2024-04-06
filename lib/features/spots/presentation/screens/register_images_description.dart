import 'dart:io' show File, Platform;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';

import 'package:turismo_rural_frontend/main_screen.dart';

class RegisterImagesDescription extends StatefulWidget {
  const RegisterImagesDescription({super.key});

  @override
  State<RegisterImagesDescription> createState() =>
      _RegisterImagesDescriptionState();
}

class _RegisterImagesDescriptionState extends State<RegisterImagesDescription> {
  File? _image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("your_upload_endpoint_here");
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image');
    }
  }

  String fontName = 'JosefinSans';
  Color startGradient = const Color.fromARGB(255, 83, 99, 60);
  Color finishGradient = const Color.fromARGB(255, 176, 209, 130);
  Color descriptionImageBoxBackground = const Color.fromRGBO(235, 240, 219, 1);
  Color descriptionImageBoxFontColor = const Color.fromRGBO(58, 80, 44, 1);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: GradientText(
          text: 'Cadastro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundImage.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            DoubleCircle(),
            Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Multi Text Field
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 50,
                          right: 50,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Adicione uma descrição:",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: descriptionImageBoxFontColor,
                                  fontFamily: fontName,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 214,
                                  maxHeight: 214,
                                ),
                                child: TextFormField(
                                  controller: _controller,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 7,
                                  maxLength: 500,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: descriptionImageBoxBackground,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    hintText: 'Digite aqui',
                                    hintStyle: TextStyle(
                                      color: const Color.fromRGBO(29, 29, 0, 1),
                                      fontSize: 18,
                                      fontFamily: fontName,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Image Uploader
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 60, left: 50, right: 50),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (_image == null)
                                Text(
                                  "Adicione algumas fotos:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: descriptionImageBoxFontColor,
                                    fontFamily: fontName,
                                  ),
                                )
                              else
                                Image.file(_image!),
                              const Padding(padding: EdgeInsets.only(top: 12)),
                              ElevatedButton(
                                style: ButtonStyle(
                                  shadowColor: const MaterialStatePropertyAll(
                                    Colors.transparent,
                                  ),
                                  shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  fixedSize: const MaterialStatePropertyAll(
                                    Size(311, 74),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                    descriptionImageBoxBackground,
                                  ),
                                ),
                                onPressed: getImage,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.attach_file,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 36, left: 50, right: 50),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(startGradient),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                horizontal: Platform.isIOS ? 115 : 80,
                                vertical: 15,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>

                                      /// LEVA PARA UMA NOVA TELA
                                      const MainScreen(),
                                ),
                              );
                            }
                            if (_image != null) {
                              uploadImage();
                            }
                          },
                          child: Text(
                            'Avançar',
                            style: TextStyle(
                              fontFamily: fontName,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
