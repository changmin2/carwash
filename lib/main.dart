import 'package:carwash/common/theme/theme.dart';
import 'package:carwash/weather/provider/weather_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'common/provider/go_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting();
  runApp(
      ProviderScope(child: _App())
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final router = ref.watch(routerProvider);

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

