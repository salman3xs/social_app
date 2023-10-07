import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:social_app/src/utils/extensions.dart';
import '../../core/routes.dart';
import '../../root.dart';
import '../../utils/app_color.dart';
import '../../utils/paddings.dart';
import '../../utils/sizes.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/loading.dart';
import 'providers/auth_view_model_provider.dart';

class VerifyOtp extends HookConsumerWidget {
  const VerifyOtp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 56,
      textStyle: context.ds.copyWith(color: AppColors.primaryColor),
      decoration: BoxDecoration(
        color: AppColors.inputFilledColor,
        border: Border.all(color: AppColors.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith();

    final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
      border: Border.all(color: context.theme.primaryColor),
      borderRadius: BorderRadius.circular(6),
    ));
    final model = ref.read(authViewModelProvider);

    final controller = useTextEditingController();
    controller.addListener(() {
      model.code = controller.text;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: Paddings.p12,
        child: model.loading
            ? const Loading()
            : AnimatedElevatedButton(
                controller: model.btnController,
                onPressed: () {
                  model.code.length == 6
                      ? model.verifyOTP(
                          clear: controller.clear,
                          onVerify: () {
                            // ref.invalidate(selectedPageProvider);
                            AppRoutes.pushAndRemoveUntil(page: const Root());
                          })
                      : model.btnController.stop();
                },
                text: 'Proceed',
              ),
      ),
      body: Padding(
        padding: Paddings.p16,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Sizes.h100,
              // Image.asset(
              //   Assets.otpIcon,
              //   scale: 4,
              // ),
              Sizes.h36,
              Text('Verify OTP', style: context.hl),
              Sizes.h12,
              Text(
                "We have sent OTP to ${model.phone}",
                style: context.lm.copyWith(
                  color: AppColors.secondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              Sizes.h28,
              Pinput(
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsRetrieverApi,
                autofocus: true,
                controller: controller,
                length: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: false,
              ),
              Sizes.h24,
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          AppRoutes.pop;
                        },
                        child: Text(
                          'Edit Number',
                          style: context.lm.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        )),
                    const VerticalDivider(
                      thickness: 1.5,
                      indent: 8,
                      endIndent: 8,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final timer = ref.watch(authViewModelProvider).stream;
                        return timer == 0
                            ? TextButton(
                                onPressed: () {
                                  model.sendOTP(
                                      onComplete: () {
                                        // ref
                                        //     .read(selectedPageProvider.notifier)
                                        //     .state = 0;
                                      },
                                      onSend: () => AppRoutes.push(

                                          // VerifyOtp.route
                                          // MaterialPageRoute(
                                          //     builder: (builder) =>
                                          page: const VerifyOtp())
                                      // ),
                                      );
                                },
                                child: Text(
                                  'Resend OTP',
                                  style: context.lm.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ))
                            : Text(
                                '0:$timer',
                                style: context.ts,
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
