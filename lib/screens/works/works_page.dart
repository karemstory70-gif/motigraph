import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WorksPage extends StatelessWidget {
  const WorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('works'.tr()),
      ),
      body: Center(
        child: Text(
          'works'.tr(),
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}