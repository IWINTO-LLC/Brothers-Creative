// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TSettingMenuTile extends StatelessWidget {
  const TSettingMenuTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.iconColor = Colors.black,
    this.onTap,
    this.trailing,
  }) : super(key: key);
  final IconData icon;
  final Color iconColor;
  final String title, subTitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 28, color: iconColor),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
    );
  }
}
