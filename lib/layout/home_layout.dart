import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget
{
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states){},
        builder: (context, states){
          var cubit = NewsCubit.get(context);
         return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
              ),
              actions: [
                IconButton(
                    onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Search_Screen()));
                    },
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: (){
                       NewsCubit.get(context).changeMode();
                  },
                ),

              ],
            ),
            body: (
                NewsCubit.get(context).pages[NewsCubit.get(context).currentIndex]
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
              },
              items: NewsCubit.get(context).bottomItems,
            ),
         );
        },
    );
  }
}
