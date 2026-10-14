
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthStatus _status = AuthStatus.loading;
  User? _user;
  String? _errorMessage;

  late final StreamSubscription<User?> _authSubscription;

  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated =>
      _status == AuthStatus.authenticated;

  AuthProvider() {
    _authSubscription =
        _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  // Monitor Firebase authentication state
  void _onAuthStateChanged(User? firebaseUser) {
    _user = firebaseUser;

    _status = firebaseUser == null
        ? AuthStatus.unauthenticated
        : AuthStatus.authenticated;

    notifyListeners();
  }

  // SIGN UP
  Future<bool> signUp(
    String email,
    String password,
    String username,
  ) async {
    try {
      _setLoading();

      final credential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await credential.user?.updateDisplayName(username.trim());
      await credential.user?.reload();

      _user = _auth.currentUser;
      _status = AuthStatus.authenticated;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Sign up failed');
      return false;
    } catch (e) {
      _setError('Something went wrong. Please try again.');
      return false;
    }
  }

  // LOGIN
  Future<bool> login(
    String email,
    String password,
  ) async {
    try {
      _setLoading();

      final credential =
          await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      _user = credential.user;
      _status = AuthStatus.authenticated;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Login failed');
      return false;
    } catch (e) {
      _setError('Something went wrong. Please try again.');
      return false;
    }
  }

  // FORGOT PASSWORD
  Future<bool> forgotPassword(String email) async {
  _errorMessage = null;

  try {
    await _auth.sendPasswordResetEmail(
      email: email.trim(),
    );

    return true;
  } on FirebaseAuthException catch (e) {
    _errorMessage = e.message ?? 'Password reset failed';
    return false;
  } catch (e) {
    _errorMessage = 'Something went wrong. Please try again.';
    return false;
  }
}

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void _setLoading() {
    _errorMessage = null;
    _status = AuthStatus.loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _status = _user == null
        ? AuthStatus.unauthenticated
        : AuthStatus.authenticated;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}
