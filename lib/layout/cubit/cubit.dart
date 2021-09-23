import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/technology/technology.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/shared/network/local/shared_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  get error => null;

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_sharp), label: "Business"),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_basketball_sharp), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    BottomNavigationBarItem(icon: Icon(Icons.computer), label: "Technology"),
  ];

  List pages = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    TechnologyScreen(),
  ];


  void changeIndex(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    if (index == 3) {
      getTechnology();
    }

    emit(changeCurrentIndex());
  }

  List<dynamic> business = [];

  void getBusiness() {
    if (business.length == 0) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        path: 'v2/top-headlines',
        queries: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '6dc216ca4c604454b35f5f4629e9a4fb',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccess());
      }).catchError((errors) {
        print(errors.toString());
        emit(NewsGetBusinessFailed(error.toString()));
      });
      emit(NewsGetBusinessSuccess());
    }
  }


  List<dynamic> sports = [];

  void getSports() {
    if (sports.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        path: 'v2/top-headlines',
        queries: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '6dc216ca4c604454b35f5f4629e9a4fb',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccess());
      }).catchError((errors) {
        print(errors.toString());
        emit(NewsGetSportsFailed(error.toString()));
      });
      emit(NewsGetSportsSuccess());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        path: 'v2/top-headlines',
        queries: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '6dc216ca4c604454b35f5f4629e9a4fb',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccess());
      }).catchError((errors) {
        print(errors.toString());
        emit(NewsGetScienceFailed(error.toString()));
      });
      emit(NewsGetScienceSuccess());
    }
  }


  List<dynamic> technology = [];

  void getTechnology() {
    if (technology.length == 0) {
      emit(NewsGetTechnologyLoadingState());
      DioHelper.getData(
        path: 'v2/top-headlines',
        queries: {
          'country': 'eg',
          'category': 'technology',
          'apiKey': '6dc216ca4c604454b35f5f4629e9a4fb',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        technology = value.data['articles'];
        print(technology[0]['title']);
        emit(NewsGetTechnologySuccess());
      }).catchError((errors) {
        print(errors.toString());
        emit(NewsGetTechnologyFailed(error.toString()));
      });
      emit(NewsGetTechnologySuccess());
    }
  }

  List<dynamic> search = [];

  void getSearch(value) {
    emit(NewsLoadingSearch());
    print(value);
    DioHelper.getData(
        queries:
        {
          'q': '$value',
          'apiKey': '6dc216ca4c604454b35f5f4629e9a4fb'
        }, path: 'v2/everything')
        .then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchFailed(error.toString()));
    });
  }


  bool isDark = true;

  void changeMode({bool? fromshared}) {
    if (fromshared != null) {
      isDark = fromshared;
      emit(ChangeMode());
    } else {
      isDark = !isDark;
      SharedHelper.putBoolean(key: 'isDark', val: isDark).then((value) {
        emit(ChangeMode());
      });
    }
  }
}

