import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql/client.dart';
import 'package:social_app/model/user_model.dart';
import 'constant_query.dart';

// This class is responsible for making queries and mutations to the GraphQL server
class UserQuery {
  // The current user
  User user = FirebaseAuth.instance.currentUser!;

  // Query to get the current user
  QueryOptions getCurrentUser() {
    return QueryOptions(
      document: gql(ConstantQueries.getUser(user.uid)),
    );
  }

  // Query to get all users
  QueryOptions getAllUsers() {
    return QueryOptions(
      document: gql(ConstantQueries.getAllUser),
    );
  }

  // Mutation to create a new profile
  MutationOptions createProfile(UserModal userModal) {
    return MutationOptions(
      document: gql(ConstantQueries.addUser(userModal)),
    );
  }

  // Mutation to follow or unfollow a user
  MutationOptions changeFollow(String userId, String otherUserId) {
    return MutationOptions(
      document: gql(ConstantQueries.followUser(userId, otherUserId)),
    );
  }
}
