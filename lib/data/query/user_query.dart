import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql/client.dart';
import 'package:social_app/model/user_model.dart';
import 'constant_query.dart';

class UserQuery {
  User user = FirebaseAuth.instance.currentUser!;

  QueryOptions getCurrentUser() {
    return QueryOptions(
      document: gql(ConstantQueries.getUser(user.uid)),
    );
  }

  QueryOptions getAllUsers() {
    return QueryOptions(
      document: gql(ConstantQueries.getAllUser),
    );
  }

  MutationOptions createProfile(UserModal userModal) {
    return MutationOptions(
      document: gql(ConstantQueries.addUser(userModal)),
    );
  }

  MutationOptions changeFollow(String userId,String otherUserId) {
    return MutationOptions(
      document: gql(ConstantQueries.followUser(userId,otherUserId)),
    );
  }
}
