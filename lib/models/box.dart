import 'package:dart_mappable/dart_mappable.dart';

part 'box.mapper.dart';

@MappableClass()
class Box with BoxMappable {
  Box(
    this.id,
    this.name,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.email,
  );

  final int id;
  final String name;
  final List<dynamic>? products;
  @MappableField(key: 'created_at')
  final String createdAt;
  @MappableField(key: 'updated_at')
  final String updatedAt;
  final String email;

  static const fromMap = BoxMapper.fromMap;
  static const fromJson = BoxMapper.fromJson;
}
