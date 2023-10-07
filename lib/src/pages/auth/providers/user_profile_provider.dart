import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/repository/user_repository.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/src/pages/auth/providers/auth_view_model_provider.dart';

final userProfileNotifierProvider =
    ChangeNotifierProvider((ref) => UserProfileNotifier(ref));

class UserProfileNotifier extends ChangeNotifier {
  final Ref ref;
  UserProfileNotifier(this.ref);

  ProfileRepository get profileRepo => ref.read(profileRepositoryProvider);

  User get user => ref.watch(userStreamProvider).value!;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String name = '';

  void createProfile(VoidCallback onDone) async {
    loading = true;
    try {
      profileRepo.createProfile(UserModal(
          name: name,
          id: user.uid,
          phone: int.parse(user.phoneNumber!),
          posts: [],
          following: []));
      // ignore: unused_result
      ref.refresh(profileProvider);
      name = '';
      onDone();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    loading = false;
  }
}
