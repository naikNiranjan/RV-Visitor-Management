import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'session_service.g.dart';

@riverpod
class SessionService extends _$SessionService {
  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';

  late final SharedPreferences _prefs;

  @override
  Future<void> build() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveSession({
    required String token,
    required String userId,
  }) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setString(_userIdKey, userId);
  }

  Future<void> clearSession() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userIdKey);
  }

  String? getToken() => _prefs.getString(_tokenKey);
  String? getUserId() => _prefs.getString(_userIdKey);
  bool get isLoggedIn => getToken() != null;
} 