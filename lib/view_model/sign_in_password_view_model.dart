import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pure_news/route/route.gr.dart';
import 'package:pure_news/service/authentication_service.dart';
import 'package:pure_news/service/service.dart';
import 'package:pure_news/util/dialog_util.dart';
import 'package:pure_news/util/shared_preferences_util.dart';
import 'package:pure_news/view_model/view_model.dart';

class SignInPasswordViewModel extends ViewModel {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> initController() async {
    var password = await SharedPreferencesUtil.getPassword();
    controller.text = password;
  }

  Future<void> signIn(BuildContext context) async {
    await SharedPreferencesUtil.setPassword(controller.text);
    ServiceOption.instance.password = controller.text;
    try {
      var auth = await AuthenticationService().signIn(
        endpoint: ServiceOption.instance.endpoint,
        password: ServiceOption.instance.password,
        username: ServiceOption.instance.username,
      );
      await SharedPreferencesUtil.setAuth(auth);
      ServiceOption.instance.auth = auth;
      if (!context.mounted) return;
      AutoRouter.of(context).replaceAll([const FeedRoute()]);
    } catch (error) {
      if (!context.mounted) return;
      DialogUtil.error(error);
    }
  }
}
