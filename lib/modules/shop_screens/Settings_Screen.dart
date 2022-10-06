import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/States.dart';
import 'package:udemy_start/shared/components/components.dart';
import 'package:udemy_start/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children:
                  [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultFormField(
                      controller: nameController,
                      textType: TextInputType.name,
                      valid: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      lable: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultFormField(
                      controller: emailController,
                      textType: TextInputType.emailAddress,
                      valid: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }

                        return null;
                      },
                      lable: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultFormField(
                      controller: phoneController,
                      textType: TextInputType.phone,
                      valid: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }

                        return null;
                      },
                      lable: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultButton(
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        }
                      },
                      text: 'update',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultButton(
                      function: () {
                        SignOut(context);
                      },
                      text: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}