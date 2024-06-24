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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildUserDetails(context),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Column _buildUserDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dados Pessoais',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        _buildRichText(context, 'Email: ', user.email),
        const SizedBox(height: 8),
        _buildRichText(context, 'Telefone: ', user.phone),
      ],
    );
  }

  RichText _buildRichText(BuildContext context, String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Row _buildActionButtons() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Trocar senha'),
        ),
        const SizedBox(width: 16),
        IconButton.outlined(
          onPressed: () {},
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
