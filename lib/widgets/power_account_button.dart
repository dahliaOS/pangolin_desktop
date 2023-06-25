import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/material.dart';
import 'package:zenit_ui/zenit_ui.dart';

class PowerAccountMenuButton extends StatelessWidget {
  const PowerAccountMenuButton({
    required this.title,
    required this.icon,
    required this.context,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final BuildContext context;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 48,
        width: 280,
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: Constants.smallShape,
          color: theme.primaryColor,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: theme.accentForegroundColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      color: theme.accentForegroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
