import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'session_service.g.dart';

@riverpod
class SessionService extends _$SessionService {
  @override
  FutureOr<SessionState?> build() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final prefs = await SharedPreferences.getInstance();
        final token = await currentUser.getIdToken() ?? '';
        final userId = currentUser.email ?? '';

        // Try to get role from Firestore first
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        final role =
            userDoc.data()?['role'] ?? prefs.getString('role') ?? 'Host';

        // Save session data
        await saveSession(
          token: token,
          userId: userId,
          role: role,
        );

        return SessionState(
          token: token,
          userId: userId,
          role: role,
        );
      }
    } catch (e) {
      print('Failed to restore session: $e');
    }
    return null;
  }

  Future<void> saveSession({
    required String token,
    required String userId,
    required String role,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('role', role);
      state = AsyncData(SessionState(token: token, userId: userId, role: role));
    } catch (e) {
      print('Failed to save session: $e');
      throw Exception('Failed to save session');
    }
  }

  Future<void> clearSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      state = const AsyncData(null);
    } catch (e) {
      print('Failed to clear session: $e');
      throw Exception('Failed to clear session');
    }
  }
}

class SessionState {
  final String? token;
  final String? userId;
  final String? role;

  SessionState({this.token, this.userId, this.role});
}
