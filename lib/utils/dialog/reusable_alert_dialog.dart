import 'dart:io';

import 'package:brothers_creative/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableAlertDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) async {
    final localizations = AppLocalizations.of(context);
    if (Platform.isIOS) {
      // iOS-style dialog
      await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
            content:
                Text(content, style: Theme.of(context).textTheme.bodyMedium),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(localizations!.cancel,
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text(localizations.verify,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.apply(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Android-style dialog
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
            content:
                Text(content, style: Theme.of(context).textTheme.bodyMedium),
            actions: <Widget>[
              TextButton(
                child: Text(localizations!.cancel,
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(localizations.verify,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.apply(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
