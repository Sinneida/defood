import 'package:defood/app/app.locator.dart';
import 'package:defood/models/box.dart';
import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/services/auth_service.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum Tables { boxes, products }

class DatabaseService with LoggerHelper {
  final _auth = locator<AuthService>();

  final _db = Supabase.instance.client;

  void isAuthOk() {
    final session = _db.auth.currentSession;
    final result = session != null && !session.isExpired && _auth.userEmail != null;
    if (!result) {
      throw AuthError('User is not authenticated');
    }
  }

  Future<List<Box>> loadAllBoxes() async {
    try {
      isAuthOk();
      final result = await _db.from(Tables.boxes.name).select().eq(
            'email',
            _auth.userEmail!,
          );
      return result.map((e) => Box.fromMap(e)).toList();
    } catch (e) {
      logError('Failed to load boxes', e);
      rethrow;
    }
  }

  Future<void> createBox(String name) async {
    try {
      isAuthOk();
      final Map<String, dynamic> values = {
        'name': name,
        'email': _auth.userEmail,
      };
      await _db.from(Tables.boxes.name).insert(values);
    } catch (e) {
      logError('Failed to save new box', e);
    }
  }
}
