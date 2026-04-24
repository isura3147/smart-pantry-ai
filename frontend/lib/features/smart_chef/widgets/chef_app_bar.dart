import 'package:flutter/material.dart';

class ChefAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onAvatarTap;

  const ChefAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onLeadingTap,
    this.onAvatarTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadingIcon = showBackButton
        ? Icons.arrow_back_rounded
        : Icons.menu_rounded;
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      // menu icon is a no-op for now — hook to drawer when shell lands
      leading: IconButton(
        icon: Icon(leadingIcon, color: theme.colorScheme.primary),
        onPressed:
            onLeadingTap ??
            (showBackButton ? () => Navigator.maybePop(context) : null),
      ),
      titleSpacing: 0,
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: onAvatarTap,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF0D3B3B),
              child: Icon(
                Icons.restaurant_rounded,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
