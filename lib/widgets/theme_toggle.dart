import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final bool isDark;
  final String lightLabel;
  final String darkLabel;
  final VoidCallback onLight;
  final VoidCallback onDark;

  const ThemeToggle({
    super.key,
    required this.isDark,
    required this.lightLabel,
    required this.darkLabel,
    required this.onLight,
    required this.onDark,
  });

  @override
  Widget build(BuildContext context) {
    return _ToggleContainer(
      children: [
        _ToggleButton(
          icon: Icons.light_mode_outlined,
          label: lightLabel,
          selected: !isDark,
          onTap: onLight,
        ),
        _ToggleButton(
          icon: Icons.dark_mode_outlined,
          label: darkLabel,
          selected: isDark,
          onTap: onDark,
        ),
      ],
    );
  }
}

// ======================================================
// Toggle Container
// ======================================================

class _ToggleContainer extends StatelessWidget {
  final List<Widget> children;

  const _ToggleContainer({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(100),
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

class _ToggleButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleButton({
    this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFD4AF37)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: selected
                      ? Colors.black
                      : colorScheme.onSurface.withValues(
                    alpha: 0.7,
                  ),
                ),
                const SizedBox(width: 5),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: selected
                      ? Colors.black
                      : colorScheme.onSurface.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}