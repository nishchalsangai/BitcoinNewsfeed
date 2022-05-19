import 'package:flutter/material.dart';

class News {
  late final Map _source;
  late final String _author;
  late final String _title;
  late final String _description;
  late final String _url;
  late final String _urlToImage;
  late final String _publishedAt;
  late final String _content;
  News({
    required Map source,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) {
    _source = source;
    _title = title;
    _author = author;
    _description = description;
    _url = url;
    _urlToImage = urlToImage;
    _publishedAt = publishedAt;
    _content = content;
  }

  factory News.fromJSON(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return News(
          source: {},
          author: "",
          description: "",
          url: "",
          urlToImage: "",
          publishedAt: "",
          content: "",
          title: "");
    } else {
      return News(
          source: json["source"],
          author: json["author"],
          description: json["description"],
          url: json["url"],
          urlToImage: json["urlToImage"],
          publishedAt: json["publishedAt"],
          content: json["content"],
          title: json["title"]);
    }
  }

  Map get source {
    if (_source.isEmpty) {
      return {};
    }
    return _source;
  }

  String get sourceName {
    if (_source["name"].isEmpty) {
      return "unknown";
    }
    return _source["name"];
  }

  String get author {
    if (_author.isEmpty) {
      return "unknown";
    }
    return _author;
  }

  String get title {
    if (_title.isEmpty) {
      return "unknown";
    }
    return _title;
  }

  String get description {
    if (_description.isEmpty) {
      return "unknown";
    }
    return _description;
  }

  String get url {
    if (_url.isEmpty) {
      return "unknown";
    }
    return _url;
  }

  String get urlToImage {
    if (_urlToImage.isEmpty) {
      return "unknown";
    }
    return _urlToImage;
  }

  String get publishedAt {
    if (_publishedAt.isEmpty) {
      return "unknown";
    }
    return _publishedAt;
  }

  String get content {
    if (_content.isEmpty) {
      return "unknown";
    }
    return _content;
  }
}

/*
class Source {
  final String _id;
  final String _name;
  Source(this._id, this._name);
  String get id {
    if (_id.isEmpty) {
      return "";
    }
    return _id;
  }

  String get name {
    if (_name.isEmpty) {
      return "";
    }
    return _name;
  }
}
*/
