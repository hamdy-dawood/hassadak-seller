import 'package:flutter/material.dart';

class RegisterControllers {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final imageController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final whatsappController = TextEditingController();
  final facebookUrlController = TextEditingController();
  final instaUrlController = TextEditingController();
  final twitterUrlController = TextEditingController();
  final descriptionController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    imageController.dispose();
    userNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    whatsappController.dispose();
    facebookUrlController.dispose();
    instaUrlController.dispose();
    twitterUrlController.dispose();
    descriptionController.dispose();
  }
}
