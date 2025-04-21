import 'package:auto_route/auto_route.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/page/feed/component/article_tile.dart';
import 'package:pure_news/view_model/feed_view_model.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class FeedPage extends StatefulWidget {
  const FeedPage({super.key});
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final viewModel = GetIt.instance<FeedViewModel>();

  @override
  Widget build(BuildContext context) {
    var iconButton = IconButton(
      onPressed: () {},
      icon: Icon(HugeIcons.strokeRoundedUserList),
    );
    var appBar = AppBar(
      title: Text('所有订阅', style: TextStyle(fontWeight: FontWeight.w700)),
      centerTitle: false,
      actions: [iconButton],
    );
    var body = Watch(
      (context) => CustomRefreshIndicator(
        builder: _buildRefreshIndicator,
        onRefresh: viewModel.refreshSubscriptions,
        child: _buildListView(),
      ),
    );
    return Scaffold(appBar: appBar, body: body);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      viewModel.initSubscriptions();
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    var article = viewModel.articles.value[index];
    return ArticleTile(
      article: article,
      onTap: () => _pushArticlePage(article),
      subscription: viewModel.getSubscriptionByArticle(article),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemBuilder: _buildItem,
      itemCount: viewModel.articles.value.length,
      separatorBuilder: _buildSeparator,
    );
  }

  Widget _buildLottie(IndicatorController controller) {
    return Lottie.asset(
      'asset/json/loading.json',
      animate: controller.isLoading ? true : false,
      fit: BoxFit.cover,
      height: controller.value * 120,
    );
  }

  Widget _buildRefreshIndicator(context, child, controller) {
    return Column(children: [_buildLottie(controller), Expanded(child: child)]);
  }

  Widget _buildSeparator(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: Theme.of(context).colorScheme.surfaceContainerHigh),
    );
  }

  void _pushArticlePage(Article article) {
    viewModel.pushArticlePage(context, article);
  }
}
