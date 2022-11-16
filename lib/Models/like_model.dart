import 'package:firebase_auth/firebase_auth.dart';

class LikeModel{
  String? uID;
  String? name;
  String? image;
  String? postID;
  String? likeID;

  LikeModel(
      {this.uID, this.name , this.image , this.postID , this.likeID});

  LikeModel.fromJson(Map<dynamic,dynamic> json){
    name = json['name'];
    uID = json['uID'];
    image = json['image'];
    postID = json['postID'];
    likeID = json['uID'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uID' : uID,
      'image' : image,
      'postID' : postID,
    };
  }
}
