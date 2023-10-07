// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/repository/post_repository.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/src/pages/auth/providers/auth_view_model_provider.dart';

final postNotifierProvider = ChangeNotifierProvider((ref) => PostNotifer(ref));

class PostNotifer extends ChangeNotifier {
  PostNotifer(this.ref);
  final Ref ref;

  PostRepository get postRepo => ref.read(postRepository);
  User get user => ref.read(userStreamProvider).value!;

  File? _file;
  File? get file => _file;
  set file(File? file) {
    _file = file;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  String content = '';
  List<String> mentionedUsers = [];
  void clean() {}

  void addPost(VoidCallback onDone) async {
    loading = true;
    try {
      if (file != null) {
        String imgLink = await postRepo.uploadImage(file!);
        PostModel postModel = PostModel(
            id: '',
            author: user.uid,
            img: imgLink,
            content: content,
            mentionedUsers: mentionedUsers);
        await postRepo.createPost(postModel);
      } else {
        PostModel postModel = PostModel(
            id: '',
            author: user.uid,
            img: '',
            content: content,
            mentionedUsers: mentionedUsers);
        await postRepo.createPost(postModel);
      }
      // ignore: unused_result
      ref.refresh(postFutureProvider);
      clean();
      onDone();
    } catch (e) {
      print(e.toString());
    }
    loading = false;
  }
}
