import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Screens/home_screen.dart';
import 'package:socialapp/Screens/splash_screen.dart';
import 'package:socialapp/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Cubits/LoginCubit/cubit.dart';
import 'Cubits/RegisterCubit/cubit.dart';
import 'Screens/Constants.dart';
import 'Shared Prefrences/shared_pref.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget ;
  //uID = CacheHelper.getData(key: 'uID');
  print(uID);

  if(uID == null){
    widget = SplashScreen();
  }else{
    widget = SocialHomeScreen();
  }
  runApp(SocialMain(startWidget: widget,));
}

class SocialMain extends StatelessWidget {
  final Widget? startWidget ;

  SocialMain({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getAllUsers())


      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:startWidget

        ,
      ),
    );
  }
}
