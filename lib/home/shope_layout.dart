import 'package:e_commerce/home/home_cubit.dart';
import 'package:e_commerce/home/home_states.dart';
import 'package:e_commerce/models/cache_helper.dart';
import 'package:e_commerce/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/login.dart';

class ShopeLayout extends StatelessWidget {
  const ShopeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Dokan'),
            actions: [
              IconButton(
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(),),);
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,

                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,

                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,

                ),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,

                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
