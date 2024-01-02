import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';

class TCommunitySectionHeading extends StatelessWidget {
  final String firstTitle, secondTitle, buttonTitle;
  final Color? firstTitleColor, secondTitleColor;
  final bool showActionButton;
  final VoidCallback? onPressed;

  const TCommunitySectionHeading({
    super.key,
    required this.firstTitle,
    this.secondTitle = "",
    this.showActionButton = false,
    this.onPressed,
    this.buttonTitle = '전체보기 >',
    this.firstTitleColor,
    this.secondTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              firstTitle,
              style: Theme.of(context).textTheme.headlineSmall!.apply(color: firstTitleColor),
            ),
            const SizedBox(width: TSizes.sm),
            Text(
              secondTitle,
              style: Theme.of(context).textTheme.titleMedium!.apply(color: secondTitleColor),
            ),
          ],
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey),
            ),
          )
      ],
    );
  }
}
