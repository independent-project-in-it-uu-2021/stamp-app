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
        uid: 'Användare Id',
        name: 'Namn',
        email: 'E-post',
        phoneNumer: 'Telefonnummer',
        bio: 'Övrigt',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/stamp-db6ad.appspot.com/o/userProfilePicture%2Fprofile-user.png?alt=media&token=170630ba-bccf-4bd7-b50b-9d5e08f01a73',
        accountType: 'inactiv');
  }
}
