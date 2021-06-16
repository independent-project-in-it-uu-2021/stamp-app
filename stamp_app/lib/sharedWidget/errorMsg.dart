class ErrorMessage {
  final String errorMsg;
  ErrorMessage({this.errorMsg});

  String getMessageFromErrorCode() {
    switch (errorMsg) {
      case 'ERROR_REQUIRES_RECENT_LOGIN':
      case 'requires-recent-login':
        return 'Vänligen logga in på nytt för kunna ändra mejladress';
        break;

      default:
        return 'Inloggning misslyckades';
        break;
    }
  }
}
