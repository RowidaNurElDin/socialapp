import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Models/UserModel.dart';

import '../Components.dart';
import 'Constants.dart';
import 'home_screen.dart';

class ChatDetailsScreen extends StatelessWidget {

  UserModel? thisUserModel ;
  var now = DateTime.now();
  var messageController = TextEditingController();
  ChatDetailsScreen(
      {Key? key, this.thisUserModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context){
          SocialCubit.get(context).getMessages(receiverID: thisUserModel!.uID!);

          return BlocConsumer<SocialCubit , SocialStates>
            ( listener: (context,states){},
            builder: (context,states){
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  backgroundColor: Constants.mainColor!.withOpacity(0.8),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:NetworkImage(thisUserModel!.image!),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0 , left: 8),
                        child: Text(thisUserModel!.name! ,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          ),),
                      ),
                    ],
                  ),
                  leading: IconButton(
                    icon: Icon(IconlyBroken.arrowLeftCircle , color: Colors.white,),
                    onPressed: (){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) => SocialHomeScreen()));
                    },
                  ),
                ) ,
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      if(states is SocialGetMessagesLoadingState)
                         Center(child: CircularProgressIndicator(color: Constants.mainColor!)),
                      if(SocialCubit.get(context).messages.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                              itemBuilder: (context,index) {
                                var msg = SocialCubit.get(context).messages[index];
                                if(uID == msg.senderID) {
                                  return Components.myMessage(msg.message);
                                } else {
                                  return Components.notMyMessage(msg.message);
                                }

                              },
                            physics: BouncingScrollPhysics(),
                            itemCount:SocialCubit.get(context).messages.length ,
                          ),
                        )
                      else
                        Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              controller: messageController,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "message",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[500],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(color: Constants.mainColor!, width: 1.0)),
                                focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color:  Color(0xFFF78D82), width: 3.0),
                                borderRadius:BorderRadius.all(Radius.circular(30.0)),
                                ),
                                contentPadding: const EdgeInsets.all(5),

                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                                SocialCubit.get(context).sendMessage(
                                    receiverID: thisUserModel!.uID!,
                                    dateTime: now.toString(),
                                    message: messageController.text
                                );
                                messageController.clear();
                                FocusManager.instance.primaryFocus?.unfocus();

                              },
                              icon: Icon(IconlyBroken.send, color: Constants.mainColor,))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },

          );
        });
  }
}
