//以下はSAMPLEで入れているだけ
class NoInternetException {
  String title;
  String message;

  NoInternetException(this.title, this.message);
}

class NoResultException {
  String title;
  String message;

  NoResultException(this.title, this.message);
}

class NoTextException {
  String title;
  String message;

  NoTextException(this.title, this.message);
}

//その他のエラー（このアプリではリクエスト過多が基本）
class UnknownException {
  String title;
  String message;

  UnknownException(this.title, this.message);
}
