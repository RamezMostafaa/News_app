import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/category/cubit/states.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/sourceResponse.dart';
import 'package:news_app/news/cubit/news_view_model.dart';
import 'package:news_app/news/news_item.dart';
import 'package:news_app/theme/my_theme.dart';

class NewsWidget extends StatefulWidget {
  Source source;
  List<News> news = []; // Initialize with an empty list
  Function onTap;

  NewsWidget({required this.source, super.key, required this.onTap}) {
    news = [];
  }

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsViewModel viewModel = NewsViewModel();

  @override
  void initState() {
    // TODO: implement initState

    viewModel.getNewsBySourceId(widget.source.id ?? "", "1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;
    return BlocBuilder<NewsViewModel, CubitStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is CubitNewsSuccessState) {
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
              return NewsItem(
                newObject: state.newsList![index],
                onTap: widget.onTap,
                onSearchTap: () {},
              );
            },
            itemCount: state.newsList!.length,
          );
        } else if (state is CubitSourceTabIndexState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${viewModel.selectedIndex}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.getNewsBySourceId(widget.source.id ?? "", "1");
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
                    viewModel.getNewsBySourceId(widget.source.id ?? "", "1");
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
