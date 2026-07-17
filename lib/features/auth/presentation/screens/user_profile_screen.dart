import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/widgets/profile_tabbar.dart';

class UserProfileScreen extends StatefulWidget {
  final User user;

  const UserProfileScreen({required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _updatingAvatar = false;

  Future<void> _pickAndUploadAvatar() async {
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) {
      return;
    }

    final sourceBytes = await picked.readAsBytes();
    final compressed = await FlutterImageCompress.compressWithList(
      sourceBytes,
      quality: 45,
      format: CompressFormat.jpeg,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _updatingAvatar = true;
    });

    try {
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set(
        {
          'profileImage': Blob(compressed),
        },
        SetOptions(merge: true),
      );
    } finally {
      if (mounted) {
        setState(() {
          _updatingAvatar = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Stack(
            children: [
              DoubleCircle(),
              const LoadingIndicator(),
            ],
          );
        }
        if (state is ProfileError) {
          return ErrorHandler(
            error: state.error,
            onRetry: () {
              context.read<LoginBloc>().add(
                    LoginClear(),
                  );
            },
          );
        }
        if (state is ProfileSuccess) {
          final spotsBusiness = state.spotsBusiness;
          return Stack(
            children: [
              OverflowBox(child: DoubleCircle()),
              Column(
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: screenHeight > 700
                        ? screenHeight * 0.2
                        : screenHeight * 0.15,
                    width: double.infinity,
                    child: _buildProfileAvatar(context),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      widget.user.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ProfileTabbar(
                      user: widget.user,
                      spotsBusiness: spotsBusiness,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const CircleAvatar(
        child: Icon(Icons.person),
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.data();
        final imageBlob = data?['profileImage'];

        if (imageBlob is Blob) {
          return _buildAvatarFrame(
            context,
            backgroundImage: MemoryImage(imageBlob.bytes),
          );
        }

        return _buildAvatarFrame(
          context,
          child: const Icon(Icons.person),
        );
      },
    );
  }

  Widget _buildAvatarFrame(
    BuildContext context, {
    ImageProvider? backgroundImage,
    Widget? child,
  }) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: backgroundImage,
            child: backgroundImage == null ? child : null,
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: IconButton.filled(
              onPressed: _updatingAvatar ? null : _pickAndUploadAvatar,
              icon: _updatingAvatar
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}
