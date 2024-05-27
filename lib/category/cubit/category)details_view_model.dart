import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/category/cubit/states.dart';

class CategoryDetailsViewModel extends Cubit<CubitStates> {
  CategoryDetailsViewModel() : super(CubitInitialState());

//  todo: handle logic

  void getSourceResponse(String categoryId) async {
    try {
      emit(CubitLoadingState());
      var response = await ApiManager.getResponse(categoryId);
      if (response!.status == "error") {
        emit(CubitErrorState(errorMessage: response.message));
        return;
      }
      if (response.status == "ok") {
        emit(CubitSourceSuccessState(sourceList: response.sources));
        return;
      }
    } catch (e) {
      emit(CubitErrorState(errorMessage: e.toString()));
    }
  }
}
