import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/view_model/view_model.dart';
import 'package:signals/signals_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class ArticleWebViewViewModel extends ViewModel {
  final controller = WebViewControllerPlus();
  var loading = signal(true);

  @override
  void dispose() {
    GetIt.instance.resetLazySingleton<ArticleWebViewViewModel>();
    super.dispose();
  }

  void initController() {
    controller.setNavigationDelegate(
      NavigationDelegate(onPageFinished: (_) => loading.value = false),
    );
  }

  Future<void> loadRequest(Article article) async {
    controller.setBackgroundColor(Colors.transparent);
    var uri = Uri.parse(article.canonicalHref);
    controller.loadRequest(uri);
  }
}
