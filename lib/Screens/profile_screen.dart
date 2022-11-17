import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Screens/edit_profile_screen.dart';

import '../Components.dart';
import 'Constants.dart';

class ProfileScreen extends StatelessWidget {

  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<SocialCubit,SocialStates>
      (listener: (context,states){},
      builder: (context,states){

        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                   height: 180,
                   child: Stack(
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel!.cover?? 'https://img.freepik.com/free-vector/colorful-abstract-background_361591-1496.jpg?w=1380&t=st=1668243306~exp=1668243906~hmac=b41caa791581e904632a65bf84f4578709af63269a63b885edbfc15d05fa317f',
                                ),
                                fit: BoxFit.cover,

                              )
                          ),

                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(blurRadius: 8, color: Colors.white, spreadRadius: 5)],
                            ),
                            child:CircleAvatar(
                              radius: 52,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(userModel.image??"https://img.freepik.com/free-photo/pretty-lady-polka-dot-outfit-smiling-pink-wall_197531-23625.jpg?w=1060&t=st=1668174573~exp=1668175173~hmac=f0ddafdd061032727e19a70ba1ec82b54db5704919956f31faf290681df30280"),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                 ),
                const SizedBox(height: 5,),
                Text(userModel.name??"User name" ,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),),
                Text(userModel.bio??" " ,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey
                  ),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text("${SocialCubit.get(context).myPosts.length}",
                                style:const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                              ),),
                              const Text("Posts" , style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                              ),)
                            ],

                    ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: const [
                              Text("0" , style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                              ),),
                              Text("Photos" , style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                              ),)
                            ],

                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: const [
                              Text("0" , style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                              ),),
                              Text("Followers" , style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                              ),)
                            ],

                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: const [
                              Text("0" , style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                              ),),
                              Text("Followings" , style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                              ),)
                            ],

                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 260,
                      child: OutlinedButton(
                          onPressed: (){},
                          child: Text("Add photos",style: TextStyle(color: Constants.mainColor),)),
                    ),
                    OutlinedButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (BuildContext context) =>EditProfileScreen()));
                        },
                        child: Icon(IconlyBroken.edit ,color: Constants.mainColor )),

                  ],
                ),
                if(states is SocialGetPostsLoadingState)
                  CircularProgressIndicator(color: Constants.mainColor!),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index)=> Components.postTile(SocialCubit.get(context).myPosts[index] ,
                      userModel , context , index, commentController),
                  itemCount: SocialCubit.get(context).myPosts.length,

                )

              ],

            ),
          ),
        );
      },

    );
  }
}
