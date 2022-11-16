import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Components.dart';

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
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: const [
                          Image(
                            image: NetworkImage(
                              'https://img.freepik.com/free-photo/networking-concept-still-life-arrangement_23-2149035784.jpg?w=1060&t=st=1668172631~exp=1668173231~hmac=d9e2bdc891cba22c6bece791c8c98259826aa8417abec124743170783932790a',
                            ),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              " Stay Connected!",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (states is SocialGetPostsLoadingState)
                    const Center(child: CircularProgressIndicator()),
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
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    });
  }
}
