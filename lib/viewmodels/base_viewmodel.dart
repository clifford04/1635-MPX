import 'package:flutter/foundation.dart';

/// Base class for all ViewModels
/// Provides common state management functionality
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  /// Safely notify listeners if not disposed
  void safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  /// Set loading state
  void setLoading(bool value) {
    if (_isDisposed) return; // Prevent calling after disposal
    if (_isLoading != value) {
      _isLoading = value;
      safeNotifyListeners();
    }
  }

  /// Set error state
  void setError(String? errorMessage) {
    if (_isDisposed) return;
    if (_error != errorMessage) {
      _error = errorMessage;
      safeNotifyListeners();
    }
  }

  /// Clear error state
  void clearError() {
    if (_isDisposed) return;
    if (_error != null) {
      _error = null;
      safeNotifyListeners();
    }
  }

  /// Reset all states
  void reset() {
    if (_isDisposed) return;
    _isLoading = false;
    _error = null;
    safeNotifyListeners();
  }
}

