// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:brothers_creative/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart";
import "package:brothers_creative/utils/constants/color.dart";
import "package:brothers_creative/utils/helpers/helper_functions.dart";
import "package:flutter/material.dart";

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // const String secondChoice = "Color(0xff0099ff)";
    // brotherData[0].termsCondition
    return TCurvedEdgesWidget(
      child: Container(
        color:
            THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
        child: SizedBox(
          child: Stack(
            children: [
              // Positioned(
              //   top: -150,
              //   right: -250,
              //   child: TCirculerContainer(
              //     backgroundColor: TColors.textWhite.withValues(alpha: 0.1),
              //   ),
              // ),
              // Positioned(
              //   top: 100,
              //   right: -300,
              //   child: TCirculerContainer(
              //     backgroundColor: TColors.textWhite.withValues(alpha: 0.1),
              //   ),
              // ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
