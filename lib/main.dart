import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/home_layout.dart';
import 'package:news_app/shared/bloc_opserver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/shared/network/local/shared_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/cubit.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedHelper.init();
  bool? fromShared = SharedHelper.getBoolean(key: 'isDark');
  bool? x = fromShared;
  runApp(MyApp(x));
}

class MyApp extends StatelessWidget {
  final bool? fromShared;
  MyApp(this.fromShared);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience()..getTechnology()..changeMode(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context,state){},
        builder: (context,state){ return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.red,
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,


            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrangeAccent,
              backgroundColor: Colors.white,
              elevation: 20.0,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: HexColor('3d3d3d'),
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('#DD6E0F'),
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: HexColor('3d3d3d'),
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,


            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrangeAccent,
              unselectedItemColor: Colors.grey,
              backgroundColor: HexColor('3d3d3d'),
              elevation: 20.0,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: NewsLayout(),
        );},
      ),
    );
  }
}
