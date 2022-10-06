import 'package:flutter/material.dart';
import 'package:udemy_start/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var testController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  DefaultFormField(
                      controller: emailController,
                      lable: "Email Address",
                      prefix: Icons.mail,
                      textType: TextInputType.emailAddress,
                      valid: (String? value){
                        if(value!.isEmpty){
                          return 'Email must not be empty';
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  DefaultFormField(
                    controller: passwordController,
                    lable: "Password",
                    prefix: Icons.lock,
                    textType: TextInputType.visiblePassword,
                    isPassword: isPassword,
                    suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                    suffixChange: (){
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },

                    valid: (String? value){
                      if(value!.isEmpty){
                        return 'Password must not be empty';
                      }
                      return null;
                    }
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: testController,
                      validator: (String? value){
                      setState(() {
                        if(value!.startsWith('1')&&value.isNotEmpty){
                          return null;
                        }
                        enabled = false ;
                      });
                      },

                    enabled: enabled,
                  ),

                  DefaultButton(
                    text: "login",
                    function: ()
                      {
                        if(formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      }
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
