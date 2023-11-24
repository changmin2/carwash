import 'package:carwash/car/view/record_detail_screen.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class RecentCarWashCard extends StatelessWidget {
  const RecentCarWashCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => THelperFunctions.navigateToScreen(context, const RecordDetail(id: 2)),
      child: SizedBox(
        height: 80,
        child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'asset/img/login.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2023-05-04',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '화곡동 카워시',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_right),

              ],
            ),
        ),
      ),
    );


    //   SizedBox(
    //   width: double.infinity,
    //   height: 100,
    //   child: Card(
    //     color: Colors.white,
    //     elevation: 1.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12.0),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(TSizes.md),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Row(
    //             children: [
    //               Image.asset(
    //                 'asset/img/login.png',
    //                 width: 50,
    //                 height: 50,
    //               ),
    //               const SizedBox(width: TSizes.spaceBtwItems),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     '2023-05-04',
    //                     style: Theme.of(context).textTheme.bodyMedium,
    //                   ),
    //                   Text(
    //                     '화곡동 카워시',
    //                     style: Theme.of(context).textTheme.bodyMedium,
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //           const Icon(Icons.keyboard_arrow_right),
    //         ],
    //       ),
    //     ),
    //   ),
    // );


  }
}
