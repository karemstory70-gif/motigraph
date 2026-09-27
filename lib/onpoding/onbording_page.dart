import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/onpoding/onboarding_data.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        child: Row(
          children: [
            // النص
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title.tr(),
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      data.description.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 15),

            // الصورة
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  data.image,
                  fit: BoxFit.contain,
                  height: double.infinity,
                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return Icon(
                      Icons.image_outlined,
                      size: 180,
                      color: theme.colorScheme.primary.withOpacity(0.3),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}