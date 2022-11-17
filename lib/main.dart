import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Components.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Screens/home_screen.dart';
import 'package:socialapp/Screens/splash_screen.dart';
import 'package:socialapp/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialapp/Screens/tmp_screen.dart';
import 'Cubits/LoginCubit/cubit.dart';
import 'Cubits/RegisterCubit/cubit.dart';
import 'Screens/Constants.dart';
import 'Shared Prefrences/shared_pref.dart';


Future<void> firebaseBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();

  print("BACKGROUND MESSAGE");

  print(message.data.toString());
  Components.showToastFunction("BACKGROUND MESSAGE" , true);

}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print("TOOKEENNN $token");
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    Components.showToastFunction("ON MESSAGE" , true);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());

    Components.showToastFunction("ON MESSAGE OPENED APP" ,true);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);



  await CacheHelper.init();
  Widget widget ;
  uID = CacheHelper.getData(key: 'uID');
  print(uID);

  if(uID == null){
    widget = TmpScreen();
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
        theme: ThemeData(
          fontFamily: 'Signika',

        ),
        home:startWidget

        ,
      ),
    );
  }
}
