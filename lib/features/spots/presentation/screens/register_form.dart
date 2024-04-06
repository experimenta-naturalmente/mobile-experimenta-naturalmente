import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';
import 'package:turismo_rural_frontend/features/spots/presentation/screens/outlined_textfield.dart';
import 'package:turismo_rural_frontend/main_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String fontName = 'JosefinSans';
  final _formKey = GlobalKey<FormState>();

  // Mask
  MaskTextInputFormatter phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {
      "#": RegExp('[0-9]'),
    },
  );

  MaskTextInputFormatter cnpjMask = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {
      "#": RegExp('[0-9]'),
    },
  );

  MaskTextInputFormatter cepMask = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      "#": RegExp('[0-9]'),
    },
  );

  // Validate Email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-mail é necessário.';
    }

    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$';
    final RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Insira um e-mail válido.';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone é necessário.';
    }

    if (value.characters.length != 15) {
      // Length com todos os números + parÊnteses e -
      return 'Insira um telefone válido.';
    }

    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome Fantasia é necessário.';
    }

    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Endereço é necessário.';
    }

    return null;
  }

  String? _validateCEP(String? value) {
    if (value == null || value.isEmpty) {
      return 'CEP é necessário.';
    }

    if (value.length != 9) {
      // Validação com o CEP com todos os números e -
      return 'CEP inválido.';
    }

    return null;
  }

  String? _validateCNPJ(String? value) {
    if (value == null || value.isEmpty) {
      return 'CNPJ é necessário.';
    }
    return null;
  }

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
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: GradientText(
          text: 'Cadastro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
          ),
        ),
      ),
      body: Stack(
        children: [
          DoubleCircle(),
          Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedTextField(
                      outlined: 'Nome Fantasia',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.name,
                      validator: _validateName,
                    ),
                    OutlinedTextField(
                      outlined: 'Email Empresarial',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    OutlinedTextField(
                      outlined: 'Telefone',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                      mask: phoneMask,
                    ),
                    OutlinedTextField(
                      outlined: 'Endereço',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.streetAddress,
                      validator: _validateAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Expanded(
                            child: OutlinedTextField(
                              outlined: 'Número',
                              verticalPadding: 0,
                              horizontalPadding: 0,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ), // Adjust spacing between fields
                          Expanded(
                            child: OutlinedTextField(
                              outlined: 'CEP',
                              verticalPadding: 0,
                              horizontalPadding: 0,
                              keyboardType: TextInputType.number,
                              mask: cepMask,
                              validator: _validateCEP,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedTextField(
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      outlined: 'CNPJ',
                      keyboardType: TextInputType.number,
                      mask: cnpjMask,
                      validator: _validateCNPJ,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 50, right: 50),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
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
                        },
                        child: Text(
                          'Avançar',
                          style: TextStyle(
                            fontFamily: fontName,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize,
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
    );
  }
}
