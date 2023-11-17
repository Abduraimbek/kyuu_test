import 'package:kyuu_test/common/extensions/ref_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/package.dart';
import '../model/package_info.dart';

part 'package_info_controller.g.dart';

@riverpod
FutureOr<List<Package>> fetchPackages(
  FetchPackagesRef ref, {
  required String branchId,
}) async {
  final data = await ref
      .fetchData('http://mock.kyuu.uz/branch/get/package?branchId=$branchId');

  List list = data['data'];

  return list.map((e) => Package.fromJson(e)).toList();
}

@riverpod
FutureOr<PackageInfo> fetchPackageInfo(
  FetchPackageInfoRef ref, {
  required int packageId,
}) async {
  final data = await ref.fetchData(
      'http://mock.kyuu.uz/branch/get/package/full-info?packageId=$packageId');

  return PackageInfo.fromJson(data['data']);
}
