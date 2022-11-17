import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/Cubits/SocialCubit/cubit.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Screens/Constants.dart';
import 'package:socialapp/Screens/register_screen.dart';

import 'Models/UserModel.dart';
import 'Models/like_model.dart';
import 'Models/post_model.dart';
import 'Screens/chat_details_screen.dart';
import 'Screens/home_screen.dart';

class Components{

  static Widget mobileLogo() => Container(
    width: 140,
    child: Image.asset('assets/logo.png'),
  );

  static Widget myTextField(TextEditingController controller , text , Icon icon) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: TextField(

      controller: controller,
      onChanged: (value) {},
      decoration: InputDecoration(
        fillColor: Colors.white,
          filled: true,
          prefixIcon: icon,
          hintText: text,
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
            BorderRadius.all(Radius.circular(30.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey[500]!, width: 1.0),
            borderRadius:BorderRadius.all(Radius.circular(30.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.orange[200]!, width: 3.0),
            borderRadius:BorderRadius.all(Radius.circular(30.0)),
          )
      ),
    ),
  );

  static Widget passTextField(TextEditingController controller , text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: TextField(
      obscureText: true,
      controller: controller,
      onChanged: (value) {},
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon:  Icon(Icons.password, color: Colors.orange[200]),
          hintText: text,
          // ignore: prefer_const_constructors
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(30)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey[500]!, width: 1.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.orange[200]!, width: 3.0),
            borderRadius:BorderRadius.all(Radius.circular(30.0)),
          )),
    ),
  );

  static Widget myText(String txt) =>Text(txt , style: TextStyle(fontSize: 15),);

  static Widget myButton(String txt , Function function) => Padding(
    padding: const EdgeInsets.symmetric(vertical:8.0),
    child: Container(
      width: 1282,
      child: ElevatedButton(
          onPressed: function as void Function()?,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              txt,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Poppins"
              ),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF6FB3B1)),

              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0xFF6FB3B1)))))),
    ),
  );

  static Widget otherOption(String preTxt , String txt , context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(preTxt ,
        style: TextStyle(
            color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
      TextButton(onPressed:(){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => SocialRegister()));
      },
          child: Text(txt,
            style: TextStyle(
                color: Constants.mainColor,
                fontWeight: FontWeight.bold
            ),))
    ],
  );

  static Widget myDivider() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Expanded(
        child: Divider(
          indent: 20.0,
          endIndent: 10.0,
          thickness: 1,
        ),
      ),
      Text(
        "or continue with",
        style: TextStyle(color: Colors.blue),
      ),
      Expanded(
        child: Divider(
          indent: 10.0,
          endIndent: 20.0,
          thickness: 1,
        ),
      ),
    ],
  );

  static showToastFunction(String txt , bool isGreen){
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: isGreen == true ? Colors.green : Colors.redAccent,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  static Widget postTile(PostModel post , UserModel user ,context
      , index , TextEditingController commentController) => Card(

    elevation: 12,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0 , right: 12 , top: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:NetworkImage(post.image!),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left : 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.name! ,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          ),),
                        SizedBox(height: 5,),
                        Text(post.dateTime! ,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[700]
                          ),),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
          const Divider(

            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.post! ,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800]
              ),),
          ),
          if(post.postImage != "")
            Center(
                child:
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(post.postImage!),
                )
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:(){

                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        builder: (context){
                          return Container(
                              height: 350,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(30),
                                      topEnd: Radius.circular(30)
                                  )
                              ),
                              child: post.likes.isNotEmpty ? ListView.separated(
                                  itemBuilder: (context , index){
                                    return Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Stack(
                                              alignment: AlignmentDirectional.bottomEnd,
                                              children: [
                                                CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage: NetworkImage(post.likes[index].image!)),
                                                CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: Colors.red[500],
                                                  child: Icon(IconlyBroken.heart ,
                                                      color: Colors.white,
                                                      size: 14
                                                  ) ,

                                                ),

                                              ],
                                            ),
                                            SizedBox(width: 10,),
                                            Text(post.likes[index].name!)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context,index)=> SizedBox(height: 5,),
                                  itemCount: post.likes.length)
                                  : Center(child:Text("No likes yet."))


                          );
                        } );
                  },

                  child: Row(children: [
                    Icon(IconlyBroken.heart, size: 20, color: Colors.red,),
                    Text(" ${post.likes.length} Likes" , style: TextStyle(
                        fontSize: 12 ,
                        color: Colors.grey[700],
                        fontFamily: 'Roboto'
                    ),),
                  ],),
                ),
                InkWell(
                  onTap: (){
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        isScrollControlled: true,
                        enableDrag: true,
                        builder: (context){
                          return Container(

                              height: 350,

                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(30),
                                      topEnd: Radius.circular(30)
                                  ),

                              ),
                              margin: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom),

                              child: Padding(
                                padding:  const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if(post.comments.isNotEmpty)
                                      Expanded(
                                        child: ListView.separated(
                                            itemBuilder: (context , index){
                                              return  Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 18,
                                                    backgroundImage:NetworkImage(post.comments[index].image!),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left : 5.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(post.comments[index].name! ,
                                                            overflow: TextOverflow.fade,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors.black
                                                            ),),
                                                          SizedBox(height: 5,),
                                                          Text(post.comments[index].text! ,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color: Colors.black
                                                            ),),
                                                        ],
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              );
                                            },
                                            physics: BouncingScrollPhysics(),
                                            separatorBuilder: (context,index)=> const Divider(thickness: 1,),
                                            itemCount: post.comments.length),
                                      )
                                    else
                                      Spacer(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            keyboardType: TextInputType.multiline,
                                            maxLines: null,
                                            controller : commentController ,
                                            decoration: InputDecoration(
                                              hintText: "write comment .. ",
                                              hintStyle: TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey[500],
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                                  borderSide: BorderSide(color: Constants.mainColor!, width: 1.0)),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Color(0xFFF78D82), width: 3.0),
                                                borderRadius:BorderRadius.all(Radius.circular(30.0)),
                                              ),
                                              contentPadding: const EdgeInsets.all(5),

                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                              SocialCubit.get(context).addComment(
                                                  text: commentController.text,
                                                  postID: SocialCubit.get(context).postsIDs[index]);
                                              commentController.clear();
                                              FocusManager.instance.primaryFocus?.unfocus();
                                            },
                                            icon: Icon(IconlyBroken.send, color: Constants.mainColor,))
                                      ],
                                    )

                                  ],
                                ),
                              )

                          );
                        } );
                  },
                  child: Row(
                    children: [
                      Row(children: [
                        Icon(Icons.chat_bubble_outline_outlined,
                            size: 20,
                            color: Constants.mainColor),
                        Text("  ${post.comments.length} Comments" , style: TextStyle(
                            fontSize: 12 ,
                            color: Colors.grey[700],
                            fontFamily: 'Roboto'
                        ),)
                      ],),

                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(

            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0 , bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(user.image!),
                    ),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            isScrollControlled: true,
                            builder: (context){
                              return Container(
                                  height: 350,
                                  margin: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadiusDirectional.only(
                                          topStart: Radius.circular(30),
                                          topEnd: Radius.circular(30)
                                      )
                                  ),
                                  child: Padding(
                                    padding:  const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if(post.comments.isNotEmpty)
                                          Expanded(
                                            child: ListView.separated(
                                                itemBuilder: (context , index){
                                                  return  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 18,
                                                        backgroundImage:NetworkImage(post.comments[index].image!),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left : 5.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(post.comments[index].name! ,
                                                                overflow: TextOverflow.fade,
                                                                style: const TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors.black
                                                                ),),
                                                              SizedBox(height: 5,),
                                                              Text(post.comments[index].text! ,
                                                                style: const TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors.black
                                                                ),),
                                                            ],
                                                          ),
                                                        ),
                                                      )

                                                    ],
                                                  );
                                                },
                                                physics: BouncingScrollPhysics(),
                                                separatorBuilder: (context,index)=> const Divider(thickness: 1,),
                                                itemCount: post.comments.length),
                                          )
                                        else
                                          Spacer(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                keyboardType: TextInputType.multiline,
                                                maxLines: null,
                                                controller : commentController ,
                                                decoration: InputDecoration(
                                                  hintText: "write comment .. ",
                                                  hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.grey[500],
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                                      borderSide: BorderSide(color: Constants.mainColor!, width: 1.0)),
                                                  focusedBorder: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: Color(0xFFF78D82), width: 3.0),
                                                  borderRadius:BorderRadius.all(Radius.circular(30.0)),
                                                  ),
                                                  contentPadding: const EdgeInsets.all(5),

                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                  SocialCubit.get(context).addComment(
                                                      text: commentController.text,
                                                      postID: SocialCubit.get(context).postsIDs[index]);
                                                  commentController.clear();
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                },
                                                icon: Icon(IconlyBroken.send, color: Constants.mainColor,))
                                          ],
                                        )

                                      ],
                                    ),
                                  )

                              );
                            } );
                      },
                      child: Text("write a comment..." ,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 10,
                            color: Colors.grey[700]
                        ),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: (){
                        print(SocialCubit.get(context).postsIDs.length);
                        SocialCubit.get(context).likePost(
                           postID : SocialCubit.get(context).postsIDs[index]);
                      },
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon( post.isLiked == false ? IconlyBroken.heart : IconlyBold.heart , color: Colors.red, size: 15,),
                          Text(post.isLiked == false ?" Like" : " Unlike", style: TextStyle(
                              fontSize: 10 ,
                              color: Colors.grey[700],
                              fontFamily: 'Roboto'
                          ),)
                        ],
                      ),
                    )
                  ],
                ),



              ],
            ),
          ),



        ],
      ),

    ),
  );

  static Widget defaultAppBar(String title, List<Widget> actions , BuildContext context , Color color)=> AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(title ,
    style: TextStyle(
      color: Constants.mainColor,
      fontWeight: FontWeight.bold
    ),),
    leading: IconButton(
      icon: Icon(IconlyBroken.arrowLeftCircle , color: color , size: 30,),
      onPressed: (){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => SocialHomeScreen()));
      },
    ),
    actions: actions,
  );

  static Widget chatTile(UserModel userModel , context) =>
      InkWell(
    onTap: (){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => ChatDetailsScreen(thisUserModel: userModel,)));

    },
    child: Card(
      color: Constants.mainColor!.withOpacity(0.5),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:NetworkImage(userModel.image!),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0 , left: 8),
                  child: Text(userModel.name! ,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),
                ),
              ],
            ),
        ),
    ),
  );

  static Widget notMyMessage(String? txt) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(15),
                bottomEnd: Radius.circular(15),
                bottomStart:  Radius.circular(15)
            ),
            color:  Color(0xFFF78D82).withOpacity(0.2)

        ),
        child: Padding(
          padding:const EdgeInsets.all(8.0),
          child: Text(txt!,),
        ),
      ),
    ),
  );

  static Widget myMessage(String? txt) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(15),
                bottomEnd: Radius.circular(15),
                bottomStart:  Radius.circular(15)
            ),
            color: Constants.mainColor!.withOpacity(0.2)

        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            txt!,
          ),
        ),
      ),
    ),
  );
}