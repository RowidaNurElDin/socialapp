abstract class SocialStates {}

class SocialInitState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates{}

class SocialAddPostState extends SocialStates{}


//GET USER STATES
class SocialGetDataSuccessState extends SocialStates{}

class SocialGetDataErrorState extends SocialStates{
  String? error ;
  SocialGetDataErrorState(this.error);
}

//GET ALL USERS STATES
class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates{
  String? error ;
  SocialGetAllUsersErrorState(this.error);
}

//GET POSTS STATES
class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{
  String? error ;
  SocialGetPostsErrorState(this.error);
}


//LIKE POSTS STATES
class SocialLikePostsSuccessState extends SocialStates{}

class SocialLikePostsErrorState extends SocialStates{
  String? error ;
  SocialLikePostsErrorState(this.error);
}


// EDITING PROFILE STATES
class SocialUpdateProfilePicSuccessState extends SocialStates{}

class SocialUpdateProfilePicErrorState extends SocialStates{}

class SocialUpdateCoverPicSuccessState extends SocialStates{}

class SocialUpdateCoverPicErrorState extends SocialStates{}

class SocialUploadProfilePicSuccessState extends SocialStates{}

class SocialUploadProfilePicErrorState extends SocialStates{}

class SocialUploadCoverPicSuccessState extends SocialStates{}

class SocialUploadCoverPicErrorState extends SocialStates{}

class SocialUpdateUSERErrorState extends SocialStates{}

class SocialUpdateUserLoadingState extends SocialStates{}


//POST CREATION STATES
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialUploadPostPicLoadingState extends SocialStates{}

class SocialUploadPostPicSuccessState extends SocialStates{}

class SocialUploadPostPicErrorState extends SocialStates{}

class SocialRemovePostPicState extends SocialStates{}


//MESSAGES STATES
class SocialGetMessagesLoadingState extends SocialStates{}

class SocialGetMessagesSuccessState extends SocialStates{}

class SocialGetMessagesErrorState extends SocialStates{
  String? error ;
  SocialGetMessagesErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{
  String? error ;
  SocialSendMessageErrorState(this.error);
}