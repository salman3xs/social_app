import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/src/core/routes.dart';
import 'package:social_app/src/pages/home/feed_page.dart';
import 'package:social_app/src/pages/home/user_page.dart';
import 'package:social_app/src/utils/app_color.dart';
import 'widgets/add_post_form.dart';

final bnbProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bnbProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(index == 0 ? 'News Feed' : 'Users'),
        ),
        floatingActionButton: index == 0
            ? FloatingActionButton.extended(
                label: const Text('Add Post'),
                icon: const Icon(Icons.library_add_outlined),
                onPressed: () {
                  AppRoutes.push(page: AddPostForm());
                },
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.secondaryColor,
          currentIndex: index,
          onTap: (v) => ref.read(bnbProvider.notifier).state = v,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  index == 0 ? Icons.feed : Icons.feed_outlined,
                ),
                label: 'Feed'),
            BottomNavigationBarItem(
                icon: Icon(
                  index == 1 ? Icons.person : Icons.person_outlined,
                ),
                label: 'Users'),
          ],
        ),
        body: [
          const FeedPage(),
          const UsersPage(),
        ][index]);
  }
}
