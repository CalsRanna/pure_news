import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pure_news/route/route.dart';

class DialogUtil {
  static void dismiss() {
    Navigator.of(globalKey.currentContext!).maybePop();
  }

  static void error(Object error) {
    showDialog(
      builder: (context) => _ErrorDialog(error),
      context: globalKey.currentContext!,
    );
  }

  static void loading({bool barrierDismissible = false}) {
    showDialog(
      barrierDismissible: barrierDismissible,
      builder: (context) => _LoadingDialog(),
      context: globalKey.currentContext!,
    );
  }
}

class _ErrorDialog extends StatelessWidget {
  final Object error;
  const _ErrorDialog(this.error);

  @override
  Widget build(BuildContext context) {
    var okTextButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('OK'),
    );
    return AlertDialog(
      actions: [okTextButton],
      content: Text(error.toString()),
      title: Text(error.runtimeType.toString()),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    var lottie = Lottie.asset(
      'asset/json/loading.json',
      fit: BoxFit.cover,
      height: 120,
      width: 120,
    );
    return UnconstrainedBox(child: lottie);
  }
}
