import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/LoginCubit/states.dart';
import 'package:socialapp/Shared%20Prefrences/shared_pref.dart';

import '../../Components.dart';
import '../../Screens/Constants.dart';
import '../../Screens/home_screen.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void userLogin({@required email, @required password , @required context}) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print("HELLO");
      print("Login successful");
      print(value.user!.email);
      print(value.user!.uid);
      uID = value.user!.uid;
      CacheHelper.saveData(key: 'uID', value: value.user!.uid);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => SocialHomeScreen()));

          emit(LoginSuccessState());

    }).catchError((error) {

      if( error is FirebaseAuthException){
        Components.showToastFunction(error.message.toString(), false);
        print(error.code);
        emit(LoginErrorState());
      }

    });
  }




}