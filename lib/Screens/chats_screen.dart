import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Components.dart';

import '../Cubits/SocialCubit/cubit.dart';
import '../Cubits/SocialCubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).userModel;
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, states){},
        builder: (context,states){
          return ConditionalBuilder(
              condition: SocialCubit.get(context).allUsers.length >0,
              builder: (context)=> ListView.separated(
                itemBuilder: (context , index) => Components.chatTile(SocialCubit.get(context).allUsers[index],context),
                itemCount: SocialCubit.get(context).allUsers.length,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context , index) => Divider(thickness: 1,),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(),));

        });
  }
}
