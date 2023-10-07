// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/data/repository/user_repository.dart';
import 'package:social_app/src/core/routes.dart';
import 'package:social_app/src/pages/auth/providers/user_profile_provider.dart';
import 'package:social_app/src/root.dart';
import 'package:social_app/src/utils/extensions.dart';
import 'package:social_app/src/utils/paddings.dart';
import 'package:social_app/src/utils/sizes.dart';
import 'package:social_app/src/widgets/loading.dart';

class UserProfilePage extends ConsumerWidget {
  // The constructor.
  UserProfilePage({super.key});

  // The form key.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // The build method.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the UserProfileNotifier from the dependency injection tree.
    final model = ref.watch(userProfileNotifierProvider);

    // Return a Scaffold widget with the following contents:
    //
    // * An AppBar widget.
    // * A Form widget with a single TextFormField for entering the user's name.
    // * An ElevatedButton widget that calls the createProfile() method on the UserProfileNotifier when pressed.
    //
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: Paddings.p12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please Enter your Name',
                style: context.bm,
              ),
              Sizes.h12,
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (v) => model.name = v!.trim(),
                validator: (v) =>
                    v!.trim().isEmpty ? 'Please enter name' : null,
              ),
              Sizes.h12,
              model.loading
                  ? const Loading()
                  : ElevatedButton(
                      onPressed: () {
                        // Validate the form.
                        if (formKey.currentState!.validate()) {
                          // Save the form.
                          formKey.currentState!.save();

                          // Call the createProfile() method on the UserProfileNotifier.
                          model.createProfile(() {
                            // Push the Root page to the navigation stack and remove all other pages.
                            AppRoutes.pushAndRemoveUntil(page: const Root());
                          });
                          ref.refresh(profileProvider);
                        }
                      },
                      child: const Text('Continue'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
