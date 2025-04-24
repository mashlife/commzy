import 'package:flutter/material.dart';

Future<void> mainLoading(BuildContext context) {
  return showGeneralDialog(
    barrierDismissible: false,
    barrierLabel: 'Loading',
    context: context,
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
        child: Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
