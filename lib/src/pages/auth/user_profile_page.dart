import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/src/core/routes.dart';
import 'package:social_app/src/pages/auth/providers/user_profile_provider.dart';
import 'package:social_app/src/root.dart';
import 'package:social_app/src/utils/extensions.dart';
import 'package:social_app/src/utils/paddings.dart';
import 'package:social_app/src/utils/sizes.dart';
import 'package:social_app/src/widgets/loading.dart';

class UserProfilePage extends ConsumerWidget {
  UserProfilePage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(userProfileNotifierProvider);
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
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          model.createProfile(() {
                            AppRoutes.pushAndRemoveUntil(page: const Root());
                          });
                        }
                      },
                      child: const Text('Continue'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
