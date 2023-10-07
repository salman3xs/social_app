import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql/client.dart';
import 'package:social_app/data/query/constant_query.dart';
import 'package:social_app/model/post_model.dart';

class PostQuery {
  User user = FirebaseAuth.instance.currentUser!;

  QueryOptions getPosts() {
    return QueryOptions(
      document: gql(ConstantQueries.getPosts(user.uid)),
    );
  }
  MutationOptions createPost(PostModel postModel) {
    return MutationOptions(
      document: gql(ConstantQueries.createPost(postModel)),
    );
  }
}
