import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:socialapp/Screens/login_screen.dart';
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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80, //this
            leadingWidth: 80, //this
            leading: MaterialButton(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(IconlyBroken.arrowLeftCircle , color: Constants.mainColor , size: 25,),
              ),
              onPressed: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder:
                        (BuildContext context) => SocialLogin()));
              },
            ),
          ),
          body:  Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/wallpaper1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child:Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("REGISTER" ,
                                      style: TextStyle(
                                          color: Constants.mainColor,
                                          fontSize: 50,
                                        fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                ),
                              ),
                            ),
                            Components.myTextField(
                                usernameController,
                                "Please enter your username",
                              Icon(Icons.person_rounded , color: Colors.orange[200])
                            ),
                            Components.myTextField(
                                emailController,
                                "Please enter your email",
                                Icon(Icons.email , color: Colors.orange[200])
                            ),
                            Components.passTextField(passController,
                                "Please enter your password"),
                            Components.myTextField(
                                phoneController,
                                "Please enter your phone number",
                                Icon(Icons.phone , color: Colors.orange[200])
                            ),
                            Components.myButton("Register", (){
                              if(emailController.text == ""
                                  || passController.text == ""
                                  || phoneController.text == ""
                              || usernameController.text == ""
                              ){
                                Components.showToastFunction("Please complete your data.", false);
                              }else{

                                RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passController.text,
                                    phone: phoneController.text,
                                    name: usernameController.text,
                                    context: context
                                );
                              }


                            }),

                          ],

                        ),
                      ),
                    ),
                  ),
          ),
          ),
        ),);
      },
    );
  }
}
