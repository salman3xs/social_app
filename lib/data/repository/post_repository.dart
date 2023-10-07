import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:graphql/client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/query/post_query.dart';
import 'package:social_app/model/post_model.dart';
import '../../src/core/graphql_config.dart';

// This provider provides a future of a list of posts
final postFutureProvider = FutureProvider.autoDispose<List>(
    (ref) => ref.watch(postRepository).getPosts());

// This provider provides a PostRepository
final postRepository = Provider<PostRepository>((ref) => PostRepository(ref));

class PostRepository {
  // The reference to the current provider scope
  final Ref ref;

  // The PostQuery object
  final PostQuery postQuery = PostQuery();

  // The FirebaseStorage object
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // The GraphQLClient object
  final GraphQLClient client = GraphConfig.getClient();

  // Constructor
  PostRepository(this.ref);

  // Method to get all posts
  Future<List> getPosts() async {
    // Get the query options
    final QueryOptions options = postQuery.getPosts();

    // Execute the query
    final query = await client.query(options);

    // Check if the query was successful
    if (query.hasException) {
      // Rethrow the exception
      return Future.error(query.exception!);
    }

    // Check if there is any data in the response
    if (query.data!['newsfeed'] == null) {
      // Return an empty list
      return [];
    }
    // Return the list of posts from the response
    return List.from(query.data!['newsfeed']);
  }

  // Method to upload an image
  Future<String> uploadImage(File file) async {
    // Upload the file and Return the download URL for the file
    return await (await _storage
            .ref("Images")
            .child("${DateTime.now().microsecondsSinceEpoch}")
            .putFile(file))
        .ref
        .getDownloadURL();
  }

  // Method to create a new post
  Future<void> createPost(PostModel postModel) async {
    // Get the mutation options
    final MutationOptions options = postQuery.createPost(postModel);

    // Execute the mutation
    final query = await client.mutate(options);

    // Check if the mutation was successful
    if (query.hasException) {
      // Rethrow the exception
      return Future.error(query.exception!);
    }
  }
}
