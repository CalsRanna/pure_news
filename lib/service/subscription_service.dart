import 'package:pure_news/database/article.dart';
import 'package:pure_news/database/subscription.dart';
import 'package:pure_news/service/service.dart';

class SubscriptionService with ServiceMixin {
  Future<List<Subscription>> getSubscriptions() async {
    var response = await get('/reader/api/0/subscription/list?output=json');
    return response['subscriptions']
        .map<Subscription>(Subscription.fromJson)
        .toList();
  }

  Future<List<Article>> getArticles(Subscription subscription) async {
    var response = await get(
      '/reader/api/0/stream/contents/${subscription.id}',
    );
    return response['items'].map<Article>(Article.fromJson).toList();
  }
}
