import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:socialapp/Components.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialapp/Screens/new_post_screen.dart';
import 'Constants.dart';

class SocialHomeScreen extends StatelessWidget {
  const SocialHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context,states){
        if(states is SocialAddPostState){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => NewPostScreen()));
        }
      },
        builder: (context,states){
        var soialCubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              soialCubit.titles[soialCubit.currentIndex],
              style: TextStyle(
                fontSize: 20,
                color: Constants.mainColor
              ),
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconlyBroken.notification , color: Constants.mainColor,)),
              IconButton(onPressed: (){}, icon: Icon(IconlyBroken.search , color: Constants.mainColor,)),
            ],
          ),
          body:soialCubit.screens[soialCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            onTap: (index){
              soialCubit.changeBottomNavIndex(index);
            },
            currentIndex: 0 ,
            items:[
              BottomNavigationBarItem(icon:  Icon(IconlyBroken.home ,color: Constants.mainColor!, ) , label: '' ,),
              BottomNavigationBarItem(icon:  Icon(IconlyBroken.chat,color: Constants.mainColor!) , label: ''),
              BottomNavigationBarItem(icon:  Icon(IconlyBroken.upload ,color: Constants.mainColor!, ) , label: '' ,),
              BottomNavigationBarItem(icon:  Icon(IconlyBroken.user2,color: Constants.mainColor!) , label: ''),
              BottomNavigationBarItem(icon:  Icon(IconlyBroken.setting,color: Constants.mainColor!) , label: ''),

            ],
          ),
        );
        });
  }
}


