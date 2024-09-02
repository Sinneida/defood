import 'package:defood/app/app.locator.dart';
import 'package:defood/models/box.dart';
import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/services/auth_service.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class Tables {
  static const boxes = 'boxes';
  static const products = 'products';
}

abstract final class BoxesTable {
  static const id = 'id';
  static const name = 'name';
  static const products = 'products';
  static const email = 'email';
}

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
      final result = await _db
          .from(Tables.boxes)
          .select('id, name, created_at, updated_at, email, products(id, name)')
          .eq(
            BoxesTable.email,
            _auth.userEmail!,
          );
      return result.map((e) => Box.fromMap(e)).toList();
    } catch (e) {
      logError('Failed to load boxes', e);
      rethrow;
    }
  }

  Future<List<Box>> createBox(String name) async {
    try {
      isAuthOk();
      final Map<String, dynamic> values = {
        BoxesTable.name: name,
        BoxesTable.email: _auth.userEmail,
      };
      final result = await _db.from(Tables.boxes).insert(values).select();
      return result.map((e) => Box.fromMap(e)).toList();
    } catch (e) {
      logError('Failed to save new box', e);
      rethrow;
    }
  }

  Future<bool> deleteBox(int id) async {
    try {
      isAuthOk();
      final result = await _db.from(Tables.boxes).delete().eq(BoxesTable.id, id).select();
      return result.isNotEmpty;
    } catch (e) {
      logError('Failed to delete box', e);
      rethrow;
    }
  }
}
