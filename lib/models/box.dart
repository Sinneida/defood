import 'package:dart_mappable/dart_mappable.dart';
import 'package:defood/models/product.dart';

part 'box.mapper.dart';

@MappableClass()
class BoxModel with BoxModelMappable {
  BoxModel(
    this.id,
    this.name,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.email,
  );

  final int id;
  final String name;
  final List<ProductModel>? products;
  @MappableField(key: 'created_at')
  final String createdAt;
  @MappableField(key: 'updated_at')
  final String updatedAt;
  final String email;

  static const fromMap = BoxModelMapper.fromMap;
  static const fromJson = BoxModelMapper.fromJson;
}
