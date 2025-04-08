import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pure_news/route/route.gr.dart';
import 'package:pure_news/service/service.dart';
import 'package:pure_news/util/shared_preferences_util.dart';
import 'package:pure_news/view_model/view_model.dart';

class SignInUsernameViewModel extends ViewModel {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> initController() async {
    var username = await SharedPreferencesUtil.getUsername();
    controller.text = username;
  }

  Future<void> pushSignInPasswordPage(BuildContext context) async {
    await SharedPreferencesUtil.setUsername(controller.text);
    ServiceOption.instance.username = controller.text;
    if (!context.mounted) return;
    AutoRouter.of(context).push(SignInPasswordRoute());
  }
}
