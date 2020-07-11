
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  static searchByName(String searchField) {
    return Firestore.instance.collection('notes')
        .where('userId', isEqualTo: searchField)
        .getDocuments();
  }

  static searchRandom(searchField, collection) {
    return Firestore.instance.collection(collection)
        .where('searchKey', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  static searchDeeper(searchField, forumName, collection) {
    return Firestore.instance.collection(collection)
        .where('forumName', isEqualTo: forumName)
        .where('searchKeyName', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

}