import 'package:challange_beclever/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String titleLabel;
  final Widget? leading, floatingActionButton, body;
  final bool showCloseButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const CustomScaffold({
    super.key,
    required this.titleLabel,
    this.leading,
    this.showCloseButton = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        backgroundColor: context.colorScheme.primary,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        appBar: AppBar(
          backgroundColor: context.colorScheme.primary,
          title: Text(
            titleLabel,
            style: context.theme.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          automaticallyImplyLeading: false,
          leading: leading,
          actions: [
            if (showCloseButton)
              CloseButton(
                color: context.colorScheme.onPrimary,
              )
          ],
        ),
        body: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              color: context.colorScheme.onPrimary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              )),
          child: body,
        ),
      ),
    );
  }
}
