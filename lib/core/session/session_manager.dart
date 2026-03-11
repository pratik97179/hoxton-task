import 'package:hoxton_task/features/auth/domain/entities/session_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SessionEntity? _session;

  SessionEntity? get session => _session;

  Future<void> save(SessionEntity session) async {
    _session = session;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', session.accessToken);
  }

  Future<void> clear() async {
    _session = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }
}

