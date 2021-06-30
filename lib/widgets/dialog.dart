import 'package:ecommerce_app_eid/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CDialog {
  ProgressDialog dialog;

  CDialog(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    pr.style(
      message: getTranslated(context, 'Please_wait'),
    );
    dialog = pr;
  }
}
