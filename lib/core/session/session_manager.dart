import 'package:hoxton_task/features/auth/domain/entities/session_entity.dart';
import 'package:hoxton_task/features/auth/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _keyAccessToken = 'accessToken';
  static const _keyUserId = 'userId';
  static const _keyUserEmail = 'userEmail';
  static const _keyUserName = 'userName';
  static const _keyExpiresIn = 'expiresIn';

  SessionEntity? _session;

  SessionEntity? get session => _session;

  Future<void> save(SessionEntity session) async {
    _session = session;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, session.accessToken);
    await prefs.setString(_keyUserId, session.user.id);
    await prefs.setString(_keyUserEmail, session.user.email);
    await prefs.setString(_keyUserName, session.user.name);
    await prefs.setInt(_keyExpiresIn, session.expiresIn);
  }

  Future<void> restoreFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(_keyAccessToken);
    if (accessToken == null || accessToken.isEmpty) return;

    final userId = prefs.getString(_keyUserId);
    final userEmail = prefs.getString(_keyUserEmail);
    final userName = prefs.getString(_keyUserName);
    final expiresIn = prefs.getInt(_keyExpiresIn);

    if (userId == null ||
        userEmail == null ||
        userName == null ||
        expiresIn == null) {
      return;
    }

    _session = SessionEntity(
      user: UserEntity(id: userId, email: userEmail, name: userName),
      accessToken: accessToken,
      expiresIn: expiresIn,
    );
  }

  Future<void> clear() async {
    _session = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyExpiresIn);
  }
}

