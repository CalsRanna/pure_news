import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pure_news/route/route.gr.dart';
import 'package:pure_news/service/service.dart';
import 'package:pure_news/util/shared_preferences_util.dart';
import 'package:pure_news/view_model/view_model.dart';

class SignInEndpointViewModel extends ViewModel {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> initController() async {
    var endpoint = await SharedPreferencesUtil.getEndpoint();
    controller.text = endpoint;
  }

  Future<void> pushSignInUsernamePage(BuildContext context) async {
    await SharedPreferencesUtil.setEndpoint(controller.text);
    ServiceOption.instance.endpoint = controller.text;
    if (!context.mounted) return;
    AutoRouter.of(context).push(SignInUsernameRoute());
  }
}
