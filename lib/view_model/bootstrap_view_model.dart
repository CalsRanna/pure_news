import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:pure_news/route/route.gr.dart';
import 'package:pure_news/service/service.dart';
import 'package:pure_news/util/shared_preferences_util.dart';
import 'package:pure_news/view_model/view_model.dart';

class BootstrapViewModel extends ViewModel {
  void bootstrap(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var auth = await SharedPreferencesUtil.getAuth();
      ServiceOption.instance.auth = auth;
      var endpoint = await SharedPreferencesUtil.getEndpoint();
      ServiceOption.instance.endpoint = endpoint;
      PageRouteInfo route = const FeedRoute();
      if (auth.isEmpty || endpoint.isEmpty) route = const SignInEndpointRoute();
      if (!context.mounted) return;
      AutoRouter.of(context).replace(route);
    });
  }
}
