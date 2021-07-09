// Class for the user to be used in the app
// NOTE: Not used right now
class OurUser {
  final String uid;

  //Constructer for the class
  OurUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final String phoneNumer;
  final String bio;
  final String imageUrl;
  final String accountType;

  UserData(
      {this.uid,
      this.name,
      this.email,
      this.phoneNumer,
      this.bio,
      this.imageUrl,
      this.accountType});

  UserData newDummyUser() {
    return UserData(
        uid: '6vDpKqvPuJTaqRd8jahe7texRVI2',
        name: 'Namn',
        email: 'E-post',
        phoneNumer: 'Telefonnummer',
        bio: 'Övrigt',
        accountType: 'inactiv');
  }
}

class UserJob {
  String userID;
  String userName;
  String profilePickLink;
  bool isSelected;
  bool isReserve;

  UserJob(
      {this.userID,
      this.userName,
      this.profilePickLink,
      this.isSelected,
      this.isReserve});
}
