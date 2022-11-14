import 'package:firebase_auth/firebase_auth.dart';

class MessageModel{
  String? senderID;
  String? receiverID;
  String? dateTime;
  String? message;


  MessageModel({this.senderID, this.receiverID, this.dateTime, this.message});

  MessageModel.fromJson(Map<String,dynamic> json){
    senderID = json['senderID'];
    receiverID = json['receiverID'];
    dateTime = json['dateTime'];
    message = json['message'];
  }

  Map<String,dynamic> toMap(){
    return {

      'senderID' : senderID,
      'receiverID' : receiverID,
      'dateTime' : dateTime,
      'message' : message ,

    };
  }
}
