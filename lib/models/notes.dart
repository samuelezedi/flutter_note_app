import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Notes clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Notes.fromMap(jsonData);
}

String linksToJson(Notes data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Notes {
  String title;
  String content;
  Timestamp timestamp;
  String userId;
  Timestamp updated;

  Notes({
    this.title,
    this.content,
    this.timestamp,
    this.userId,
    this.updated
  });

  factory Notes.fromMap(Map<String, dynamic> json) => new Notes(
      title: json["title"],
      content: json["content"],
      timestamp: json["timestamp"],
      userId: json["userId"],
      updated: json['updated']
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "content": content,
    "timestamp": timestamp,
    "userId": userId,
    "updated": updated,
  };
}