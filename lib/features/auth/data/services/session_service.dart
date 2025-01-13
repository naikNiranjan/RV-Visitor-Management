import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'session_service.g.dart';

@riverpod
class SessionService extends _$SessionService {
  @override
  FutureOr<SessionState?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getString('userId');
    final role = prefs.getString('role');
    
    if (token != null && userId != null && role != null) {
      return SessionState(token: token, userId: userId, role: role);
    }
    return null;
  }

  Future<void> saveSession({
    required String token,
    required String userId,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userId', userId);
    await prefs.setString('role', role);
    state = AsyncData(SessionState(token: token, userId: userId, role: role));
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = const AsyncData(null);
  }
}

class SessionState {
  final String? token;
  final String? userId;
  final String? role;

  SessionState({this.token, this.userId, this.role});
} 