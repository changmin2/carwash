import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';
import '../provider/user_me_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username ='';
  String password ='';

  final _idFormKey = GlobalKey<FormState>();
  final _psFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 16,right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              SizedBox(
                width: 800,
                height: 350,
                child: Image.asset(
                  'asset/img/login.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ID'
                  )
              ),
              SizedBox(
                  height: 10
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password'
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                width: 400,
                child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,

                    ),
                    child: Text(
                        'login'
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
