import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/RegisterCubit/states.dart';
import 'package:socialapp/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/Screens/Constants.dart';
import 'package:socialapp/Screens/home_screen.dart';
import 'package:socialapp/Shared%20Prefrences/shared_pref.dart';

import '../../Components.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {@required name,
      @required password,
      @required email,
      @required phone,
      context}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      print("before save");
      //CacheHelper.saveData(key: uID??'' , value:value.user!.uid  );
      uID = value.user!.uid;
      print("after save");
      createUser(
          name: name, email: email, phone: phone, uID: uID, context: context);
      emit(RegisterSuccessState());
    }).catchError((error) {

      if( error is FirebaseAuthException){
        Components.showToastFunction(error.message.toString(), false);
        print(error.code);
        emit(RegisterErrorState());

      }
      print(error.toString());
    });
  }

  void createUser(
      {@required name,
      @required email,
      @required phone,
      @required uID,
      @required context}) {
    UserModel newUser = UserModel(
        name: name,
        email: email,
        phone: phone,
        uID: uID,
        bio: "Add your bio here",
        cover: "https://img.freepik.com/free-vector/set-avatar-silhouettes_23-2147674173.jpg?w=740&t=st=1668242630~exp=1668243230~hmac=7c503eeb02eb73597cafcd6f05f18309c02b62ee3a22ceff56000cf5a3190ea2",
        image: "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1668189983~exp=1668190583~hmac=c28737efa0eb4cd5c2ce56c0ff10edcd62ec9458c093d3a89819725f6f1c6b84",
        isEmailVerified: false);

    print("HERE");

    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(newUser.toMap())
        .then((value) {
      print("before nav");
      uID = uID;
      CacheHelper.saveData(key: 'uID', value: uID);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => SocialHomeScreen()));

      emit(CreateUserSuccessState());
    }).catchError((error) {

     // print(error.toString());
      emit(CreateUserErrorState());

    });
  }
}
