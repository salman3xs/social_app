import 'package:graphql/client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/query/user_query.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/src/core/graphql_config.dart';

final allUsersFutureProvider =
    FutureProvider<List>((ref) => ref.watch(profileRepositoryProvider).getAllUser());

final profileProvider = FutureProvider<UserModal?>((ref) {
  return ref.watch(profileRepositoryProvider).getProfile();
});

final profileRepositoryProvider = Provider((ref) => ProfileRepository(ref));

class ProfileRepository {
  ProfileRepository(this.ref);
  final Ref ref;

  final UserQuery userQuery = UserQuery();

  final GraphQLClient client = GraphConfig.getClient();

  Future<UserModal?> getProfile() async {
    final QueryOptions options = userQuery.getCurrentUser();
    final query = await client.query(options);
    if (query.hasException) {
      return Future.error(query.exception!);
    }
    if (query.data!['user'] == null) {
      return null;
    }
    return UserModal.fromQuery('user', query.data!);
  }

  Future<List> getAllUser() async {
    final QueryOptions options = userQuery.getAllUsers();
    final query = await client.query(options);
    if (query.hasException) {
      return Future.error(query.exception!);
    }
    if (query.data!['allUser'] == null) {
      return [];
    }
    return query.data!['allUser'];
  }

  Future<void> createProfile(UserModal userModal) async {
    final MutationOptions options = userQuery.createProfile(userModal);
    final query = await client.mutate(options);
    if (query.hasException) {
      return Future.error(query.exception!);
    }
  }

  Future<void> changeFollow(String userId,String otherUserId) async {
    final MutationOptions options = userQuery.changeFollow(userId,otherUserId);
    final query = await client.mutate(options);
    if (query.hasException) {
      return Future.error(query.exception!);
    }
  }
}
