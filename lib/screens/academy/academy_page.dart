import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AcademyPage extends StatelessWidget {
  const AcademyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('academy'.tr()),
      ),
      body: Center(
        child: Text(
          'academy'.tr(),
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}