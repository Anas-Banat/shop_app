import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // To do the below methods and then do await method

  Bloc.observer = MyBlocObserver(); // To folow up the app
  DioHelper.init();
  await CacheHelper.init(); // To save a small data as a cache

  //bool? isDark = CacheHelper.getData(key: 'isDark');
  //runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubitMode()
            ..changeAppMode(
              formShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<ShopCubitMode, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            // For Light Theme
            theme: lightTheme,

            // For Dark Theme
            darkTheme: darkTheme,
            themeMode: ShopCubitMode.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light, // light or dark,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
