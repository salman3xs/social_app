// ignore_for_file: unused_result, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/repository/post_repository.dart';
import 'package:social_app/src/core/routes.dart';
import 'package:social_app/src/pages/home/providers/post_provider.dart';
import 'package:social_app/src/utils/paddings.dart';
import 'package:social_app/src/widgets/loading.dart';
import '../../../../data/repository/user_repository.dart';
import '../../../utils/sizes.dart';
import 'image_picker_view.dart';

class AddPostForm extends ConsumerWidget {
  AddPostForm({
    super.key,
  });
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(postNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: Paddings.p16,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Content',
                  ),
                  onSaved: (v) => model.content = v!.trim(),
                ),
                Sizes.h12,
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(
                        postNotifierProvider.select((value) => value.file));
                    return ImagePickerView(
                      onPick: (v) => model.file = v,
                      file: model.file,
                    );
                  },
                ),
                Sizes.h12,
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return const SelectUsersDialog();
                        });
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Mention Users'),
                ),
                Sizes.h24,
                model.loading
                    ? const Loading()
                    : ElevatedButton(
                        onPressed: () {
                          formKey.currentState!.save();
                          model.addPost(() {
                            AppRoutes.pop();
                            ref.refresh(postFutureProvider);
                          });
                        },
                        child: const Text('Add Post'),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectUsersDialog extends ConsumerWidget {
  const SelectUsersDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(allUsersFutureProvider);
    final model = ref.watch(postNotifierProvider);
    return users.when(
        data: (data) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Select Users to add'),
                  Sizes.h12,
                  ...data
                      .map((e) => CheckboxListTile(
                          title: Text(e['name']),
                          value: model.mentionedUsers.contains(e['id']),
                          onChanged: (v) {
                            if (model.mentionedUsers.contains(e['id'])) {
                              model.mentionedUsers.remove(e['id']);
                            } else {
                              model.mentionedUsers.add(e['id']);
                            }
                            model.notifyListeners();
                          }))
                      .toList(),
                  Sizes.h12,
                  TextButton(
                    onPressed: () {
                      AppRoutes.pop();
                    },
                    child: const Text('Done'),
                  )
                ],
              ),
            ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Loading());
  }
}
