import 'package:dart_mappable/dart_mappable.dart';
import 'package:defood/models/box.dart';

part 'product.mapper.dart';

@MappableClass()
class ProductModel with ProductModelMappable {
  ProductModel(
    this.id,
    this.name,
    this.expirationDate,
    this.expirationType,
    this.price,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.boxId,
  );

  final int id;
  final String name;
  @MappableField(key: 'expiration_date')
  final DateTime expirationDate;
  @MappableField(key: 'expiration_type')
  final String expirationType;
  final double? price;
  final int amount;
  @MappableField(key: 'created_at')
  final DateTime createdAt;
  @MappableField(key: 'updated_at')
  final DateTime updatedAt;
  final String email;
  @MappableField(key: 'box_id')
  final int boxId;

  static const fromMap = ProductModelMapper.fromMap;
  static const fromJson = BoxModelMapper.fromJson;
}
