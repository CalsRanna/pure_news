import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/route/route.gr.dart';
import 'package:pure_news/view_model/view_model.dart';

class ArticleViewModel extends ViewModel {
  void pushArticleWebViewPage(BuildContext context, Article article) {
    AutoRouter.of(context).push(ArticleWebViewRoute(article: article));
  }
}
