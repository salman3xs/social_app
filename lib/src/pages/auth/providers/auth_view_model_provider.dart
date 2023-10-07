// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:social_app/src/widgets/custom_snackbar.dart';

// Provides a stream of the current user and Listen for changes to the user's authentication state
final userStreamProvider = StreamProvider(
    (ref) => ref.read(authViewModelProvider).auth.authStateChanges());

// Provides an AuthViewModel
final authViewModelProvider =
    ChangeNotifierProvider<AuthViewModel>((ref) => AuthViewModel(ref));

class AuthViewModel extends ChangeNotifier {
  // A reference to the ProviderScope
  final Ref ref;
  // Constructor
  AuthViewModel(this.ref);
  // Gets the firebase instance
  FirebaseAuth auth = FirebaseAuth.instance;
  // Gets the current user
  User? get user => ref.watch(userStreamProvider).value;

  String? verificationId;

  final btnController = RoundedLoadingButtonController();

  String _phone = '';
  String get phone => _phone;
  set phone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  String _code = '';
  String get code => _code;
  set code(String code) {
    _code = code;
    notifyListeners();
  }

  int? _resendToken;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int _stream = 30;
  int get stream => _stream;
  set stream(int stream) {
    _stream = stream;
    notifyListeners();
  }
  // The streamTime() function starts a timer that counts down from 30 seconds.
  void streamTime() {
     // Create a stream that emits an event every second.
    stream = 30;
    Timer.periodic(const Duration(seconds: 1), (v) {
      // If the stream is still running, decrement it by 1. 
      if (stream > 0) {
        stream -= 1;
      }
    });
  }
  // Method to sendOtp to the entered number
  void sendOTP({
    required VoidCallback onSend,
    required VoidCallback onComplete,
  }) async {
    loading = true;
    try {
      streamTime();
      await auth.verifyPhoneNumber(
        forceResendingToken: _resendToken,
        phoneNumber: "+91$phone",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          btnController.success();
          Future.delayed(const Duration(seconds: 1), onComplete);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showSnackbar("The provided phone number is not valid.");
          } else {
            showSnackbar(e.message!);
          }
          loading = false;
        },
        codeAutoRetrievalTimeout: (_) {},
        codeSent: (String id, int? forceResendingToken) {
          verificationId = id;
          _resendToken = forceResendingToken;
          stream = _stream;
          loading = false;
          btnController.success();
          Future.delayed(const Duration(seconds: 1), onSend);
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        showSnackbar('Too many requests. Please retry login after sometime');
      } else {
        showSnackbar(e.toString());
      }
      Future.delayed(const Duration(seconds: 1), btnController.stop);
    } catch (e) {
      showSnackbar(e.toString());
      log(e.toString());
      btnController.error();
      Future.delayed(const Duration(seconds: 1), btnController.stop);
    }
  }
  // Method to verify the otp entered
  Future<void> verifyOTP(
      {required VoidCallback clear, required VoidCallback onVerify}) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: code,
      );

      await auth.signInWithCredential(credential);
      _phone = '';
      btnController.success();
      Future.delayed(const Duration(seconds: 1), onVerify);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Code:: ${e.code}");
      }
      if (e.code == 'too-many-requests') {
        print(e.toString());
        showSnackbar('Too many requests. Please retry login after sometime.');
      }
      if (e.code == 'invalid-verification-code') {
        showSnackbar("Invalid OTP");
      }
      if (e.code == 'session-expired') {
        showSnackbar("Session expired please try again");
      }
      btnController.error();
      Future.delayed(const Duration(seconds: 1), btnController.stop);
      clear();
    } catch (e) {
      showSnackbar(e.toString());
      btnController.error();
      Future.delayed(const Duration(seconds: 1), btnController.stop);
      log(e.toString());
    }
  }
  // Method to signout
  Future<void> signOut() async {
    await auth.signOut();
  }
  // Method to update the current user and notify all the listners
  void update() async {
    if (auth.currentUser == null) {
      user!.reload();
    } else {
      auth.currentUser!.reload();
    }
    notifyListeners();
  }
}
