import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DoctorsView extends GetView {
  const DoctorsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DoctorsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DoctorsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
