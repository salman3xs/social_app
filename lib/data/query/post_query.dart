import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql/client.dart';
import 'package:social_app/data/query/constant_query.dart';
import 'package:social_app/model/post_model.dart';

// This class is responsible for making queries and mutations to the GraphQL server
class PostQuery {
  // The current user
  final User user = FirebaseAuth.instance.currentUser!;

  // Query to get all of the user's posts
  QueryOptions getPosts() {
    return QueryOptions(
      document: gql(ConstantQueries.getPosts(user.uid)),
    );
  }

  // Mutation to create a new post
  MutationOptions createPost(PostModel postModel) {
    return MutationOptions(
      document: gql(ConstantQueries.createPost(postModel)),
    );
  }
}
