import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_time_selection_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          DoubleCircle(),
          Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const GradientText(text: 'Cadastro'),
                    _buildTextField(
                      text: 'Nome Fantasia',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.text,
                      validator: _validateField,
                    ),
                    _buildTextField(
                      text: 'Email Empresarial',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    _buildTextField(
                      text: 'Telefone',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                      mask: phoneMask,
                    ),
                    _buildTextField(
                      text: 'Endereço',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.streetAddress,
                      validator: _validateField,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTextField(
                              text: 'Número',
                              verticalPadding: 0,
                              horizontalPadding: 0,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: _buildTextField(
                              text: 'CEP',
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
                    _buildTextField(
                      text: 'CNPJ',
                      verticalPadding: 10,
                      horizontalPadding: 50,
                      keyboardType: TextInputType.number,
                      mask: cnpjMask,
                      validator: _validateField,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 36, bottom: 12),
                      child: SubmitButton(
                        text: 'Avançar',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TimeTableScreen(),
                            ),
                          );
                        },
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

  Widget _buildTextField({
    required String text,
    required int verticalPadding,
    required int horizontalPadding,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
    MaskTextInputFormatter? mask,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding.toDouble(),
        horizontal: horizontalPadding.toDouble(),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: mask != null ? [mask] : null,
        decoration: InputDecoration(
          labelText: text,
          errorStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo necessário.';
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
      return 'Campo necessário.';
    }
    if (value.characters.length != 15) {
      return 'Insira um telefone válido.';
    }
    return null;
  }

  String? _validateCEP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo necessário.';
    }
    if (value.length != 9) {
      return 'CEP inválido.';
    }
    return null;
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo necessário.';
    }
    return null;
  }
}
