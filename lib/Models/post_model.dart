import 'package:firebase_auth/firebase_auth.dart';

import 'UserModel.dart';
import 'comment_model.dart';
import 'like_model.dart';

class PostModel{
  String? name;
  String? uID;
  String? image;
  String? dateTime;
  String? post;
  String? postImage;
  List<LikeModel> likes =[];
  List<CommentModel> comments=[];
  bool? isLiked = false;

  PostModel(
      { this.name,
    this.uID,
    this.image,
    this.dateTime,
    this.post,
    this.postImage,
      this.isLiked,
      });

  PostModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    uID = json['uID'];
    image = json['image'];
    dateTime = json['dateTime'];
    post = json['post'];
    postImage = json['postImage'];
    isLiked = json['isLiked'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uID' : uID,
      'image' : image,
      'dateTime' : dateTime,
      'post' : post ,
      'postImage' : postImage,
      'likes' : likes,
      'comments' : comments,
      'isLiked':isLiked
    };
  }
}
