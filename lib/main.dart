import 'package:carwash/common/theme/theme.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'common/provider/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async{
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting();
  KakaoSdk.init(nativeAppKey: '7d131476e9dd71890bf99ffa94dec12d'); // 이 줄을 runApp 위에 추가한다.

  runApp(
      const ProviderScope(child: _App())
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final router = ref.watch(routerProvider);
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    // final state = ref.watch(secureStorageProvider);
    // state.deleteAll();
    return MaterialApp.router(
      // 시스템 설정에 따른 Theme
      // themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

