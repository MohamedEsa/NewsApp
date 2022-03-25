import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappprox/layout/newsApp/cubit/states.dart';
import 'package:newsappprox/modules/news_App/search/search_screen.dart';

import 'package:newsappprox/shared/components/components.dart';
import 'package:newsappprox/shared/network/local/cache_helper.dart';
import 'package:provider/provider.dart';

import 'cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewsCubit>(context);
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) {},
        builder: (
          context,
          states,
        ) {
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.brightness_2_outlined),
                  onPressed: () async {
                    var isDark = provider.changeTheme();

                    print('from button $isDark');
                  },
                )
              ],
            ),
            body: provider.screens[provider.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.currentIndex,
              items: provider.bottomItems,
              onTap: (index) {
                provider.changeBottomNav(index);
              },
            ),
          );
        });
  }
}
