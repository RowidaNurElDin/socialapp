import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/LoginCubit/cubit.dart';
import 'package:socialapp/Cubits/LoginCubit/states.dart';
import '../Components.dart';
import 'Constants.dart';

class SocialLogin extends StatelessWidget {

  var emailController = TextEditingController() ;
  var passController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit , LoginStates>(
      listener: (context, states){},
      builder: (context, states){
        return  Scaffold(
          body:  Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("LOGIN" ,
                      style: TextStyle(
                          color: Constants.mainColor,
                          fontSize: 50
                      ),),
                  ),
                ),
                Components.myTextField(emailController,
                "Please enter your email" , Icon(Icons.email)),
                Components.passTextField(passController,
                    "Please enter your password"),
                Components.myButton("Login", (){
                  LoginCubit.get(context).userLogin(
                      email: emailController.text, password: passController.text,context: context);
                }),
                Components.myDivider(),
                Components.otherOption("Don't have an account?", "REGISTER" , context)

              ],

            ),
          ),
        );
      },
    );
  }
}
