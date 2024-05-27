import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/category/cubit/category)details_view_model.dart';
import 'package:news_app/category/cubit/states.dart';
import 'package:news_app/category/tab_widget.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/theme/my_theme.dart';

class CategoryDetails extends StatefulWidget {
  CategoryDM? category;

  Function onTap;

  CategoryDetails({super.key, required this.category, required this.onTap});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    viewModel.getSourceResponse(widget.category?.id ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;

    return BlocBuilder<CategoryDetailsViewModel, CubitStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is CubitSourceSuccessState) {
          return TabWidget(
            sourcesList: state.sourceList!,
            onTap: widget.onTap,
          );
        } else if (state is CubitErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.errorMessage!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.getSourceResponse(widget.category?.id ?? "");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: Text(
                    _appLocalization.try_again,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: MyTheme.primaryLightColor),
          );
        }
      },
    );
  }
}
