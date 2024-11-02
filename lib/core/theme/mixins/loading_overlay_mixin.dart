import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';

mixin LoadingOverlayMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry createOverlay() {
    return OverlayEntry(
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
  }
}
