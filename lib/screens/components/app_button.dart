import 'package:flutter/material.dart';

enum ConfirmOrCancel { confirm, cancel }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.inscription,
    this.backgroundColor,
    required this.buttonAction,
    super.key,
    this.padding,
    this.confirmOrCancel,
  });

  final String inscription;
  final Color? backgroundColor;
  final void Function()? buttonAction;
  final EdgeInsets? padding;
  final ConfirmOrCancel? confirmOrCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: buttonAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmOrCancel != null
                    ? confirmOrCancel == ConfirmOrCancel.confirm
                    ? const Color(0xFF42C0E2)
                    : Colors.red
                    : backgroundColor ?? const Color(0xFF42C0E2),
              ),
              child: Text(inscription),
            ),
          ),
        ],
      ),
    );
  }
}