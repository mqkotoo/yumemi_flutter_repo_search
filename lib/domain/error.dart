//以下はSAMPLEで入れているだけ
class NoInternetException {
  String message;

  NoInternetException(this.message);
}

class NoTextException {
  String message;

  NoTextException(this.message);
}

//その他のエラー（このアプリではリクエスト過多が基本）
class UnknownException {
  String message;

  UnknownException(this.message);
}
