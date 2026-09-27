import 'package:flutter/material.dart';
import 'package:motigraph/settings/app_settings_controller.dart';

class OnboardingData {
  final String title;
  final String description;
  final String image;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

const List<OnboardingData> onboardingPages = [
  OnboardingData(
    title: 'title1',
    description:
    'description1',
    image: 'assets/images/onboarding_1.png',
  ),

  OnboardingData(
    title: 'title2',
    description:
    'description2',
    image: 'assets/images/onboarding_2.png',
  ),

  OnboardingData(
    title: 'title3',
    description:
    'description3',
    image: 'assets/images/onboarding_3.png',
  ),
];