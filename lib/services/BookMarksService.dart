import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/Bookmarks.dart';

import '../models/News.dart';

class BookMarksService {
  late CollectionReference _bookmarks;
  late final _userId;

  BookMarksService(String userId) {
    _userId = userId;
    _bookmarks = FirebaseFirestore.instance.collection("BookmarksData");
  }

  Future<String> generateNewBookmark() async {
    return _bookmarks.doc().id;
  }

  Future<String?> addBookmark({
    required String bookmarkId,
    required String userId,
    required Map news,
  }) async {
    try {
      await _bookmarks.doc(bookmarkId).set({
        "bookmarkId": bookmarkId,
        "userId": userId,
        "news": news,
        "bookmarkAddedTime": DateTime.now().microsecondsSinceEpoch
        }).then((value) {
        return "Bookmark Added";
      });
    } on FirebaseException catch (e) {
      return e.message;
    }
    return null;
  }

  Future<String> removeBookmark(String bookmarkId) async {
    try {
      await _bookmarks.doc(bookmarkId).delete().then((value) {
        return "Removed from bookmarks";
      }).catchError((error) {
        return error.toString();
      });
    } catch (ex) {
      return ex.toString();
    }
    return "";
  }

  Future<List<Bookmarks>> get allBookmarks async {
    List<Bookmarks> bookmarkBasket = [];
    await _bookmarks
        .where("userId", isEqualTo: _userId)
        .orderBy("bookmarkAddedTime")
        .get()
        .then((snap) async {
      snap.docs.forEach((bookmarkSnap) =>
          bookmarkBasket.add(Bookmarks.fromMap(bookmarkSnap.data as Map<dynamic, dynamic>)));
    });
    return bookmarkBasket;
  }
}
