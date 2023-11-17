import 'package:json_annotation/json_annotation.dart';

part 'package_info.g.dart';

@JsonSerializable()
class PackageInfo {
  final int id;
  final String name;
  final String shortInfo;
  final String fullInfo;
  final double price;
  final String imageUrl;
  final List<String> services;

  const PackageInfo({
    required this.id,
    required this.name,
    required this.shortInfo,
    required this.fullInfo,
    required this.price,
    required this.imageUrl,
    required this.services,
  });

  factory PackageInfo.fromJson(Map<String, dynamic> json) =>
      _$PackageInfoFromJson(json);
}
