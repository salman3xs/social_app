import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/routes.dart';
import '../../root.dart';
import '../../utils/app_color.dart';
import '../../utils/paddings.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(const Duration(
      seconds: 4,
    ));
    if (!mounted) return;

    // page navigation after splash screen to root
    AppRoutes.pushAndRemoveUntil(page: const Root());
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      left: false,
      right: false,
      top: false,
      child: Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.cardColor,
      body: Container(
        alignment: Alignment.center,
        padding: Paddings.p52,
        color: AppColors.primaryColor,
        child: const Text('Social App'),
      ),
    );
  }
}
