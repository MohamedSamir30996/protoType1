import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/NewsApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/NewsApp/Cubit/States.dart';
import 'package:udemy_start/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var list = NewsCubit.get(context).business!;

        return ArticleBuilder(list,context);
      },

    );
  }
}
