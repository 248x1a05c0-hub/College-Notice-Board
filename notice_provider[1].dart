import 'package:flutter/foundation.dart';

import '../models/notice.dart';
import '../services/storage_service.dart';

class NoticeProvider extends ChangeNotifier {
  NoticeProvider(this._storageService);

  final StorageService _storageService;

  List<Notice> _notices = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedDepartment = 'All';
  String _searchQuery = '';

  List<Notice> get notices => List.unmodifiable(_notices);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedDepartment => _selectedDepartment;
  String get searchQuery => _searchQuery;

  List<Notice> get filteredNotices {
    return _notices.where((notice) {
      final matchesDepartment = _selectedDepartment == 'All' ||
          notice.department == _selectedDepartment;
      final query = _searchQuery.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          notice.title.toLowerCase().contains(query) ||
          notice.description.toLowerCase().contains(query) ||
          notice.department.toLowerCase().contains(query);
      return matchesDepartment && matchesSearch;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> loadNotices() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _notices = await _storageService.loadNotices();
    } catch (_) {
      _errorMessage = 'Unable to load notices. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNotice(Notice notice) async {
    final updatedNotices = [..._notices, notice];
    await _storageService.saveNotices(updatedNotices);
    _notices = updatedNotices;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> deleteNotice(String id) async {
    final updatedNotices =
        _notices.where((notice) => notice.id != id).toList();
    await _storageService.saveNotices(updatedNotices);
    _notices = updatedNotices;
    notifyListeners();
  }

  void selectDepartment(String department) {
    _selectedDepartment = department;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearFilters() {
    _selectedDepartment = 'All';
    _searchQuery = '';
    notifyListeners();
  }
}
