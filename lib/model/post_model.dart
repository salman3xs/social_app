// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PostModel {
  final String id;
  final String author;
  final String img;
  final String content;
  final List<String> mentionedUsers;
  PostModel({
    required this.id,
    required this.author,
    required this.img,
    required this.content,
    required this.mentionedUsers,
  });

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
      'img': img,
      'content': content,
      'mentionedUsers': mentionedUsers,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: (map['id'] ?? '') as String,
      author: (map['author'] ?? '') as String,
      img: (map['img'] ?? '') as String,
      content: (map['content'] ?? '') as String,
      mentionedUsers: List<String>.from((map['mentionedUsers'] ?? const <String>[]) as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, author: $author, img: $img, content: $content, mentionedUsers: $mentionedUsers)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.author == author &&
        other.img == img &&
        other.content == content &&
        listEquals(other.mentionedUsers, mentionedUsers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        img.hashCode ^
        content.hashCode ^
        mentionedUsers.hashCode;
  }
}
