import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Components.dart';
import 'package:socialapp/Screens/edit_profile_screen.dart';
import 'package:socialapp/Screens/new_post_screen.dart';

import 'Constants.dart';

class TimelineScreen extends StatelessWidget {
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Builder(builder: (context){
      var userModel = SocialCubit.get(context).userModel;
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: userModel != null ? Column(
                children: [
                  Card(
                    elevation: 12,
                    color: Colors.transparent,
                    child: Container(
                      height: 120,
                      color: Colors.transparent,
                      child: Stack(
                        children:  [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image(
                              image: NetworkImage(
                                'https://img.freepik.com/free-photo/sea-cloudy-sky-during-breathtaking-colorful-sunset_181624-22489.jpg?w=740&t=st=1668690386~exp=1668690986~hmac=e063600d2476f8bda8f5792540bda4efe44c3a70e0c51af3199c3430d4329bb6',
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                child:
                                TextField(
                                  onTap: (){
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (BuildContext context) => NewPostScreen()));
                                  },
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "What's on your mind?",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 18,
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey[500]!, width: 1.0),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (states is SocialGetPostsLoadingState)
                     Center(child: CircularProgressIndicator(color: Constants.mainColor!,)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      SocialCubit.get(context).getPostComments(
                          postID:
                          SocialCubit.get(context).postsIDs[index]);
                      SocialCubit.get(context).getPostLikes(
                          postID: SocialCubit.get(context).postsIDs[index]);
                      return Components.postTile(
                          SocialCubit.get(context).allPosts[index],
                          userModel,
                          context,
                          index,
                          commentController);
                    },
                    itemCount: SocialCubit.get(context).allPosts.length,
                  ),
                ],
              )
                  :  Center(child: CircularProgressIndicator(color: Constants.mainColor!)),
            ),
          );
        },
      );
    });
  }
}
