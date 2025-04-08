import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pure_news/route/route.gr.dart';

final globalKey = GlobalKey<NavigatorState>();

final pureNewsRouter = PureNewsRouter();

@AutoRouterConfig()
class PureNewsRouter extends RootStackRouter {
  PureNewsRouter() : super(navigatorKey: globalKey);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: BootstrapRoute.page, initial: true),
    AutoRoute(page: SignInEndpointRoute.page),
    AutoRoute(page: SignInUsernameRoute.page),
    AutoRoute(page: SignInPasswordRoute.page),
    AutoRoute(page: FeedRoute.page),
    AutoRoute(page: ArticleRoute.page),
    AutoRoute(page: ArticleWebViewRoute.page),
  ];
}
