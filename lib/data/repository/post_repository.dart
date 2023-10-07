import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:graphql/client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/query/post_query.dart';
import 'package:social_app/model/post_model.dart';
import '../../src/core/graphql_config.dart';

final postFutureProvider =
    FutureProvider<List>((ref) => ref.watch(postRepository).getPosts());

final postRepository = Provider<PostRepository>((ref) => PostRepository(ref));

class PostRepository {
  PostRepository(this.ref);
  final Ref ref;

  final PostQuery postQuery = PostQuery();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final GraphQLClient client = GraphConfig.getClient();

  Future<List> getPosts() async {
    final QueryOptions options = postQuery.getPosts();
    final query = await client.query(options);
    if (query.hasException) {
      return Future.error(query.exception!);
    }
    if (query.data!['newsfeed'] == null) {
      return [];
    }
    return List.from(query.data!['newsfeed']);
  }

  //Method to UploadImage of Marriage Profile
  Future<String> uploadImage(File file) async {
    return await (await _storage
            .ref("Images")
            .child("${DateTime.now().microsecondsSinceEpoch}")
            .putFile(file))
        .ref
        .getDownloadURL();
  }

  Future<void> createPost(PostModel postModel) async {
    final MutationOptions options = postQuery.createPost(postModel);
    final query = await client.mutate(options);
    if (query.hasException) {
      return Future.error(query.exception!);
    }
  }
}
