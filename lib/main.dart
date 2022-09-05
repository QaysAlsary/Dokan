import 'package:e_commerce/home/home_cubit.dart';
import 'package:e_commerce/home/shope_layout.dart';
import 'package:e_commerce/main_states.dart';
import 'package:e_commerce/onBoarding/on_boarding_screen.dart';
import 'package:e_commerce/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants.dart';
import 'dio_helper.dart';
import 'login/login.dart';
import 'main_cubit.dart';
import 'models/cache_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  var isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  var onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  if(onBoarding!=null)
    {
      if(token !=null){
        widget=ShopeLayout();
      }
      else{
        widget= Login();
      }
    }else{
    widget=OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark,this.startWidget});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=> MainCubit(),
        ),
        BlocProvider(
            create: (context)=> ShopeCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
        ),
      ],
      child: BlocConsumer<MainCubit,MainStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme ,
            darkTheme: darkTheme ,
            themeMode: MainCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startWidget,
          );
        },

      ),
    );


  }
}

