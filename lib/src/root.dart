// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/src/pages/auth/user_profile_page.dart';
import 'package:social_app/src/pages/home/home_page.dart';
import 'package:social_app/src/widgets/loading.dart';
import '../data/repository/user_repository.dart';
import 'pages/auth/providers/auth_view_model_provider.dart';
import 'pages/welcome.dart';

class Root extends ConsumerWidget {
  const Root({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(userStreamProvider);
    return auth.when(
        data: (data) {
          if (data == null) {
            return const WelcomeScreen();
          } else {
            final profile = ref.watch(profileProvider);
            return profile.when(
                data: (data) {
                  return data == null ? UserProfilePage() : const HomePage();
                },
                error: (error, stackTrace) {
                  print(error.toString());
                  return Center(child: Text(error.toString()));
                },
                loading: () => const Scaffold(body: Loading()));
          }
        },
        error: (e, s) {
          log(e.toString());
          return Center(
            child: Text(e.toString()),
          );
        },
        loading: () => const Scaffold(body: Loading()));
  }
}
