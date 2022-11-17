import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Components.dart';

import 'Constants.dart';
import 'home_screen.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>
      (listener: (context,states){},
      builder: (context,states){
        var userModel = SocialCubit.get(context).userModel!;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel.name??"";
        bioController.text = userModel.bio??"";
        phoneController.text = userModel.phone??"";

        return Scaffold(
          appBar:PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Components.defaultAppBar("Edit post",
                [TextButton(
                  onPressed: (){
                    SocialCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone:  phoneController.text,
                        bio: bioController.text);
                  },
                  child: const Text("Update" ,
                    style: TextStyle(
                        color: Colors.green
                    ),))], context,Constants.mainColor!),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(states is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(color: Constants.mainColor!),
                  const SizedBox(height: 5,),
                  Container(
                    height: 180,
                    child: Stack(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  image: DecorationImage(
                                    image: coverImage == null? NetworkImage(userModel.cover!) : FileImage(coverImage) as ImageProvider,
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
                                        SocialCubit.get(context).getCoverImage();
                                      },
                                      alignment: Alignment.center,
                                      icon: Icon(IconlyBroken.camera ,
                                        color: Constants.mainColor,
                                        size: 20,
                                      ) ,
                                    ),

                                  ),
                                ),
                            )
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(blurRadius: 8, color: Colors.white, spreadRadius: 5)],
                                ),
                                child:CircleAvatar(
                                  radius: 52,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: profileImage == null ? NetworkImage(userModel.image!):
                                    FileImage(profileImage) as ImageProvider              ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Constants.mainColor,
                                radius: 15,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: (){
                                      SocialCubit.get(context).getProfileImage();
                                    },
                                    alignment: Alignment.center,
                                    icon: Icon(IconlyBroken.camera ,
                                      color: Constants.mainColor,
                                      size: 14
                                    ) ,
                                  ),

                                ),
                              ),

                            ],
                          ),

                        ),


                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Components.myTextField(
                      nameController,
                      "please enter your name",
                      const Icon(IconlyBroken.user2)),
                  Components.myTextField(
                      bioController,
                      "please enter your bio",
                      const Icon(IconlyBroken.infoCircle)),
                  Components.myTextField(
                      phoneController,
                      "please enter your phone",
                      const Icon(IconlyBroken.call)),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
