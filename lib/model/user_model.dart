// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'post_model.dart';

class UserModal {
  final String name;
  final String id;
  final int phone;
  final List<PostModel> posts;
  final List<String> following;
  // Constructor
  UserModal({
    required this.name,
    required this.id,
    required this.phone,
    required this.posts,
    required this.following,
  });

  // Copy constructor
  UserModal copyWith({
    String? name,
    String? id,
    int? phone,
    List<PostModel>? posts,
    List<String>? following,
  }) {
    return UserModal(
      name: name ?? this.name,
      id: id ?? this.id,
      phone: phone ?? this.phone,
      posts: posts ?? this.posts,
      following: following ?? this.following,
    );
  }

  // Converts the UserModal object to a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'phone': phone,
      'posts': posts.map((x) => x.toMap()).toList(),
      'following': following,
    };
  }

  // Creates a UserModal object from a map
  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      name: (map['name'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      phone: (map['phone'] ?? 0) as int,
      posts: List<PostModel>.from(
        (map['posts'] as List<int>).map<PostModel>(
          (x) => PostModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      following: List<String>.from(
          (map['following'] ?? const <String>[]) as List<String>),
    );
  }

  // Creates a UserModal object from a GraphQL query response
  factory UserModal.fromQuery(String query, Map<String, dynamic> data) {
    final map = data[query];
    return UserModal(
      name: (map['name'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      phone: int.parse(map['phone'] ?? 0),
      posts: map['posts'] == null
          ? []
          : List<PostModel>.from(
              (map['posts'] as List).map<PostModel>(
                (x) => PostModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
      following: map['following'] == null
          ? []
          : List<String>.from(
              (map['following'].map((e)=>e['id']))),
    );
  }

  // Converts the UserModal object to JSON
  String toJson() => json.encode(toMap());

  // Creates a UserModal object from JSON
  factory UserModal.fromJson(String source) =>
      UserModal.fromMap(json.decode(source) as Map<String, dynamic>);

  // Creates an empty UserModal object
  factory UserModal.empty() =>
      UserModal(name: '', id: '', phone: 0, following: [], posts: []);

  // Overridden toString() method
  @override
  String toString() {
    return 'UserModal(name: $name, id: $id, phone: $phone, posts: $posts, following: $following)';
  }

  // Overridden equality operator
  @override
  bool operator ==(covariant UserModal other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.phone == phone &&
        listEquals(other.posts, posts) &&
        listEquals(other.following, following);
  }
  // Overridden hashCode
  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        phone.hashCode ^
        posts.hashCode ^
        following.hashCode;
  }
}
