import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/LoginCubit/cubit.dart';
import 'package:socialapp/Cubits/LoginCubit/states.dart';
import '../Components.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
          body:  Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/wallpaper1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 1000),
                  childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                  child: widget,),),

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          decoration:const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("LOGIN" ,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  color: Color(0xFF6FB3B1),
                                  fontSize: 50
                              ),),
                          ),
                        ),
                      ),
                    ),
                    Components.myTextField(emailController,
                    "Please enter your email" , Icon(
                            Icons.email , color: Colors.orange[200],
                        )),
                    Components.passTextField(passController,
                        "Please enter your password"),
                    Components.myButton("Login", (){

                      if(emailController.text == "" || passController.text == "" ){
                        Components.showToastFunction("Please complete your data.", false);
                      }else{
                        LoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passController.text,
                            context: context);
                      }

                    }),
                    Components.otherOption("Don't have an account?", "REGISTER" , context)

                  ],

                ),
              ),
            ),
          ),
        ),);
      },
    );
  }
}
