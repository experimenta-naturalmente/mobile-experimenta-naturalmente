import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';

class SignUpPageForm extends StatelessWidget {
  SignUpPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(
              context,
              text: 'Nome Fantasia',
              verticalPadding: 10,
              horizontalPadding: 50,
              keyboardType: TextInputType.text,
              validator: _validateField,
              onChanged: (value) => {
                context.read<SignUpBloc>().registration.fantasyName = value,
              },
            ),
            _buildTextField(
              context,
              text: 'Email Empresarial',
              verticalPadding: 10,
              horizontalPadding: 50,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              onChanged: (value) => {
                context.read<SignUpBloc>().registration.email = value,
              },
            ),
            _buildTextField(
              context,
              text: 'Telefone',
              verticalPadding: 10,
              horizontalPadding: 50,
              keyboardType: TextInputType.phone,
              validator: _validatePhone,
              mask: phoneMask,
              onChanged: (value) => {
                context.read<SignUpBloc>().registration.phone = value,
              },
            ),
            _buildTextField(
              context,
              text: 'Endereço',
              verticalPadding: 10,
              horizontalPadding: 50,
              keyboardType: TextInputType.streetAddress,
              validator: _validateField,
              onChanged: (value) => {
                context.read<SignUpBloc>().registration.address = value,
              },
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
                      context,
                      text: 'Número',
                      verticalPadding: 0,
                      horizontalPadding: 0,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => {
                        context.read<SignUpBloc>().registration.number = value,
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: _buildTextField(
                      context,
                      text: 'CEP',
                      verticalPadding: 0,
                      horizontalPadding: 0,
                      keyboardType: TextInputType.number,
                      mask: cepMask,
                      validator: _validateCEP,
                      onChanged: (value) => {
                        context.read<SignUpBloc>().registration.zipCode = value,
                      },
                    ),
                  ),
                ],
              ),
            ),
            _buildTextField(
              context,
              text: 'CNPJ',
              verticalPadding: 10,
              horizontalPadding: 50,
              keyboardType: TextInputType.number,
              mask: cnpjMask,
              validator: _validateField,
              onChanged: (value) => {
                context.read<SignUpBloc>().registration.cnpj = value,
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String text,
    required int verticalPadding,
    required int horizontalPadding,
    required Function(String?) onChanged,
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
        onChanged: onChanged,
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

  final MaskTextInputFormatter phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {
      "#": RegExp('[0-9]'),
    },
  );

  final MaskTextInputFormatter cnpjMask = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {
      "#": RegExp('[0-9]'),
    },
  );

  final MaskTextInputFormatter cepMask = MaskTextInputFormatter(
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
