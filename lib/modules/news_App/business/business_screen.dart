import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappprox/layout/newsApp/cubit/cubit.dart';
import 'package:newsappprox/layout/newsApp/cubit/states.dart';

import 'package:newsappprox/shared/components/components.dart';
import 'package:newsappprox/shared/request_status.dart';
import 'package:provider/provider.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) {},
        builder: (context, states) {
          List list = NewsCubit.get(context).business;
          return list.length > 0
              ? ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildItemArticle(list[index], context),
                  separatorBuilder: (context, index) => Container(),
                  itemCount: list.length,
                )
              : Center(child: CircularProgressIndicator());
        });
  }
}
