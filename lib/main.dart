import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/provider/provider.dart';
import 'screen/tab_navigation/coin/coin_bloc.dart';
import 'screen/tab_navigation/tab_navigation_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CoinBloc>(
        create: (context) => CoinBloc(coinProvider: CoinProvider()),
      )
    ],
    child: DevicePreview(
      enabled: false,
      builder: (_) => MaterialApp(
        useInheritedMediaQuery: true,
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const TabNavigationScreen(),
      ),
    ),
  ));
}
