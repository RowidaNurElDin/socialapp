import 'package:firebase_auth/firebase_auth.dart';

class CommentModel{
  String? uID;
  String? text;


  CommentModel(
      {this.uID,this.text});

  CommentModel.fromJson(Map<String,dynamic> json){
    uID = json['uID'];
    text = json['text'];

  }

  Map<String,dynamic> toMap(){
    return {
      'uID' : uID,
      'text' : text,
    };
  }
}
