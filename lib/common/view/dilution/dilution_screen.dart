import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../component/rounded_container.dart';
import '../../layout/default_layout_v2.dart';

class DilutionScreen extends StatefulWidget {
  const DilutionScreen({Key? key}) : super(key: key);

  @override
  State<DilutionScreen> createState() => _DilutionScreenState();
}

class _DilutionScreenState extends State<DilutionScreen> {
  var water = '';
  var dilution = '';
  var chemical = '';

  final _waterFormKey = GlobalKey<FormState>();
  final _dilutionFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defalutSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "물 용량",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: PRIMARY_COLOR),
                  ),
                  Text(
                    "을 입력하시면 ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "희석비율",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: PRIMARY_COLOR),
                  ),
                  Text(
                    "에 맞춰",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),

              Row(
                children: [
                  Text(
                    "케미컬 용량",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.redAccent),
                  ),
                  Text(
                    "을 계산하여 보여줍니다.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
          
              const SizedBox(height: TSizes.spaceBtwSections),
          
              /// 물용량 라벨
              Text(
                '물 용량(ml)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
          
              const SizedBox(height: TSizes.spaceBtwInputFields),

              Form(
                key: _waterFormKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: '물 용량을 입력해주세요.',
                  ),
                  onChanged: (String value) {
                    water = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "물 용량을 입력해주세요.";
                    }
                  },
                ),
              ),
          
              const SizedBox(height: TSizes.spaceBtwSections),
          
              /// 희석비율 라벨
              Text(
                '희석 비율(1:500 이면 500 입력)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
          
              const SizedBox(height: TSizes.spaceBtwInputFields),
          
              /// 희석비율
              Form(
                key: _dilutionFormKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: '희석 용량을 입력해주세요.',
                  ),
                  onChanged: (String value) {
                    dilution = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "희석 비율을 입력해주세요.";
                    }
                  },
                ),
              ),
          
              const SizedBox(height: TSizes.spaceBtwSections),
          
              /// 케미컬 용량 계산 하기 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_waterFormKey.currentState!.validate() && _dilutionFormKey.currentState!.validate()) {
                      setState(() {
                        chemical = (int.parse(water) / int.parse(dilution)).toStringAsFixed(2);
                      });
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: const Text("케미컬 용량 계산하기"),
                ),
              ),
          
              const SizedBox(height: TSizes.spaceBtwSections * 2),
          
              /// 희석비율
              TRoundedContainer(
                width: double.infinity,
                radius: TSizes.buttonRadius,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: const Color(0xff2F80ED),
                child: Column(
                  children: [
                    Text(
                      "케미컬 용량",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                    ),
          
                    const SizedBox(height: TSizes.spaceBtwItems),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chemical,
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "ml",
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
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
  }
}
