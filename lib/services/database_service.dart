import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final _db = Supabase.instance.client;

  Future<void> createBox(String name) async {
    final Map<String, dynamic> values = {
      'name': name,
      'email': 'lukaszr23@gmail.com',
    };
    await _db.from('boxes').insert(values);
  }
}
