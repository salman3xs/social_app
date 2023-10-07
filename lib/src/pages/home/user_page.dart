// ignore_for_file: avoid_print, unused_result
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/src/utils/app_color.dart';
import 'package:social_app/src/widgets/loading.dart';
import '../../../data/repository/post_repository.dart';
import '../../../data/repository/user_repository.dart';

final loadingProvider = StateProvider<bool>((ref) {
  return false;
});

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(allUsersFutureProvider);
    final currentUser = ref.watch(profileProvider).value;
    final loading = ref.watch(loadingProvider);
    return loading
        ? const Loading()
        : Scaffold(
            body: users.when(
                data: (data) => SingleChildScrollView(
                      child: Column(
                        children: [
                          ...data.map(
                            (e) {
                              return ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(
                                  e['name'],
                                ),
                                trailing: TextButton(
                                  child: Text(
                                    currentUser!.following.contains(e['id'])
                                        ? 'Unfollow'
                                        : 'Follow',
                                    style: const TextStyle(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  onPressed: () async {
                                    ref.read(loadingProvider.notifier).state =
                                        true;
                                    final profileRepo =
                                        ref.read(profileRepositoryProvider);
                                    await profileRepo.changeFollow(
                                        currentUser.id, e['id']);
                                    ref.refresh(profileProvider);
                                    ref.refresh(allUsersFutureProvider);
                                    ref.refresh(profileRepositoryProvider);
                                    ref.refresh(postRepository);
                                    ref.refresh(postFutureProvider);
                                    ref.read(loadingProvider.notifier).state =
                                        false;
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                error: (e, s) {
                  print(e.toString());
                  return Text(e.toString());
                },
                loading: () => const Loading()),
          );
  }
}
