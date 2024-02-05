import 'package:expense_tracker/src/model/supabase_auth_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService extends Cubit<SupabaseAuthState> {
  SupabaseAuthService() : super(SupabaseAuthState(loading: false));

  final supabase = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    emit(SupabaseAuthState(loading: true));
    try {
      final result = await supabase.auth.signUp(password: password, email: email);
      emit(SupabaseAuthState(loading: false, data: result));
    } catch (e) {
      emit(SupabaseAuthState(loading: false, data: null, error: e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(SupabaseAuthState(loading: true));
    try {
      final result = await supabase.auth.signInWithPassword(password: password, email: email);
      emit(SupabaseAuthState(loading: false, data: result));
    } catch (e) {
      emit(SupabaseAuthState(loading: false, data: null, error: e.toString()));
    }
  }

  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }
}
