import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/view_model/article_web_view_view_model.dart';
import 'package:signals/signals_flutter.dart';
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
    viewModel.initController();
    viewModel.loadRequest(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    var uri = Uri.parse(widget.article.originHtmlUrl);
    var textTheme = Theme.of(context).textTheme;
    var textStyle = textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500);
    var title = Text(uri.host, style: textStyle);
    var popButton = TextButton(
      onPressed: () => AutoRouter.of(context).maybePop(),
      child: Text('关闭'),
    );
    return Scaffold(
      appBar: AppBar(title: title, leading: popButton),
      body: Watch(_buildBody),
    );
  }

  Widget _buildBody(context) {
    var lottie = Lottie.asset(
      'asset/json/loading.json',
      fit: BoxFit.cover,
      height: 120,
      width: 120,
    );
    var children = [
      WebViewWidget(controller: viewModel.controller),
      if (viewModel.loading.value) Center(child: lottie),
    ];
    return Stack(children: children);
  }
}
