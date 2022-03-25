import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsappprox/shared/bloc_observer.dart';
import 'package:newsappprox/shared/network/local/cache_helper.dart';
import 'package:newsappprox/shared/network/remote/dio_helper.dart';
import 'package:newsappprox/shared/styles/themes.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'layout/newsApp/cubit/cubit.dart';
import 'layout/newsApp/cubit/states.dart';
import 'layout/newsApp/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');
  print(isDark);
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return
        // navigatorKey: navigatorKey,
        MultiBlocProvider(
            providers: [
          BlocProvider(
            create: (context) => NewsCubit()
              ..getBusinessdata()
              ..changeTheme(fromShared: isDark),
          )
        ],
            child: BlocConsumer<NewsCubit, NewsStates>(
                listener: ((context, state) {}),
                builder: (context, state) => MaterialApp(
                      themeMode: ThemeMode.light,
                      darkTheme: darkTheme,
                      theme: NewsCubit.get(context).isDark
                          ? darkTheme
                          : lightTheme,
                      home: NewsLayout(),
                    )));
    //  startWidget

    //
  }
}
