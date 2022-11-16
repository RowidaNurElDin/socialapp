import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Models/UserModel.dart';
import 'package:socialapp/Models/comment_model.dart';
import 'package:socialapp/Models/like_model.dart';
import 'package:socialapp/Screens/chats_screen.dart';
import 'package:socialapp/Screens/new_post_screen.dart';
import 'package:socialapp/Screens/settings_screen.dart';
import 'package:socialapp/Screens/timeline_screen.dart';
import 'package:socialapp/Screens/users_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../Models/message_model.dart';
import '../../Models/post_model.dart';
import '../../Screens/Constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  String profileImageUrl = '';
  String coverImageUrl = '';
  var picker = ImagePicker();
  UserModel? userModel;
  File? profileImage;
  File? coverImage;
  File? postImage;
  List<String> titles = ["Timeline", "Chats", "", "Users", "Settings"];
  List<Widget> screens = [
    TimelineScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<PostModel> allPosts = [];
  List<PostModel> myPosts = [];
  List<int> likes = [];
  List<String> postsIDs = [];
  List<UserModel> allUsers = [];
  List<MessageModel> messages = [];
  List<LikeModel> tmpLikesList = [];


  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uID).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialGetDataSuccessState());
    }).catchError((error) {
      emit(SocialGetDataErrorState(error));
    });
  }

  void changeBottomNavIndex(int index) {
    // if (index == 1) {
    //   getAllUsers();
    // }
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  Future<void> getProfileImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(SocialUpdateProfilePicSuccessState());
    } else {
      print("NO IMAGE SELECTED");
    }
  }

  Future<void> getCoverImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(SocialUpdateCoverPicSuccessState());
    } else {
      print("NO IMAGE SELECTED");
    }
  }

  void uploadProfileImage(
      {required String name, required String phone, required String bio}) {
    firebaseStorage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        UserModel newUser = UserModel(
            name: name,
            phone: phone,
            bio: bio,
            email: userModel!.email,
            cover: userModel!.cover,
            image: profileImageUrl,
            uID: userModel!.uID,
            isEmailVerified: false);
        uploadInFirestore(newUser: newUser);

        emit(SocialUploadProfilePicSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfilePicErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfilePicErrorState());
    });
  }

  void uploadCoverImage(
      {required String name, required String phone, required String bio}) {
    firebaseStorage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        UserModel newUser = UserModel(
            name: name,
            phone: phone,
            bio: bio,
            email: userModel!.email,
            cover: coverImageUrl,
            image: userModel!.image,
            uID: userModel!.uID,
            isEmailVerified: false);
        uploadInFirestore(newUser: newUser);

        emit(SocialUploadCoverPicSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverPicErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverPicErrorState());
    });
  }

  void updateUserData({
    @required name,
    @required phone,
    @required bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    if (coverImage != null && profileImage != null) {
      uploadCoverImage(name: name, phone: phone, bio: bio);
      uploadProfileImage(name: name, phone: phone, bio: bio);
      UserModel newUser = UserModel(
          name: name,
          phone: phone,
          bio: bio,
          email: userModel!.email,
          cover: coverImageUrl,
          image: profileImageUrl,
          uID: userModel!.uID,
          isEmailVerified: false);
      uploadInFirestore(newUser: newUser);
    } else if (coverImage == null && profileImage != null) {
      uploadProfileImage(name: name, phone: phone, bio: bio);
      print(profileImageUrl);
    } else if (coverImage != null && profileImage == null) {
      uploadCoverImage(name: name, phone: phone, bio: bio);
    } else {
      UserModel newUser = UserModel(
          name: name,
          phone: phone,
          bio: bio,
          email: userModel!.email,
          cover: userModel!.cover,
          image: userModel!.image,
          uID: userModel!.uID,
          isEmailVerified: false);
      uploadInFirestore(newUser: newUser);
    }
  }

  void uploadInFirestore({required UserModel newUser}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .update(newUser.toMap())
        .then((value) {
      print("Before get datataa");
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUSERErrorState());
    });
  }

  Future<void> getPostImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(SocialUploadPostPicSuccessState());
    } else {
      print("NO IMAGE SELECTED");
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostPicState());
  }

  //Create post if I uploaded an image in the post
  void createPostWithImage({
    required String dateTime,
    required String post,
  }) {
    emit(SocialCreatePostLoadingState());

    firebaseStorage.FirebaseStorage.instance
        .ref()
        .child('allPosts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createNewPost(dateTime: dateTime, post: post, postImg: value);

        emit(SocialUploadPostPicSuccessState());
      }).catchError((error) {
        emit(SocialUploadPostPicErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostPicErrorState());
    });
  }

  //Create post without an Image
  void createNewPost(
      {required String dateTime, required String post, String? postImg}) {
    emit(SocialCreatePostLoadingState());

    PostModel newPost = PostModel(
      name: userModel!.name,
      uID: userModel!.uID,
      image: userModel!.image,
      dateTime: dateTime,
      post: post,
      isLiked: false,
      postImage: postImg ?? "",
    );

    FirebaseFirestore.instance
        .collection('allPosts')
        .add(newPost.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void getMyPosts() {
    myPosts = [];
    for (int i = 0; i < allPosts.length; i++) {
      if (allPosts[i].uID == uID) {
        myPosts.add(allPosts[i]);
      }
    }
  }

  // void getPosts() {
  //   emit(SocialGetPostsLoadingState());
  //   FirebaseFirestore
  //       .instance
  //       .collection('allPosts')
  //       .get()
  //       .then((value) {
  //     for (var element in value.docs) {
  //       element.reference.collection('likes').get().then((value) {
  //         var likesList = value.docs.map((e) {
  //           Map value = e.data();
  //           tmpLikesList.add(LikeModel.fromJson(value));
  //           return value;
  //         }).toList();
  //         print(likesList);
  //         PostModel tmpPost = PostModel.fromJson(element.data());
  //
  //         for (LikeModel like in tmpLikesList) {
  //           if(like.uID == uID) {
  //             tmpPost.isLiked= true;
  //           }
  //           tmpPost.likes.add(like);
  //         }
  //
  //         postsIDs.add(element.id);
  //         allPosts.add(tmpPost);
  //         getMyPosts();
  //         tmpLikesList.clear();
  //         //print(tmpPost.likes.length);
  //       }).catchError((error) {});
  //     }
  //     emit(SocialGetPostsSuccessState());
  //   }).catchError((error) {
  //     print(error);
  //     emit(SocialGetPostsErrorState(error.toString()));
  //   });
  // }



  void getPosts() {
   // allPosts = [];
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore
        .instance
        .collection('allPosts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          allPosts = [];
      event.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          var likesList = value.docs.map((e) {
            Map value = e.data();
            tmpLikesList.add(LikeModel.fromJson(value));
            return value;
          }).toList();
          print(likesList);
          PostModel tmpPost = PostModel.fromJson(element.data());

          for (LikeModel like in tmpLikesList) {
            if(like.uID == uID) {
              tmpPost.isLiked= true;
            }
            tmpPost.likes.add(like);
          }

          postsIDs.add(element.id);
          allPosts.add(tmpPost);
          getMyPosts();
          tmpLikesList.clear();
        }).catchError((error) {
          emit(SocialLikePostsErrorState(error));
        });
      });
    });
  }

  // void likePost(String postID) {
  //
  //   for(int i = 0 ; i < allPosts.length ; i++){
  //     print("in loop");
  //     if(postsIDs[i] == postID){
  //       print("found post");
  //       print(allPosts[i].isLiked);
  //       if(allPosts[i].isLiked == false){
  //         print("in like if");
  //         FirebaseFirestore.instance
  //             .collection('allPosts')
  //             .doc(postID)
  //             .collection('likes')
  //             .doc(uID)
  //             .set({'uID': uID , 'name' : userModel!.name , 'image' : userModel!.image}).then((value) {
  //           FirebaseFirestore.instance.collection('allPosts').doc(postID).update({'isLiked' : true});
  //               allPosts[i].isLiked = true;
  //           print("like");
  //           emit(SocialLikePostsSuccessState());
  //         }).catchError((error) {
  //           print("like error");
  //           emit(SocialLikePostsSuccessState());
  //         });
  //
  //       }
  //       else if(allPosts[i].isLiked  == true){
  //         print("in unlike if");
  //         FirebaseFirestore.instance
  //             .collection('allPosts')
  //             .doc(postID)
  //             .collection('likes').doc(uID).delete().then((value) {
  //           FirebaseFirestore.instance.collection('allPosts').doc(postID).update({'isLiked' : false});
  //
  //           allPosts[i].isLiked  = false;
  //           print("unlike");
  //           emit(SocialUnlikePostsSuccessState());
  //         }).catchError((error) {
  //           print("unlike error");
  //
  //           emit(SocialUnlikePostsSuccessState());
  //         });
  //       }
  //
  //
  //
  //     }
  //
  //   }
  // }

  void likePost({required String postID})
  {
    for(int i = 0 ; i < allPosts.length ; i++){
      if(postsIDs[i] == postID){

        if(allPosts[i].isLiked == false){
        FirebaseFirestore.instance
                      .collection('allPosts')
                      .doc(postID)
                      .collection('likes')
                      .doc(uID)
                      .set({'uID': uID ,
                            'name' : userModel!.name ,
                            'image' : userModel!.image}).then((value) {
                    FirebaseFirestore
                        .instance
                        .collection('allPosts')
                        .doc(postID).update({'isLiked' : true});
                    emit(SocialLikePostsSuccessState());
          }).catchError((error) {
            emit(SocialLikePostsErrorState(error));
          });
        }

        else if(allPosts[i].isLiked == true){
          FirebaseFirestore.instance
              .collection('allPosts')
              .doc(postID)
              .collection('likes').doc(uID).delete().then((value) {
            FirebaseFirestore
                .instance
                .collection('allPosts')
                .doc(postID)
                .update({'isLiked' : false});
            emit(SocialUnlikePostsSuccessState());
          }).catchError((error) {

            emit(SocialUnlikePostsSuccessState());
          });
        }


      }
    }

  }

  void getPostLikes({required String postID}) {
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('allPosts')
        .doc(postID)
        .collection('likes')
        .snapshots()
        .listen((event) {
      for(int i =0 ; i < allPosts.length ; i++){
        if(postsIDs[i] == postID){
          allPosts[i].likes = [];
          event.docs.forEach((element) {
            allPosts[i].likes.add(LikeModel.fromJson(element.data()));
          });
          emit(SocialGetLikesSuccessState());
        }
      }

    });
  }

  void addComment({
    required String text,
    required String postID}) {

    CommentModel newComment = CommentModel(
      uID: userModel!.uID,
      image: userModel!.image,
      name: userModel!.name,
      text: text,
      postID: postID
    );
    FirebaseFirestore.instance
        .collection('allPosts')
        .doc(postID)
        .collection('comments')
        .add(newComment.toMap())
        .then((value) {
      emit(SocialAddCommentsSuccessState());
    }).catchError((error) {
      emit(SocialAddCommentsErrorState(error));
    });
  }

  void getPostComments({required String postID}) {
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('allPosts')
        .doc(postID)
        .collection('comments')
        .snapshots()
        .listen((event) {
          for(int i =0 ; i < allPosts.length ; i++){
            if(postsIDs[i] == postID){
              allPosts[i].comments = [];
              event.docs.forEach((element) {
                allPosts[i].comments.add(CommentModel.fromJson(element.data()));
              });
              emit(SocialGetCommentsSuccessState());
            }
          }

    });
  }

  void getAllUsers() {
    if (allUsers.length == 0) {
      emit(SocialGetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uID'] != uID) {
            allUsers.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }



  void sendMessage({required String receiverID,
    required String dateTime,
    required String message}) {
    emit(SocialCreatePostLoadingState());

    MessageModel newMessage = MessageModel(
        senderID: uID,
        receiverID: receiverID,
        dateTime: dateTime,
        message: message);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(newMessage.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(uID)
        .collection('messages')
        .add(newMessage.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error));
    });
  }

  void getMessages({required String receiverID}) {
    emit(SocialGetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }


}