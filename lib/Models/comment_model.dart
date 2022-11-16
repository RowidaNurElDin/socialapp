import 'package:firebase_auth/firebase_auth.dart';

class CommentModel{
  String? uID;
  String? name;
  String? image;
  String? text;
  String? postID;


  CommentModel(
      {this.uID, this.name , this.image , this.text , this.postID});

  CommentModel.fromJson(Map<dynamic,dynamic> json){
    name = json['name'];
    uID = json['uID'];
    image = json['image'];
    text = json['text'];
    postID = json['postID'];

  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uID' : uID,
      'image' : image,
      'text' : text,
      'postID' : postID,
    };
  }
}
