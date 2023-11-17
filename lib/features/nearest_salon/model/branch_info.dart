import 'package:json_annotation/json_annotation.dart';

part 'branch_info.g.dart';

@JsonSerializable()
class BranchInfo {
  final String id;
  final String status;
  final String name;
  final double space;
  final List<String> images;
  final BranchInfoAddress address;
  final BranchInfoOpenHours openHours;
  final BranchInfoAbout about;
  final List<BranchInfoExpert> experts;

  const BranchInfo({
    required this.id,
    required this.status,
    required this.name,
    required this.space,
    required this.images,
    required this.address,
    required this.openHours,
    required this.about,
    required this.experts,
  });

  factory BranchInfo.fromJson(Map<String, dynamic> json) =>
      _$BranchInfoFromJson(json);
}

@JsonSerializable()
class BranchInfoAddress {
  final String address;
  final String orientation;
  final double longitude;
  final double latitude;
  final String mapPicture;

  const BranchInfoAddress({
    required this.address,
    required this.orientation,
    required this.longitude,
    required this.latitude,
    required this.mapPicture,
  });

  factory BranchInfoAddress.fromJson(Map<String, dynamic> json) =>
      _$BranchInfoAddressFromJson(json);
}

@JsonSerializable()
class BranchInfoOpenHours {
  final BranchInfoOpenHoursWeekDays weekDays;
  final BranchInfoOpenHoursWeekEnds weekEnds;

  const BranchInfoOpenHours({
    required this.weekDays,
    required this.weekEnds,
  });

  factory BranchInfoOpenHours.fromJson(Map<String, dynamic> json) =>
      _$BranchInfoOpenHoursFromJson(json);
}

@JsonSerializable()
class BranchInfoOpenHoursWeekDays {
  final String openAt;
  final String closeAt;

  const BranchInfoOpenHoursWeekDays({
    required this.openAt,
    required this.closeAt,
  });

  factory BranchInfoOpenHoursWeekDays.fromJson(Map<String, dynamic> json) =>
      _$BranchInfoOpenHoursWeekDaysFromJson(json);
}

@JsonSerializable()
class BranchInfoOpenHoursWeekEnds {
  final String openAt;
  final String closeAt;

  const BranchInfoOpenHoursWeekEnds({
    required this.openAt,
    required this.closeAt,
  });

  factory BranchInfoOpenHoursWeekEnds.fromJson(Map<String, dynamic> json) =>
      _$BranchInfoOpenHoursWeekEndsFromJson(json);
}

@JsonSerializable()
class BranchInfoAbout {
  final String text;
  final String website;
  final List<String> contact;

  const BranchInfoAbout({
    required this.text,
    required this.website,
    required this.contact,
  });

  factory BranchInfoAbout.fromJson(Map<String, dynamic> json) =>
      _$BranchInfoAboutFromJson(json);
}

@JsonSerializable()
class BranchInfoExpert {
  final int id;
  final String name;
  final String role;
  final String imageUrl;

  const BranchInfoExpert({
    required this.id,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  factory BranchInfoExpert.fromJson(Map<String, dynamic> json) =>
      _$BranchInfoExpertFromJson(json);
}
