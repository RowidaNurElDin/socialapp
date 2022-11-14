import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialapp/Components.dart';

import '../Cubits/SocialCubit/cubit.dart';
import '../Cubits/SocialCubit/states.dart';
import 'Constants.dart';
import 'home_screen.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var postController = TextEditingController();



    return BlocConsumer<SocialCubit,SocialStates>
      (listener: (context,states){},
        builder: (context,states){

        var userModel = SocialCubit.get(context).userModel;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Components.defaultAppBar('Create Post',[TextButton(
                onPressed: (){
                  var now = DateTime.now();
                  if(SocialCubit.get(context).postImage == null){
                    SocialCubit.get(context).createNewPost(
                        dateTime: now.toString() ,
                        post: postController.text);
                  }else{
                    SocialCubit.get(context).createPostWithImage(
                        dateTime: now.toString(),
                        post: postController.text);
                    
                  }
                  
                },
                child: const Text("Post" ,
                  style: TextStyle(
                      color: Colors.green
                  ),))], context),),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if(states is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel!.image!),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left : 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Text(userModel!.name??"User name",
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black
                              ),),

                          ],
                        ),
                      ),
                    )

                  ],
                ),
                Expanded(
                  child: TextField(
                    controller: postController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                      decoration: InputDecoration(
                        hintText: "What's on your mind, ${userModel.name}?",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[500],
                          overflow: TextOverflow.ellipsis,
                        ),
                       border: InputBorder.none
                      ),
                    ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                              image:FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,

                            )
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Constants.mainColor,
                          radius: 20,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: (){
                                SocialCubit.get(context).removePostImage();
                              },
                              alignment: Alignment.center,
                              icon: Icon(IconlyBroken.delete ,
                                color: Constants.mainColor,
                                size: 20,
                              ) ,
                            ),

                          ),
                        ),
                      )
                    ],
                  ),

                const Divider(thickness: 1,),
                Row(
                  children: [
                    Icon(IconlyBroken.image , color: Constants.mainColor,),
                    TextButton(
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Text("Add Photo" ,
                          style: TextStyle(
                              color: Constants.mainColor
                          ),))
                  ],
                )
              ],
            ),
          ),
        );
      });
  }
}
