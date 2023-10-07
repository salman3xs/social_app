// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PostModel {
  final String id;
  final String author;
  final String img;
  final String content;
  final List<String> mentionedUsers;
  // Constructor
  PostModel({
    required this.id,
    required this.author,
    required this.img,
    required this.content,
    required this.mentionedUsers,
  });

  // Copy constructor
  PostModel copyWith({
    String? id,
    String? author,
    String? img,
    String? content,
    List<String>? mentionedUsers,
  }) {
    return PostModel(
      id: id ?? this.id,
      author: author ?? this.author,
      img: img ?? this.img,
      content: content ?? this.content,
      mentionedUsers: mentionedUsers ?? this.mentionedUsers,
    );
  }

  // Converts the PostModel object to a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
      'img': img,
      'content': content,
      'mentionedUsers': mentionedUsers,
    };
  }

  // Creates a PostModel object from a map
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: (map['id'] ?? '') as String,
      author: (map['author'] ?? '') as String,
      img: (map['img'] ?? '') as String,
      content: (map['content'] ?? '') as String,
      mentionedUsers: List<String>.from((map['mentionedUsers'] ?? const <String>[]) as List<String>),
    );
  }

  // Converts the PostModel object to JSON
  String toJson() => json.encode(toMap());

  // Creates a PostModel object from JSON
  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Overridden toString() method
  @override
  String toString() {
    return 'PostModel(id: $id, author: $author, img: $img, content: $content, mentionedUsers: $mentionedUsers)';
  }

  // Overridden equality operator
  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.author == author &&
        other.img == img &&
        other.content == content &&
        listEquals(other.mentionedUsers, mentionedUsers);
  }

  // Overridden hashCode() method
  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        img.hashCode ^
        content.hashCode ^
        mentionedUsers.hashCode;
  }
}
