import 'package:flutter/material.dart';

class AcademyToggle extends StatelessWidget {
  final bool isTraining;
  final String coursesLabel;
  final String trainingLabel;
  final VoidCallback onCourses;
  final VoidCallback onTraining;

  const AcademyToggle({
    super.key,
    required this.isTraining,
    required this.coursesLabel,
    required this.trainingLabel,
    required this.onCourses,
    required this.onTraining,
  });

  @override
  Widget build(BuildContext context) {
    return _AcademyToggleContainer(
      children: [
        _AcademyToggleButton(
          label: coursesLabel,
          selected: !isTraining,
          onTap: onCourses,
        ),

        _AcademyToggleButton(
          label: trainingLabel,
          selected: isTraining,
          onTap: onTraining,
        ),
      ],
    );
  }
}

// ======================================================
// Toggle Container
// ======================================================

class _AcademyToggleContainer extends StatelessWidget {
  final List<Widget> children;

  const _AcademyToggleContainer({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(3),

      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest
            .withValues(alpha: 0.55),

        borderRadius:
        BorderRadius.circular(100),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

// ======================================================
// Toggle Button
// ======================================================

class _AcademyToggleButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _AcademyToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,

        borderRadius:
        BorderRadius.circular(100),

        child: AnimatedContainer(
          duration:
          const Duration(milliseconds: 220),

          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),

          decoration: BoxDecoration(
            color: selected
                ? colorScheme.tertiary
                : Colors.transparent,

            borderRadius:
            BorderRadius.circular(100),
          ),

          child: Text(
            label,

            style: TextStyle(
              fontSize: 12,

              fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.w400,

              color: selected
                  ? colorScheme.onTertiary
                  : colorScheme.onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}