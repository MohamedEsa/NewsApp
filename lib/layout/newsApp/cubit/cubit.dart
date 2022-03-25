import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappprox/layout/newsApp/cubit/states.dart';

import 'package:newsappprox/modules/news_App/business/business_screen.dart';
import 'package:newsappprox/modules/news_App/science/science_screen.dart';
import 'package:newsappprox/modules/news_App/search/search_screen.dart';
import 'package:newsappprox/modules/news_App/sports/sports_screen.dart';
import 'package:newsappprox/shared/network/remote/dio_helper.dart';

import '../../../shared/network/local/cache_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  bool isSearch = false;
  bool isDark = false;

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    if (index == 1) getSportssdata();
    if (index == 2) getSciencesdata();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  void getBusinessdata() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '8f195c4195e54aa99cf28dae0e4e9034'
    }).then((value) {
      print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['publishedAt']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState());
    });
  }

  void getSportssdata() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '6983d3f9e36c48c78a6a83236e94af86'
      }).then((value) {
        print(value.data.toString());
        sports = value.data['articles'];
        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportErrorState());
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  void getSciencesdata() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '6983d3f9e36c48c78a6a83236e94af86'
      }).then((value) {
        print(value.data.toString());
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState());
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    isSearch = true;

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '6983d3f9e36c48c78a6a83236e94af86'
    }).then((value) {
      print(value.data.toString());
      search = value.data['articles'];
      isSearch = false;
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });

    emit(NewsGetSearchSuccessState());
  }

  Future<bool> changeTheme({bool? fromShared}) async {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
    }
    await CacheHelper.sharedPreferences.setBool('isDark', isDark);
    emit(ThemeChangeState());

    return isDark;
  }
}
