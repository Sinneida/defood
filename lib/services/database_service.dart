import 'package:defood/app/app.locator.dart';
import 'package:defood/models/box.dart';
import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/models/product.dart';
import 'package:defood/services/auth_service.dart';
import 'package:defood/ui/dialogs/add_product/add_product_dialog_model.dart';
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

  Future<List<BoxModel>> loadAllBoxes() async {
    try {
      isAuthOk();
      final result = await _db
          .from(Tables.boxes)
          .select('id, name, created_at, updated_at, email, products("*")')
          .eq(
            BoxesTable.email,
            _auth.userEmail!,
          );
      return result.map((e) => BoxModel.fromMap(e)).toList();
    } catch (e) {
      logError('Failed to load boxes', e);
      rethrow;
    }
  }

  Future<List<BoxModel>> createBox(String name) async {
    try {
      isAuthOk();
      final Map<String, dynamic> values = {
        BoxesTable.name: name,
        BoxesTable.email: _auth.userEmail,
      };
      final result = await _db.from(Tables.boxes).insert(values).select();
      return result.map((e) => BoxModel.fromMap(e)).toList();
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

  Future<List<ProductModel>> loadAllProducts() async {
    try {
      isAuthOk();
      final result = await _db.from(Tables.products).select().eq(
            'email',
            _auth.userEmail!,
          );
      return result.map((e) => ProductModel.fromMap(e)).toList();
    } catch (e) {
      logError('Failed to load products', e);
      rethrow;
    }
  }

  Future<void> addProduct(ProductDto dto, int boxId, String barcode) async {
    try {
      isAuthOk();
      final (:amount, :expirationDate, :expirationType, :name, :price) = dto;
      final Map<String, Object?> values = {
        'box_id': boxId,
        'name': name,
        'expiration_date': expirationDate.toIso8601String(),
        'expiration_type': expirationType.name,
        'amount': amount,
        'price': price,
        'barcode': barcode,
        'email': _auth.userEmail,
      };
      await _db.from(Tables.products).insert(values);
    } catch (e) {
      logError('Failed to add new product', e);
      rethrow;
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      isAuthOk();
      await _db.from(Tables.products).delete().eq('id', productId);
    } catch (e) {
      logError('Failed to delete product', e);
      rethrow;
    }
  }
}
