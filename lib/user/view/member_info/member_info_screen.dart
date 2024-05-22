import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/user/model/memberInfoDto.dart';
import 'package:carwash/user/provider/myProduct_provider.dart';
import 'package:carwash/user/repository/myProduct_repository.dart';
import 'package:carwash/user/view/member_info/widget/member_info_car_wash_goods_widget.dart';
import 'package:carwash/user/view/member_info/widget/member_info_car_wash_seq_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberInfoScreen extends ConsumerStatefulWidget {
  final String nickname;
  MemberInfoScreen({
    required this.nickname,
    Key? key}) : super(key: key);

  @override
  ConsumerState<MemberInfoScreen> createState() => _MemberInfoScreenState();
}

class _MemberInfoScreenState extends ConsumerState<MemberInfoScreen> {

  late MemberInfoDto member;

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: FutureBuilder(
          future: _init(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
            if (snapshot.hasData == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '유저 정보 불러오는중...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    const SizedBox(height: 20,),
                    CircularProgressIndicator()
                  ],
                ),
              );
            }
            //error가 발생하게 될 경우 반환하게 되는 부분
            else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              );
            }
            // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
            else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///----------------------------------------------------------
                  /// 유저정보
                  ///----------------------------------------------------------
                  TRoundedContainer(
                    backgroundColor: PRIMARY_COLOR,
                    radius: 0,
                    padding: const EdgeInsets.all(TSizes.defalutSpace),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            /// 유저 사진
                            const TRoundedImage(
                              imageUrl: 'asset/img/profile_image.png',
                              borderRadius: 100,
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.nickname,
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '1단계 환자',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems),

                            /// 팔로우 버튼
                            GestureDetector(
                              onTap: () => THelperFunctions.showAlert(context, '', '업데이트 예정입니다.'),
                              child: TRoundedContainer(
                                padding: const EdgeInsets.all(TSizes.md),
                                radius: 10,
                                // showBorder: true,
                                backgroundColor: Colors.indigoAccent,
                                child: Text(
                                  '팔로우',
                                  style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //const SizedBox(height: TSizes.spaceBtwItems),
                        // 추후 업데이트 예정
                        // TRoundedContainer(
                        //   backgroundColor: Colors.transparent,
                        //   padding: const EdgeInsets.all(TSizes.md),
                        //   showBorder: true,
                        //   borderColor: Colors.white,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       Column(
                        //         children: [
                        //           Text(
                        //             '팔로워',
                        //             style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                        //           ),
                        //           const SizedBox(height: TSizes.xs),
                        //           Text(
                        //             '0',
                        //             style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                        //           ),
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             '팔로잉',
                        //             style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                        //           ),
                        //           const SizedBox(height: TSizes.xs),
                        //           Text(
                        //             '0',
                        //             style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                        //           ),
                        //         ],
                        //       ),
                        //       Column(
                        //         children: [
                        //           Text(
                        //             '게시물',
                        //             style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                        //           ),
                        //           const SizedBox(height: TSizes.xs),
                        //           Text(
                        //             '0',
                        //             style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  ///----------------------------------------------------------
                  /// 세차 용품, 세차 순서
                  ///----------------------------------------------------------
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(TSizes.defalutSpace),
                        child: Column(
                          children: [

                            ///----------------------------------------------------------
                            /// 세차 용품
                            ///----------------------------------------------------------
                            MemberInfoCarWashGoodsWidget(myProduct: member.myProduct,),

                            SizedBox(height: TSizes.spaceBtwSections),

                            Divider(thickness: 0.5),

                            SizedBox(height: TSizes.spaceBtwSections),

                            ///----------------------------------------------------------
                            /// 세차 순서
                            ///----------------------------------------------------------
                            member.record == ''
                            ? MemberInfoCarWashSeqWidget(records: [])
                            :
                            MemberInfoCarWashSeqWidget(records: member.record.split("[")[1].split("]")[0].split(",")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
      )
    );
  }

  Future<String> _init() async {
    member = await ref.read(myProductRepositoryProvider).getUserInfo(nickname: widget.nickname);
    return 'Call Data';
  }
}


