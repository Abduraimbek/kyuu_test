import 'dart:convert';

import 'package:kyuu_test/common/extensions/ref_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/branch_info.dart';

part 'branch_info_controller.g.dart';

@riverpod
FutureOr<BranchInfo> fetchBranchInfo(
  FetchBranchInfoRef ref, {
  required String branchId,
}) async {
  final client = await ref.getDebouncedHttpClient();

  final response = await client
      .get(Uri.parse('http://mock.kyuu.uz/branch/get/one?id=$branchId'));
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  if (parsed['errorMessage'] != null) {
    throw parsed['errorMessage'];
  }

  return BranchInfo.fromJson(parsed['data']);
}

@riverpod
FutureOr<List<String>> fetchBranchGallery(
  FetchBranchGalleryRef ref, {
  required String branchId,
}) async {
  final client = await ref.getDebouncedHttpClient();

  final response = await client.get(Uri.parse(
      'http://mock.kyuu.uz/branch/get/one/gallery?branchId=$branchId'));
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  if (parsed['errorMessage'] != null) {
    throw parsed['errorMessage'];
  }

  List list = parsed['data'];

  return list.map((e) => e as String).toList();
}
