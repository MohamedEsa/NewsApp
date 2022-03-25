import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappprox/layout/newsApp/cubit/cubit.dart';
import 'package:newsappprox/layout/newsApp/cubit/states.dart';
import 'package:newsappprox/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var list = NewsCubit.get(context).search;
          var isSearch = NewsCubit.get(context).isSearch;

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Search Must Not Be Empty !';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: list.length > 0
                      ? ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildItemArticle(
                            list[index],
                            context,
                          ),
                          separatorBuilder: (context, index) => Container(),
                          itemCount: list.length,
                        )
                      : isSearch
                          ? Center(child: CircularProgressIndicator())
                          : Container(),
                ),
              ],
            ),
          );
        });
  }
}
