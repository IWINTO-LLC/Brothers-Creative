// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu({
    super.key,
    required this.onPress,
    required this.title,
    required this.value,
    this.icon = Icons.keyboard_arrow_right,
  });
  final IconData icon;
  final VoidCallback onPress;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSizes.spaceBtWItems / 1.5),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                child: Icon(
              icon,
              size: 25,
            ))
          ],
        ),
      ),
    );
  }
}
