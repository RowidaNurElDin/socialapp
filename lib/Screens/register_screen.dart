import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubits/RegisterCubit/cubit.dart';
import '../Cubits/RegisterCubit/states.dart';
import '../Components.dart';
import 'Constants.dart';

class SocialRegister extends StatelessWidget {

  var usernameController = TextEditingController() ;
  var emailController = TextEditingController() ;
  var passController = TextEditingController() ;
  var phoneController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit , RegisterStates>(
      listener: (context, states){},
      builder: (context, states){
        return  Scaffold(
          body:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("REGISTER" ,
                        style: TextStyle(
                            color: Constants.mainColor,
                            fontSize: 50
                        ),),
                    ),
                  ),
                  Components.myTextField(
                      usernameController,
                      "Please enter your username",
                    Icon(Icons.person_rounded)
                  ),
                  Components.myTextField(
                      emailController,
                      "Please enter your email",
                      Icon(Icons.email)
                  ),
                  Components.passTextField(passController,
                      "Please enter your password"),
                  Components.myTextField(
                      phoneController,
                      "Please enter your phone number",
                      Icon(Icons.phone)
                  ),
                  Components.myButton("Register", (){
                    RegisterCubit.get(context).userRegister(
                        email: emailController.text,
                        password: passController.text,
                      phone: phoneController.text,
                      name: usernameController.text,
                      context: context
                    );
                  }),

                ],

              ),
            ),
          ),
        );
      },
    );
  }
}
