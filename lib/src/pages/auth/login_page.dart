import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:social_app/src/utils/extensions.dart';
import '../../core/routes.dart';
import '../../root.dart';
import '../../utils/paddings.dart';
import '../../utils/sizes.dart';
import '../../widgets/animated_button.dart';
import 'providers/auth_view_model_provider.dart';
import 'verify_otp_page.dart';

// The LoginPage class represents the login page of the app.
class LoginPage extends ConsumerWidget {
  // The static route name for the login page.
  static const String route = "/loginPage";

  // The constructor.
  LoginPage({super.key});

  // The form key.
  final _formKey = GlobalKey<FormState>();

  // The build method.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the AuthViewModel from the dependency injection tree.
    final model = ref.watch(authViewModelProvider);

    // Return a Scaffold widget with the following contents:
    //
    // * A bottomNavigationBar with a single button that calls the sendOTP() method on the AuthViewModel when pressed.
    // * A body with a Form widget that contains a single TextFormField for entering the user's phone number.
    //
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: Paddings.p12,
        child: Material(
          color: Colors.transparent,
          child: Hero(
            tag: 'login',
            child: AnimatedElevatedButton(
              controller: model.btnController,
              onPressed: () {
                // If the form is valid and the phone number is 10 digits long, call the sendOTP() method on the AuthViewModel.
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (model.phone.length == 10) {
                    model.sendOTP(
                      onComplete: () => AppRoutes.push(page: const Root()),
                      onSend: () => AppRoutes.push(page: const VerifyOtp()),
                    );
                  } else {
                    model.btnController.stop();
                  }
                } else {
                  model.btnController.stop();
                }
              },
              text: "Get OTP",
            ),
          ),
        ),
      ),
      body: Padding(
        padding: Paddings.p16,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Sizes.h36,
                Text(
                  'Enter Mobile Number',
                  style: context.hl,
                ),
                Sizes.h12,
                Text(
                  'Please enter your mobile number',
                  style: context.lm,
                  textAlign: TextAlign.center,
                ),
                Sizes.h28,
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter mobile number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (v) {
                    // If the phone number is 10 digits long, unfocus the TextFormField.
                    if (v.length == 10) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  onSaved: (v) {
                    // Save the phone number to the AuthViewModel.
                    model.phone = v!.trim();
                  },
                  validator: (v) => v!.trim().isEmpty
                      ? 'Mobile number is required.'
                      : v.length != 10
                          ? 'Please enter correct mobile number.'
                          : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
