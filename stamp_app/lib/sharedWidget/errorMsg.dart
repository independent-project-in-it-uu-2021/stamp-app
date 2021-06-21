class ErrorMessage {
  final String errorMsg;
  ErrorMessage({this.errorMsg});

  //Method is used in editprofile view
  String erroMessageEditProfile() {
    switch (errorMsg) {
      case 'requires-recent-login':
        return 'Vänligen logga in på nytt för kunna utföra ändringen';
        break;
      case 'email-already-in-use':
        return 'Mejladressen används redan';
        break;
      case 'invalid-email':
        return 'Ogilig mejladress';
        break;
      case 'weak-password':
        return 'Lösenordet är för lätt';
        break;
      default:
        return 'Ändring misslyckades';
        break;
    }
  }

  //Method is used in login view
  String errorMessageLogin() {
    switch (errorMsg) {
      case 'invalid-email':
        return 'Ogilig mejladress';
        break;
      case 'user-not-found':
        return 'E-post eller lösenord är felaktig';
        break;
      case 'wrong-password':
        return 'E-post eller lösenord är felaktig';
        break;
      default:
        return 'Inloggning misslyckades';
        break;
    }
  }
}
