import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/auth/data/models/repos/authrepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitial());
  final AuthRepository _authRepository;

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _authRepository.signIn(email: email, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'invalid-credential':
          errorMessage =
              'The supplied auth credential is incorrect, malformed or has expired.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred.'));
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      emit(AuthLoading());
      await _authRepository.signUp(email: email, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'An account already exists with this email.';
          break;
        // case 'weak-password':
        //   errorMessage = 'Password should be at least 6 characters.';
        //   break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred.'));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      emit(AuthLoading());
      await _authRepository.sendPasswordResetEmail(email: email);
      emit(AuthPasswordResetSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred.'));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthSignOutSuccess());
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred.'));
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      emit(AuthLoading());
      await _authRepository.changePassword(
          oldPassword: oldPassword, newPassword: newPassword);
      emit(AuthPasswordChangeSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The new password is too weak.';
          break;
        case 'requires-recent-login':
          errorMessage = 'Please log in again to update your password.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred.'));
    }
  }
}
