import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/states.dart';
import 'package:todo_app/modules/news_app/business/business_screen.dart';
import 'package:todo_app/modules/news_app/science/science_screen.dart';
import 'package:todo_app/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:todo_app/modules/news_app/sports/sport_screen.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int correntIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomBar(int index) {
    correntIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(newsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      //print(value.data['articales'][0]['title']);
      business = value.data['articales'];
      print(business.length);
      print(business[0]['title']);

      emit(newsGetBusinessSuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(newsGetBusinessErrorState(err.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(newsGetSportLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        //print(value.data['articales'][0]['title']);
        sports = value.data['articales'];
        print(sports.length);
        print(sports[0]['title']);

        emit(newsGetSportSuccessState());
      }).catchError((err) {
        print(err.toString());
        emit(newsGetSportErrorState(err.toString()));
      });
    } else {
      emit(newsGetSportSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(newsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        //print(value.data['articales'][0]['title']);
        science = value.data['articales'];
        print(science.length);
        print(science[0]['title']);

        emit(newsGetScienceSuccessState());
      }).catchError((err) {
        print(err.toString());
        emit(newsGetScienceErrorState(err.toString()));
      });
    } else {
      emit(newsGetScienceSuccessState());
    }
  }

  bool isDark = false;
  void changeAppMode({bool? formShared}) {
    if (formShared != null) {
      isDark = formShared;
      emit(newsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(newsChangeModeState());
      });
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(newsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      //print(value.data['articales'][0]['title']);
      science = value.data['articales'];
      print(science.length);
      print(science[0]['title']);

      emit(newsGetSearchSuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(newsGetSearchErrorState(err.toString()));
    });
  }
}
