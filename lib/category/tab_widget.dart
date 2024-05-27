import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/category/cubit/states.dart';
import 'package:news_app/category/tab_item.dart';
import 'package:news_app/model/sourceResponse.dart';
import 'package:news_app/news/cubit/news_view_model.dart';
import 'package:news_app/news/news_widget.dart';
import 'package:news_app/theme/my_theme.dart';

class TabWidget extends StatefulWidget {
  List<Source> sourcesList;

  Function onTap;

  TabWidget({required this.sourcesList, super.key, required this.onTap});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  void initState() {
    // TODO: implement initState
    viewModel.getNewsBySourceId(widget.sourcesList[0].id ?? "", "1");
    super.initState();
  }

  NewsViewModel viewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;

    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
                onTap: (index) {
                  viewModel.updateSelectedIndex(index);
                  viewModel.getNewsBySourceId(
                      widget.sourcesList[index].id ?? "", "1");
                },
                indicatorColor: Colors.transparent,
                isScrollable: true,
                tabs: widget.sourcesList.map((source) {
                  return BlocBuilder<NewsViewModel, CubitStates>(
                      bloc: viewModel,
                      builder: (context, state) {
                        return TabItem(
                            source: source,
                            isSelected: viewModel.isSelected(
                                widget.sourcesList.indexOf(source)));
                      });
                }).toList()),
            BlocBuilder<NewsViewModel, CubitStates>(
              bloc: viewModel,
              builder: (context, state) {
                if (state is CubitNewsSuccessState) {
                  return Expanded(
                    child: NewsWidget(
                        source: widget.sourcesList[viewModel.selectedIndex],
                        onTap: widget.onTap),
                  );
                } else if (state is CubitSourceTabIndexState) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${viewModel.selectedIndex}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              viewModel.getNewsBySourceId(
                                  widget.sourcesList[viewModel.selectedIndex]
                                          .id ??
                                      "",
                                  "1");
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: Text(
                              _appLocalization.try_again,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is CubitErrorState) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.errorMessage!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              viewModel.getNewsBySourceId(
                                  widget.sourcesList[viewModel.selectedIndex]
                                          .id ??
                                      "",
                                  "1");
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            child: Text(
                              _appLocalization.try_again,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                          color: MyTheme.primaryLightColor),
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}
