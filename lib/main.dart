import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'module/coin_detail/coin_detail_bloc.dart';
import 'module/home/coin/category/category_bloc.dart';
import 'module/home/coin/coin_bloc.dart';
import 'module/home/explore/explore_bloc.dart';
import 'module/home/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CoinBloc>(create: (_) => CoinBloc()),
      BlocProvider(create: (_) => CategoryBloc()),
      BlocProvider(create: (_) => CoinDetailBloc()),
      BlocProvider(create: (_) => ExploreBloc()),
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
        home: const HomeScreen(),
      ),
    ),
  ));
}
