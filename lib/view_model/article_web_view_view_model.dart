import 'package:get_it/get_it.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/view_model/view_model.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class ArticleWebViewViewModel extends ViewModel {
  final controller = WebViewControllerPlus();

  @override
  void dispose() {
    GetIt.instance.resetLazySingleton<ArticleWebViewViewModel>();
    super.dispose();
  }

  Future<void> loadRequest(Article article) async {
    var uri = Uri.parse(article.canonicalHref);
    controller.loadRequest(uri);
  }
}
