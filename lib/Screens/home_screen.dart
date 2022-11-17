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
        var socialCubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              socialCubit.titles[socialCubit.currentIndex],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Constants.mainColor
              ),
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconlyBroken.notification , color: Constants.mainColor,)),
            ],
          ),
          body:socialCubit.screens[socialCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xFFF78D82),
            unselectedItemColor: Constants.mainColor!,

            onTap: (index){
              socialCubit.changeBottomNavIndex(index);
            },
            currentIndex: socialCubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon:  Icon(IconlyBroken.home, ) , label: '' ,),
              BottomNavigationBarItem(icon:  Icon(IconlyBroken.chat) , label: ''),
              BottomNavigationBarItem(icon:  Icon(IconlyBroken.profile) , label: ''),

            ],
          ),
        );
        });
  }
}


