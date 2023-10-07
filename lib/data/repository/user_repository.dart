import 'package:graphql/client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/query/user_query.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/src/core/graphql_config.dart';

// This provider provides a future of a list of users
final allUsersFutureProvider = FutureProvider<List>(
    (ref) => ref.watch(profileRepositoryProvider).getAllUser());

// This provider provides a future of a UserModal
final profileProvider = FutureProvider<UserModal?>((ref) {
  return ref.watch(profileRepositoryProvider).getProfile();
});

// This provider provides a ProfileRepository
final profileRepositoryProvider = Provider((ref) => ProfileRepository(ref));

class ProfileRepository {
  // The reference to the current provider scope
  final Ref ref;

  // The UserQuery object
  final UserQuery userQuery = UserQuery();

  // The GraphQLClient object
  final GraphQLClient client = GraphConfig.getClient();

  // Constructor
  ProfileRepository(this.ref);

  // Method to get the current user
  Future<UserModal?> getProfile() async {
    // Get the query options
    final QueryOptions options = userQuery.getCurrentUser();

    // Execute the query
    final query = await client.query(options);

    // Check if the query was successful
    if (query.hasException) {
      // Rethrow the exception
      return Future.error(query.exception!);
    }

    // Check if there is any data in the response
    if (query.data!['user'] == null) {
      // Return null
      return null;
    }

    // Create a UserModal object from the response data
    return UserModal.fromQuery('user', query.data!);
  }

  // Method to get all users
  Future<List> getAllUser() async {
    // Get the query options
    final QueryOptions options = userQuery.getAllUsers();

    // Execute the query
    final query = await client.query(options);

    // Check if the query was successful
    if (query.hasException) {
      // Rethrow the exception
      return Future.error(query.exception!);
    }

    // Check if there is any data in the response
    if (query.data!['allUser'] == null) {
      // Return an empty list
      return [];
    }

    // Return the list of users from the response
    return query.data!['allUser'];
  }

  // Method to create a new profile
  Future<void> createProfile(UserModal userModal) async {
    // Get the mutation options
    final MutationOptions options = userQuery.createProfile(userModal);

    // Execute the mutation
    final query = await client.mutate(options);

    // Check if the mutation was successful
    if (query.hasException) {
      // Rethrow the exception
      return Future.error(query.exception!);
    }
  }

  // Method to follow or unfollow a user
  Future<void> changeFollow(String userId, String otherUserId) async {
    // Get the mutation options
    final MutationOptions options = userQuery.changeFollow(userId, otherUserId);

    // Execute the mutation
    final query = await client.mutate(options);

    // Check if the mutation was successful
    if (query.hasException) {
      // Rethrow the exception
      return Future.error(query.exception!);
    }
  }
}
