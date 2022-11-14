import 'package:firebase_auth/firebase_auth.dart';

class LikeModel{
  String? uID;
  String? name;
  String? image;


  LikeModel(
      {this.uID, this.name , this.image});

  LikeModel.fromJson(Map<dynamic,dynamic> json){
    name = json['name'];
    uID = json['uID'];
    image = json['image'];  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uID' : uID,
      'image' : image,
    };
  }
}
