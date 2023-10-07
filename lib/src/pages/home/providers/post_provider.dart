// ignore_for_file: avoid_print, unused_result

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/repository/post_repository.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/src/pages/auth/providers/auth_view_model_provider.dart';

final postNotifierProvider = ChangeNotifierProvider((ref) => PostNotifer(ref));

class PostNotifer extends ChangeNotifier {
  // The constructor.
  PostNotifer(this.ref);

  // The dependency injection reference.
  final Ref ref;

  // The post repository.
  PostRepository get postRepo => ref.read(postRepository);

  // The current user.
  User get user => ref.read(userStreamProvider).value!;

  // The post file.
  File? _file;
  File? get file => _file;
  set file(File? file) {
    _file = file;
    notifyListeners();
  }

  // Whether the post is loading.
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  // The post content.
  String content = '';

  // The list of mentioned users.
  List<String> mentionedUsers = [];

  // Cleans up the post notifier.
  void clean() {
    content = '';
    mentionedUsers = [];
    file = null;
  }

  // Adds a post.
  void addPost(VoidCallback onDone) async {
    // Set the loading state to true.
    loading = true;

    try {
      // If the post has a file, upload it to the server.
      if (file != null) {
        String imgLink = await postRepo.uploadImage(file!);

        // Create a post model with the file link.
        PostModel postModel = PostModel(
          id: '',
          author: user.uid,
          img: imgLink,
          content: content,
          mentionedUsers: mentionedUsers,
        );

        // Create the post on the server.
        await postRepo.createPost(postModel);
      } else {
        // Create a post model without a file.
        PostModel postModel = PostModel(
          id: '',
          author: user.uid,
          img: '',
          content: content,
          mentionedUsers: mentionedUsers,
        );

        // Create the post on the server.
        await postRepo.createPost(postModel);
      }

      // Refresh the post future provider to get the latest posts.
      ref.refresh(postFutureProvider);

      // Clean up the post notifier.
      clean();

      // Call the onDone callback.
      onDone();
    } catch (e) {
      // Print the error to the console.
      print(e.toString());
    }

    // Set the loading state to false.
    loading = false;
  }
}
