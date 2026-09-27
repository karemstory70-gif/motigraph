import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BusinessLibraryPage extends StatelessWidget {
  const BusinessLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('business_library'.tr()),
      ),
      body: Center(
        child: Text(
          'business_library'.tr(),
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}