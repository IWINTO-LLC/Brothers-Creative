import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class TRounsCheckBox extends StatelessWidget {
  const TRounsCheckBox({
    super.key,
    this.isChecked = false,
    this.text = '',
    required this.onTap,
  });
  final String text;
  final bool isChecked;
  final Function(bool?) onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundCheckBox(
          size: 20,
          isChecked: isChecked,
          checkedWidget: const Icon(Icons.check, size: 15, color: Colors.white),
          checkedColor: TColors.primary,
          onTap: onTap,
        ),
        const SizedBox(width: TSizes.md),
        Text(text)
      ],
    );
  }
}
