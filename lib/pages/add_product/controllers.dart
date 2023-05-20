import 'package:flutter/material.dart';

class AddProductControllers {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final imageController = TextEditingController();
  final discountPercController = TextEditingController();
  final priceController = TextEditingController();

  void dispose() {
    nameController.dispose();
    descController.dispose();
    imageController.dispose();
    discountPercController.dispose();
    priceController.dispose();
  }
}
