import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';

class ProfileDetails extends StatelessWidget {
  final User user;
  const ProfileDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      alignment: AlignmentDirectional.bottomStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Dados Pessoais',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Email: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                    ),
                  ),
                  // aqui colocar o email do user
                  TextSpan(
                    text: user.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Telefone: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize,
                        ),
                      ),
                      // aqui colocar a senha do user
                      TextSpan(
                        text: user.phone,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    // Adicione a ação do botão aqui
                  },
                  style: OutlinedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.0,
                      vertical: 1.0,
                    ), // Ajusta o padding
                    minimumSize: const Size(100, 30), // Ajusta o tamanho mínimo
                  ),
                  child: const Text('Trocar senha'),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
