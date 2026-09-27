import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:motigraph/settings/app_settings_controller.dart';

import 'package:motigraph/screens/home/home_page.dart';
import 'package:motigraph/screens/academy/academy_page.dart';
import 'package:motigraph/screens/business_library/business_library_page.dart';
import 'package:motigraph/screens/works/works_page.dart';
import 'package:motigraph/screens/account/account_page.dart';

class MainNavigationScreen extends StatefulWidget {
  final AppSettingsController settingsController;

  const MainNavigationScreen({
    super.key,
    required this.settingsController,
  });

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {
  late final PageController _pageController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void _onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,

        children: const [
          HomePage(),
          AcademyPage(),
          BusinessLibraryPage(),
          WorksPage(),
          AccountPage(),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,

        onDestinationSelected: _onNavigationTap,

        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: 'home'.tr(),
          ),

          NavigationDestination(
            icon: const Icon(Icons.school_outlined),
            selectedIcon: const Icon(Icons.school),
            label: 'academy'.tr(),
          ),

          NavigationDestination(
            icon: const Icon(Icons.library_books_outlined),
            selectedIcon: const Icon(Icons.library_books),
            label: 'business_library'.tr(),
          ),

          NavigationDestination(
            icon: const Icon(Icons.work_outline),
            selectedIcon: const Icon(Icons.work),
            label: 'works'.tr(),
          ),

          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: 'account'.tr(),
          ),
        ],
      ),
    );
  }
}