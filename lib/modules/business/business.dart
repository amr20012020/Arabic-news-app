
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/shared/components/components.dart';


class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return Builder_item(list);
      },
    );
  }
}
