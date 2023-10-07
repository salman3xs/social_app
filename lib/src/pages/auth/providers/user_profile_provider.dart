// ignore_for_file: unused_result, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/repository/user_repository.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/src/pages/auth/providers/auth_view_model_provider.dart';
// Provides an user notifier
final userProfileNotifierProvider =
    ChangeNotifierProvider((ref) => UserProfileNotifier(ref));

class UserProfileNotifier extends ChangeNotifier {
  // A reference to the ProviderScope
  final Ref ref;
  // Constructor
  UserProfileNotifier(this.ref);
  // Gets Repository object for profile
  ProfileRepository get profileRepo => ref.read(profileRepositoryProvider);
  // Gets the current user
  User get user => ref.watch(userStreamProvider).value!;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String name = '';
  // Method to create profile from the entered data
  void createProfile(VoidCallback onDone) async {
    loading = true;
    try {
      profileRepo.createProfile(UserModal(
          name: name,
          id: user.uid,
          phone: int.parse(user.phoneNumber!),
          posts: [],
          following: []));
      ref.refresh(profileProvider);
      name = '';
      onDone();
    } catch (e) {
      print(e.toString());
    }
    loading = false;
  }
}
