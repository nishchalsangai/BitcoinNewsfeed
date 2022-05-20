import 'News.dart';

class Bookmarks {
  late String _bookMarksId;
  late String _userId;
  late Map _news;
  late int _bookmarkAddedTime;

  Bookmarks(
      {required String bookMarksId,
      required String userId,
      required Map news,
      required int bookmarkAddedTime}) {
    _bookMarksId = bookMarksId;
    _userId = userId;
    _news = news;
    _bookmarkAddedTime = bookmarkAddedTime;
  }

  factory Bookmarks.fromMap(Map data) {
    return Bookmarks(
        bookMarksId: data["bookmarkId"],
        userId: data["userId"],
        news: data["news"],
        bookmarkAddedTime: data["bookmarkAddedTime"]);
  }

  String get bookMarksId {
    return _bookMarksId;
  }

  String get userId {
    return _userId;
  }

  Map get news {
    return _news;
  }

  int get bookmarkAddedTime {
    return _bookmarkAddedTime;
  }
}
