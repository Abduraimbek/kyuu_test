import 'dart:convert';

import 'package:kyuu_test/common/extensions/ref_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/branch.dart';

part 'branches_controller.g.dart';

@riverpod
FutureOr<List<Branch>> fetchBranches(FetchBranchesRef ref) async {
  final client = await ref.getDebouncedHttpClient();

  final response = await client
      .get(Uri.parse('http://mock.kyuu.uz/branch/nearest/list?lat=50&long=50'));
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  if (parsed['errorMessage'] != null) {
    throw parsed['errorMessage'];
  }

  List list = parsed['data'];

  return list.map((e) => Branch.fromJson(e)).toList();
}
