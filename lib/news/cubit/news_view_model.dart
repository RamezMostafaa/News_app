import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/category/cubit/states.dart';

class NewsViewModel extends Cubit<CubitStates> {
  NewsViewModel() : super(CubitInitialState());
  int selectedIndex = 0;

//    todo: handle logic

  void getNewsBySourceId(String sourceId, String page) async {
    emit(CubitLoadingState());
    var response =
        await ApiManager.getNewsBySourceId(sourceId: sourceId, page: page);

    try {
      if (response?.status == "error") {
        emit(CubitErrorState(errorMessage: response?.message));
        return;
      }
      if (response?.status == "ok") {
        emit(CubitNewsSuccessState(newsList: response?.news));
        return;
      }
    } catch (e) {
      emit(CubitErrorState(errorMessage: e.toString()));
    }
  }

  void updateSelectedIndex(int lastIndex) {
    selectedIndex = lastIndex;
    emit(CubitSourceTabIndexState());
  }

  bool isSelected(int sourceIndex) {
    if (selectedIndex == sourceIndex) {
      return true;
    } else {
      return false;
    }
  }
}
