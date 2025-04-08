import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/database/subscription.dart';
import 'package:pure_news/route/route.gr.dart';
import 'package:pure_news/service/subscription_service.dart';
import 'package:pure_news/util/dialog_util.dart';
import 'package:pure_news/view_model/view_model.dart';
import 'package:signals/signals.dart';

class FeedViewModel extends ViewModel {
  final _service = SubscriptionService();
  var subscriptions = signal(<Subscription>[]);
  var articles = signal(<Article>[]);

  Future<void> getSubscriptions() async {
    try {
      DialogUtil.loading();
      subscriptions.value = await _service.getSubscriptions();
      List<Article> unsortedArticles = [];
      for (var subscription in subscriptions.value) {
        var items = await _service.getArticles(subscription);
        unsortedArticles.addAll(items);
      }
      unsortedArticles.sort((a, b) => b.published.compareTo(a.published));
      articles.value = unsortedArticles;
      DialogUtil.dismiss();
    } catch (error) {
      DialogUtil.dismiss();
      DialogUtil.error(error);
    }
  }

  void pushArticlePage(BuildContext context, Article article) {
    AutoRouter.of(context).push(ArticleRoute(article: article));
  }

  Subscription? getSubscriptionByArticle(Article article) {
    return subscriptions.value
        .where((subscription) => subscription.id == article.originStreamId)
        .firstOrNull;
  }
}
