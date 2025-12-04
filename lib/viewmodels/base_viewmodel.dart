import 'package:flutter/foundation.dart';

/// Base class for all ViewModels
/// Provides common state management functionality
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;

  /// Set loading state
  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  /// Set error state
  void setError(String? errorMessage) {
    if (_error != errorMessage) {
      _error = errorMessage;
      notifyListeners();
    }
  }

  /// Clear error state
  void clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  /// Reset all states
  void reset() {
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}

