// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TTabbar extends StatelessWidget implements PreferredSizeWidget {
  const TTabbar({super.key, required this.tabs});

  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child:
      // Container(
      //margin: EdgeInsets.only(top: 20),
      // decoration: BoxDecoration(boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withValues(alpha: 0.5),
      //     //spreadRadius: 2,
      //     blurRadius: 20,
      //     blurStyle: BlurStyle.outer,
      //     offset: const Offset(5, 0), // changes position of shadow
      //   ),
      // ]
      //),
      //child:
      TabBar(
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        padding: EdgeInsets.all(0),
        isScrollable: true,
        indicatorColor: TColors.primary,
        // unselectedLabelColor: TColors.darkGrey,
        labelColor: dark ? TColors.white : TColors.black,
        tabs: tabs,
      ),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0.1);
}
