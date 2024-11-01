import 'dart:developer';

import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';

mixin LoadingOverlayMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;

  Future<void> insetOverlay<Q>(
      BuildContext context, Future<Q> Function() action) async {
    if (_overlayEntry != null) {
      return;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: context.colorScheme.primary.withOpacity(.1),
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const CircularProgressIndicator.adaptive()),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    try {
      await action();
    } catch (e) {
      log(e.toString());
    } finally {
      removeOverlay();
    }
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    removeOverlay();
    super.didChangeDependencies();
  }
}
