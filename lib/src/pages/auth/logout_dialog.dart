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
  final bool isCreateProfile;
  const LogOutDialog({
    super.key,
    this.isCreateProfile = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(loadingProvider);
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
                            ref.read(loadingProvider.notifier).state = true;
                            await FirebaseAuth.instance.signOut();
                            AppRoutes.pushAndRemoveUntil(page: const Root());
                            ref.read(loadingProvider.notifier).state = false;
                          },
                          child: const Text('Logout'),
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
