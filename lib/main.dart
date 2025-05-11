import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cancer Care",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
