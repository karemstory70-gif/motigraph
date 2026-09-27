import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('account'.tr()),
      ),
      body: Center(
        child: Text(
          'account'.tr(),
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
