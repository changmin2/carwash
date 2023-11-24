import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../car/view/record_detail_screen.dart';

class CarWashLife extends StatelessWidget {
  const CarWashLife({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 230,
        height: 320,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.withOpacity(0.3))),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.sm),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'asset/img/car_image.jpeg',
                  fit: BoxFit.fill,
                  height: 200,
                ),
              ),
              const SizedBox(height: TSizes.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.face),
                            const SizedBox(width: TSizes.xs),
                            Text(
                              '세린이',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            const SizedBox(width: TSizes.xs),
                            Text(
                              '120',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: TSizes.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          THelperFunctions.truncateText(
                              '오늘 세차 맛집 다녀 왔습니다! 너무 깨끗했고 시설도 좋았습니다.', 15),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //   SizedBox(
    //   width: 230,
    //   child: Card(
    //     color: Colors.white,
    //     elevation: 1.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12.0),
    //     ),
    //     child: Column(
    //       children: [
    //         ClipRRect(
    //           borderRadius: const BorderRadius.vertical(
    //             top: Radius.circular(12.0),
    //           ),
    //           child: Image.asset(
    //             'asset/img/car_image.jpeg',
    //             fit: BoxFit.fill,
    //             height: 200,
    //           ),
    //         ),
    //         const SizedBox(height: TSizes.md),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
    //           child: Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       const Icon(Icons.face),
    //                       const SizedBox(width: TSizes.xs),
    //                       Text(
    //                         '세린이',
    //                         style: Theme.of(context).textTheme.titleMedium,
    //                       ),
    //                     ],
    //                   ),
    //                   Row(
    //                     children: [
    //                       const Icon(
    //                         Icons.favorite,
    //                         color: Colors.red,
    //                       ),
    //                       const SizedBox(width: TSizes.xs),
    //                       Text(
    //                         '120',
    //                         style: Theme.of(context).textTheme.titleMedium,
    //                       ),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               const SizedBox(height: TSizes.sm),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     THelperFunctions.truncateText('오늘 세차 맛집 다녀 왔습니다! 너무 깨끗했고 시설도 좋았습니다.', 15),
    //                     style: Theme.of(context).textTheme.bodyMedium,
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
