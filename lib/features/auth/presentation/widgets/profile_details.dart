import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/screens/change_password_screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileDetails extends StatefulWidget {
  final User user;
  const ProfileDetails({super.key, required this.user});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _cpfController;
  late TextEditingController _phoneController;
  late MaskTextInputFormatter _cpfMaskFormatter;
  late MaskTextInputFormatter _phoneMaskFormatter;
  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _cpfController = TextEditingController(text: widget.user.cpf);
    _phoneController = TextEditingController(text: widget.user.phone);
    _cpfMaskFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {'#': RegExp(r'[0-9]')},
    );
    _phoneMaskFormatter = MaskTextInputFormatter(
      mask: '(##)#####-####',
      filter: {'#': RegExp(r'[0-9]')},
    );
    _cpfController.value = _cpfMaskFormatter.updateMask(
      mask: '###.###.###-##',
      newValue: TextEditingValue(text: _cpfController.text),
    );
    _phoneController.value = _phoneMaskFormatter.updateMask(
      mask: '(##)#####-####',
      newValue: TextEditingValue(text: _phoneController.text),
    );
    _loadUserProfileFromFirestore();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfileFromFirestore() async {
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    final data = doc.data();
    if (data == null) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _nameController.text = data['name']?.toString().isNotEmpty == true
          ? data['name'].toString()
          : widget.user.name;
      _emailController.text = data['email']?.toString().isNotEmpty == true
          ? data['email'].toString()
          : widget.user.email;
      _cpfController.text = data['cpf']?.toString() ?? widget.user.cpf;
      _phoneController.text = data['phone']?.toString() ?? widget.user.phone;
      _cpfController.value = _cpfMaskFormatter.updateMask(
        mask: '###.###.###-##',
        newValue: TextEditingValue(text: _cpfController.text),
      );
      _phoneController.value = _phoneMaskFormatter.updateMask(
        mask: '(##)#####-####',
        newValue: TextEditingValue(text: _phoneController.text),
      );
    });
  }

  Future<void> _saveProfile() async {
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set(
        {
          'phone': _phoneController.text.trim(),
        },
        SetOptions(merge: true),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Telefone atualizado com sucesso!'),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao atualizar o telefone.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    await firebase_auth.FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', false);
    if (!mounted) {
      return;
    }
    context.read<LoginBloc>().add(LoginClear());
  }

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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildUserDetails(context),
              ),
            ),
            const SizedBox(height: 8),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Dados Pessoais',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(width: 8),
            IconButton.outlined(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const SizedBox(height: 8),
        _buildField(
          context,
          label: 'Nome',
          controller: _nameController,
          editable: false,
        ),
        const SizedBox(height: 8),
        _buildField(
          context,
          label: 'Email',
          controller: _emailController,
          editable: false,
        ),
        const SizedBox(height: 8),
        _buildField(
          context,
          label: 'CPF',
          controller: _cpfController,
          editable: false,
        ),
        const SizedBox(height: 8),
        _buildField(
          context,
          label: 'Telefone',
          controller: _phoneController,
          editable: true,
        ),
        if (_isEditing) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: _isSaving ? null : _saveProfile,
              child: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Salvar'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required bool editable,
  }) {
    if (_isEditing && editable) {
      final inputFormatters = <TextInputFormatter>[
        if (label == 'Telefone') _phoneMaskFormatter,
      ];

      return TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextSpan(
            text: controller.text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final darkGreen = Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: darkGreen,
            side: BorderSide(color: darkGreen, width: 1.5),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ChangePasswordScreen(),
              ),
            );
          },
          child: const Text('Alterar senha'),
        ),
        TextButton.icon(
          onPressed: _logout,
          icon: const Icon(Icons.logout),
          label: const Text('Sair'),
        ),
      ],
    );
  }
}
