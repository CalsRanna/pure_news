import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      viewModel.getSubscriptions();
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Watch((context) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    HugeIcons.strokeRoundedDashboardCircleSettings,
                  ),
                ),
                IconButton(
                  onPressed: viewModel.getSubscriptions,
                  icon: const Icon(HugeIcons.strokeRoundedRefresh),
                ),
              ],
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(16),
                title: const Text('All Feeds'),
                centerTitle: false,
              ),
              pinned: true,
              stretch: true,
            ),
            SliverList.separated(
              itemBuilder: (context, index) {
                return ArticleTile(
                  article: viewModel.articles.value[index],
                  onTap:
                      () => viewModel.pushArticlePage(
                        context,
                        viewModel.articles.value[index],
                      ),
                  subscription: viewModel.getSubscriptionByArticle(
                    viewModel.articles.value[index],
                  ),
                );
              },
              itemCount: viewModel.articles.value.length,
              separatorBuilder: _buildSeparator,
            ),
          ],
        );
      }),
    );
  }

  Widget? _buildSeparator(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Divider(color: Theme.of(context).colorScheme.surfaceContainerHigh),
    );
  }
}
