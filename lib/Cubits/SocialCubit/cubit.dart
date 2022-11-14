import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Cubits/SocialCubit/states.dart';
import 'package:socialapp/Models/UserModel.dart';
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
    for (int i = 0; i < allPosts.length; i++) {
      if (allPosts[i].uID == uID) {
        myPosts.add(allPosts[i]);
      }
    }
  }

  List<LikeModel> tmpLikesList = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('allPosts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          //  likes.add(value.docs.length);

          var likesList = value.docs.map((e) {
            Map value = e.data();
          //  value['uID'] = e.id;
            tmpLikesList.add(LikeModel.fromJson(value));
            return value;
          }).toList();
          print(likesList);
          PostModel tmpPost = PostModel.fromJson(element.data());

          for (LikeModel like in tmpLikesList) {
            tmpPost.likes.add(like);
            // print(allUsers.length);
            // for (UserModel user in allUsers) {
            //   print("inside loop");
            //   print(like.uID);
            //   print(user.uID);
            //   if (like.uID == user.uID) {
            //     print("inside if");
            //     UserModel newUser = user;
            //     print(newUser.name);
            //     tmpPost.likers.add(newUser);
            //   }
            // }
          }

          postsIDs.add(element.id);
          allPosts.add(tmpPost);
          getMyPosts();
          tmpLikesList.clear();
          //print(tmpPost.likes.length);
        }).catchError((error) {});
      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  // void getMyPosts(){
  //   emit(SocialGetPostsLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uID)
  //       .collection('myPosts').get().then((value){
  //     value.docs.forEach((element) {
  //       myPosts.add(PostModel.fromJson(element.data()));
  //     });
  //
  //     emit(SocialGetPostsSuccessState());
  //   }).catchError((error){
  //
  //     print(error);
  //     emit(SocialGetPostsErrorState(error.toString()));
  //
  //   });
  // }

  void likePost(String postID) {
    print(postsIDs.length);

    FirebaseFirestore.instance
        .collection('allPosts')
        .doc(postID)
        .collection('likes')
        .doc(uID)
        .set({'like': true}).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsSuccessState());
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