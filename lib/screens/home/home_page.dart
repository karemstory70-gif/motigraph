import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr()),
      ),
      body: Center(
        child: Text(
          'home'.tr(),
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}