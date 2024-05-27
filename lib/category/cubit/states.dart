import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/sourceResponse.dart';

abstract class CubitStates {}

class CubitInitialState extends CubitStates {}

class CubitLoadingState extends CubitStates {}

class CubitErrorState extends CubitStates {
  String? errorMessage;

  CubitErrorState({required this.errorMessage});
}

class CubitSourceSuccessState extends CubitStates {
  List<Source>? sourceList;

  CubitSourceSuccessState({required this.sourceList});
}

class CubitNewsSuccessState extends CubitStates {
  List<News>? newsList;

  CubitNewsSuccessState({required this.newsList});
}

class CubitSourceTabIndexState extends CubitStates {}

class CubitSelectedTabBarState extends CubitStates {}

class CubitUnSelectedTabBarState extends CubitStates {}
