import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/notice.dart';

class StorageService {
  static const String _storageKey = 'campus_connect_notices';

  Future<List<Notice>> loadNotices() async {
    final preferences = await SharedPreferences.getInstance();
    final savedData = preferences.getString(_storageKey);

    if (savedData == null || savedData.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(savedData) as List<dynamic>;
    return decoded
        .map((item) => Notice.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveNotices(List<Notice> notices) async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = jsonEncode(notices.map((notice) => notice.toJson()).toList());
    final saved = await preferences.setString(_storageKey, encoded);

    if (!saved) {
      throw Exception('The notices could not be saved on this device.');
    }
  }

  Future<void> clearNotices() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_storageKey);
  }
}
