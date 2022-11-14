import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Components.dart';

import 'Constants.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).userModel;

    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,states){},
      builder: (context,states){
      return ConditionalBuilder(
          condition: SocialCubit.get(context).userModel != null,
          builder:(context)=> SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                      ) ,
                    ),
                  ),
                  if(states is SocialGetPostsLoadingState)
                    Center(child: CircularProgressIndicator()),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context , index) => Components.postTile(SocialCubit.get(context).allPosts[index] ,userModel! ,  context , index),
                      itemCount: SocialCubit.get(context).allPosts.length,

                    )

                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()));
    },
    );
  }
}
