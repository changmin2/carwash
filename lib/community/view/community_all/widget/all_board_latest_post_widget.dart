import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/model/community_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../community_detail_screen.dart';

class TCommunityAllLatestPostWidget extends StatelessWidget {
  final CommunityModel model;

  const TCommunityAllLatestPostWidget({
    super.key,
    required this.model
  });
  @override
  Widget build(BuildContext context) {
    var imgs = '';
    model.imgUrls?.length != 0
        ?
    imgs = model.imgUrls!.split('[')[1].split(']')[0].split(",")[0]
        : null;
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CommunityDetailScreen(
              id: model.id,
            )
          ),
        );

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 게시판 종류 라벨
                TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.xs),
                  radius: 5,
                  showBorder: true,
                  borderColor: model.category == '세차라이프' ? PRIMARY_COLOR
                  : model.category == '질문게시판' ? const Color(0xffE9C46A) : const Color(0xffF4A261),
                  child: Text(
                    model.category,
                    style: model.category == '세차라이프' ? Theme.of(context).textTheme.labelMedium!.apply(color: PRIMARY_COLOR)
                    : model.category == '질문게시판' ? Theme.of(context).textTheme.labelMedium!.apply(color: const Color(0xffE9C46A))
                    : Theme.of(context).textTheme.labelMedium!.apply(color: const Color(0xffF4A261)),
                  ),
                ),
                const SizedBox(height: TSizes.sm),

                /// 제목
                SizedBox(
                  width: 250,
                  child: Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: TSizes.sm),

                /// 닉네임
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(
                    model.creator,
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          imgs == ''
          ? Container()
          :
          /// 사진
          Expanded(
            child: TRoundedImage(
              imageUrl: imgs,
              width: 70,
              height: 70,
              fit: BoxFit.fill,
              borderRadius: 12.0,
              isNetworkImage: true,
            ),
          ),
          const SizedBox(width: 4)
        ],
      ),
    );
  }
}
