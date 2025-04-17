import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/view_model/article_web_view_view_model.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

@RoutePage()
class ArticleWebViewPage extends StatefulWidget {
  final Article article;
  const ArticleWebViewPage({super.key, required this.article});

  @override
  State<ArticleWebViewPage> createState() => _ArticleWebViewPageState();
}

class _ArticleWebViewPageState extends State<ArticleWebViewPage> {
  final viewModel = GetIt.instance<ArticleWebViewViewModel>();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel.loadRequest(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    var uri = Uri.parse(widget.article.originHtmlUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text(uri.host, style: Theme.of(context).textTheme.bodyMedium),
        leading: TextButton(
          onPressed: () => AutoRouter.of(context).maybePop(),
          child: Text('关闭'),
        ),
      ),
      body: WebViewWidget(controller: viewModel.controller),
    );
  }
}
