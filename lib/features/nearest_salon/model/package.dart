import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable()
class Package {
  final int id;
  final String name;
  final String shortInfo;
  final String fullInfo;
  final double price;
  final String imageUrl;

  const Package({
    required this.id,
    required this.name,
    required this.shortInfo,
    required this.fullInfo,
    required this.price,
    required this.imageUrl,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
}
