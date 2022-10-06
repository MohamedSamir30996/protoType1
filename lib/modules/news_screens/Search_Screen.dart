import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/NewsApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/NewsApp/Cubit/States.dart';
import 'package:udemy_start/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).Search!;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultFormField(controller: searchController,
                    showCursor: true,
                    onChange: (value){
                  NewsCubit.get(context).getSearch(value);
                    },
                    textType: TextInputType.text,
                    lable: "Search",
                    prefix: Icons.search,
                    valid: (String? value){
                      if(value!.isEmpty){
                        print("Gzr");
                      }
                      return null ;
                    }

                ),
              ),
              Expanded(child: ArticleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
