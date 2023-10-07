// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/src/utils/extensions.dart';
import 'package:social_app/src/widgets/loading.dart';
import 'package:social_app/src/widgets/shimmer_box.dart';
import '../../../data/repository/post_repository.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postFutureProvider);
    return Scaffold(
      body: posts.when(
          data: (data) => SingleChildScrollView(
                child: Column(
                  children: [
                    ...data.map((e) => Card(
                          child: Column(
                            children: [
                              if (e['img'] != null && e['img'] != '')
                                Image.network(
                                  e['img'],
                                  fit: BoxFit.contain,
                                  loadingBuilder: (
                                    BuildContext c,
                                    Widget w,
                                    ImageChunkEvent? i,
                                  ) {
                                    if (i == null) {
                                      return w;
                                    }
                                    return const ShimmerBox();
                                  },
                                ),
                              ListTile(
                                title: Text(
                                  e['content'],
                                  style: context.bm,
                                ),
                                subtitle: Text(
                                  "Created By:${e['author']['name']}",
                                  style: context.ls,
                                ),
                              ),
                            ],
                          ),
                        ))
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
