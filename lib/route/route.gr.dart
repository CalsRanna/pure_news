// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:pure_news/database/article.dart' as _i11;
import 'package:pure_news/page/article/article_page.dart' as _i1;
import 'package:pure_news/page/article/article_web_view_page.dart' as _i2;
import 'package:pure_news/page/bootstrap/bootstrap_page.dart' as _i3;
import 'package:pure_news/page/feed/feed_page.dart' as _i4;
import 'package:pure_news/page/profile/profile_page.dart' as _i5;
import 'package:pure_news/page/sign_in/sign_in_endpoint_page.dart' as _i6;
import 'package:pure_news/page/sign_in/sign_in_password_page.dart' as _i7;
import 'package:pure_news/page/sign_in/sign_in_username_page.dart' as _i8;

/// generated route for
/// [_i1.ArticlePage]
class ArticleRoute extends _i9.PageRouteInfo<ArticleRouteArgs> {
  ArticleRoute({
    _i10.Key? key,
    required _i11.Article article,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         ArticleRoute.name,
         args: ArticleRouteArgs(key: key, article: article),
         initialChildren: children,
       );

  static const String name = 'ArticleRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ArticleRouteArgs>();
      return _i1.ArticlePage(key: args.key, article: args.article);
    },
  );
}

class ArticleRouteArgs {
  const ArticleRouteArgs({this.key, required this.article});

  final _i10.Key? key;

  final _i11.Article article;

  @override
  String toString() {
    return 'ArticleRouteArgs{key: $key, article: $article}';
  }
}

/// generated route for
/// [_i2.ArticleWebViewPage]
class ArticleWebViewRoute extends _i9.PageRouteInfo<ArticleWebViewRouteArgs> {
  ArticleWebViewRoute({
    _i10.Key? key,
    required _i11.Article article,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         ArticleWebViewRoute.name,
         args: ArticleWebViewRouteArgs(key: key, article: article),
         initialChildren: children,
       );

  static const String name = 'ArticleWebViewRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ArticleWebViewRouteArgs>();
      return _i2.ArticleWebViewPage(key: args.key, article: args.article);
    },
  );
}

class ArticleWebViewRouteArgs {
  const ArticleWebViewRouteArgs({this.key, required this.article});

  final _i10.Key? key;

  final _i11.Article article;

  @override
  String toString() {
    return 'ArticleWebViewRouteArgs{key: $key, article: $article}';
  }
}

/// generated route for
/// [_i3.BootstrapPage]
class BootstrapRoute extends _i9.PageRouteInfo<void> {
  const BootstrapRoute({List<_i9.PageRouteInfo>? children})
    : super(BootstrapRoute.name, initialChildren: children);

  static const String name = 'BootstrapRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.BootstrapPage();
    },
  );
}

/// generated route for
/// [_i4.FeedPage]
class FeedRoute extends _i9.PageRouteInfo<void> {
  const FeedRoute({List<_i9.PageRouteInfo>? children})
    : super(FeedRoute.name, initialChildren: children);

  static const String name = 'FeedRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.FeedPage();
    },
  );
}

/// generated route for
/// [_i5.ProfilePage]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfilePage();
    },
  );
}

/// generated route for
/// [_i6.SignInEndpointPage]
class SignInEndpointRoute extends _i9.PageRouteInfo<void> {
  const SignInEndpointRoute({List<_i9.PageRouteInfo>? children})
    : super(SignInEndpointRoute.name, initialChildren: children);

  static const String name = 'SignInEndpointRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.SignInEndpointPage();
    },
  );
}

/// generated route for
/// [_i7.SignInPasswordPage]
class SignInPasswordRoute extends _i9.PageRouteInfo<void> {
  const SignInPasswordRoute({List<_i9.PageRouteInfo>? children})
    : super(SignInPasswordRoute.name, initialChildren: children);

  static const String name = 'SignInPasswordRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SignInPasswordPage();
    },
  );
}

/// generated route for
/// [_i8.SignInUsernamePage]
class SignInUsernameRoute extends _i9.PageRouteInfo<void> {
  const SignInUsernameRoute({List<_i9.PageRouteInfo>? children})
    : super(SignInUsernameRoute.name, initialChildren: children);

  static const String name = 'SignInUsernameRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.SignInUsernamePage();
    },
  );
}
