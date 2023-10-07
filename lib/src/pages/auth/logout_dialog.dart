import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/src/utils/extensions.dart';
import '../../core/routes.dart';
import '../../root.dart';
import '../../utils/paddings.dart';
import '../../utils/sizes.dart';
import '../../widgets/loading.dart';

final loadingProvider = StateProvider<bool>((ref) {
  return false;
});

class LogOutDialog extends ConsumerWidget {
  // Whether the logout dialog is for a user who has not yet created a profile.

  // The constructor.
  const LogOutDialog({super.key});

  // The build method.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the loading state from the loadingProvider.
    final loading = ref.watch(loadingProvider);

    // Return a Dialog widget with the following contents:
    //
    // * A title text that says "Logout".
    // * A divider.
    // * A text widget that asks the user if they are sure they want to logout.
    // * A Row widget with two buttons:
    //     * A Cancel button that pops the dialog.
    //     * A Logout button that signs the user out of Firebase and pushes the Root page to the navigation stack.
    //
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: Paddings.p24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Logout',
              style: context.hs,
            ),
            const Divider(),
            const Text('Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black)),
            Sizes.h24,
            loading
                ? const Loading()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                              backgroundColor: Colors.white),
                          onPressed: () {
                            // Pop the dialog.
                            AppRoutes.pop;
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                      Sizes.w12,
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Set the loading state to true.
                            ref.read(loadingProvider.notifier).state = true;

                            // Sign the user out of Firebase.
                            await FirebaseAuth.instance.signOut();

                            // Push the Root page to the navigation stack.
                            AppRoutes.pushAndRemoveUntil(page: const Root());

                            // Set the loading state to false.
                            ref.read(loadingProvider.notifier).state = false;
                          },
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
