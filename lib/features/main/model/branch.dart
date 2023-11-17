import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch.freezed.dart';
part 'branch.g.dart';

@freezed
class Branch with _$Branch {
  const factory Branch({
    required String id,
    required String name,
    required double space,
    required double latitude,
    required double longitude,
    required String address,
    required String orientation,
    required String imageURL,
    required double rating,
  }) = _Branch;

  factory Branch.fromJson(Map<String, Object?> json) => _$BranchFromJson(json);
}
