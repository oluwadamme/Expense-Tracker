import 'dart:io';

import 'package:expense_tracker/src/model/supabase_auth_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService extends Cubit<SupabaseAuthState> {
  SupabaseAuthService() : super(SupabaseAuthState(loading: false));

  final supabase = Supabase.instance.client;
  late AuthResponse response;
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String userName,
  }) async {
    emit(SupabaseAuthState(loading: true));
    try {
      final result =
          await supabase.auth.signUp(password: password, email: email, data: {'fullname': name, "username": userName});
      response = result;
      emit(SupabaseAuthState(loading: false, data: result));
    } on SocketException catch (e) {
      emit(SupabaseAuthState(loading: false, data: null, error: e.message.toString()));
    } on AuthException catch (e) {
      emit(SupabaseAuthState(loading: false, data: null, error: e.message.toString()));
    } on Exception catch (e) {
      emit(SupabaseAuthState(loading: false, data: null, error: e.toString()));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(SupabaseAuthState(loading: true));
    try {
      final result = await supabase.auth.signInWithPassword(password: password, email: email);
      response = result;
      emit(SupabaseAuthState(loading: false, data: result));
    } on SocketException catch (e) {
      emit(SupabaseAuthState(loading: false, data: null, error: e.message.toString()));
    } on AuthException catch (e) {
      emit(SupabaseAuthState(loading: false, data: null, error: e.message.toString()));
    } on Exception catch (e) {
      emit(SupabaseAuthState(loading: false, data: null, error: e.toString()));
    }
  }

  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }
}
