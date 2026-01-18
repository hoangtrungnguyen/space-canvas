import 'package:flutter/material.dart';

mixin NetworkListenerMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;
  bool _isDialogShowing = false;

  void showNoInternetDialog() {
    if (!_isDialogShowing) {
      _isDialogShowing = true;
      _overlayEntry = OverlayEntry(
        builder:
            (context) => PopScope(
              canPop: false, // Prevent dialog from being dismissed
              child: AlertDialog(
                title: const Text('No Internet Connection'),
                content: const Text(
                  'Please check your internet connection and try again.',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // You might trigger a recheck here if needed,
                      // or rely on the BLoC to update when connection is restored.
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop(); // Dismiss only if needed
                      hideNoInternetDialog();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
      );
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void hideNoInternetDialog() {
    if (_isDialogShowing && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isDialogShowing = false;
    }
  }

  @override
  void dispose() {
    hideNoInternetDialog(); // Ensure dialog is hidden when the state is disposed
    super.dispose();
  }
}
