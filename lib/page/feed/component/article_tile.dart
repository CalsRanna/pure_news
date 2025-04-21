import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/database/subscription.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  final void Function()? onTap;
  final Subscription? subscription;
  const ArticleTile({
    super.key,
    required this.article,
    this.onTap,
    this.subscription,
  });

  String get _host {
    var uri = Uri.tryParse(article.originHtmlUrl);
    return uri?.host ?? 'article.originHtmlUrl';
  }

  String get _timeAgo {
    var published = article.published;
    var time = DateTime.fromMillisecondsSinceEpoch(published * 1000);
    var now = DateTime.now();
    var diff = now.difference(time);
    if (diff.inDays > 0) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    var titleTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.onSurface,
    );
    var subtitleTextStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
    );
    var feedInformationChildren = [
      Text(
        subscription?.title ?? article.originTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: titleTextStyle,
      ),
      Text(_host, style: subtitleTextStyle),
    ];
    var feedInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: feedInformationChildren,
    );
    var articleInformationChildren = [
      _buildSubscriptionIcon(context),
      const SizedBox(width: 4),
      Expanded(child: feedInformation),
      const SizedBox(width: 4),
      Text(_timeAgo, style: subtitleTextStyle),
    ];
    var articleInformation = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: articleInformationChildren,
    );
    var articleContent = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Expanded(child: _buildContent()), _buildCover(context)],
    );
    var children = [
      articleInformation,
      SizedBox(height: 4),
      Text(article.title, style: titleTextStyle),
      SizedBox(height: 4),
      articleContent,
    ];
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    var padding = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: column,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: padding,
    );
  }

  Widget _buildContent() {
    var document = parse(article.summaryContent);
    return Text(
      document.body?.text.trim() ?? '',
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCover(BuildContext context) {
    var document = parse(article.summaryContent);
    var imageElement = document.querySelector('img');
    var src = imageElement?.attributes['src'] ?? '';
    var href = imageElement?.attributes['href'] ?? '';
    if (src.isEmpty && href.isEmpty) return const SizedBox.shrink();
    var icon = Icon(
      HugeIcons.strokeRoundedImage02,
      size: 40,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
    );
    var placeholder = Container(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      height: 80,
      width: 80,
      child: icon,
    );
    var cachedNetworkImage = CachedNetworkImage(
      imageUrl: src.isNotEmpty ? src : href,
      fit: BoxFit.cover,
      height: 80,
      width: 80,
      errorWidget: (context, url, error) => placeholder,
      placeholder: (context, url) => placeholder,
    );
    var clipRRect = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: cachedNetworkImage,
    );
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: clipRRect,
    );
  }

  ClipOval _buildSubscriptionIcon(BuildContext context) {
    var icon = Icon(
      HugeIcons.strokeRoundedRss,
      size: 20,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
    );
    var placeholder = Container(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      height: 40,
      width: 40,
      child: icon,
    );
    var cachedNetworkImage = CachedNetworkImage(
      imageUrl: (subscription?.iconUrl ?? '').replaceAll(
        '43.139.61.244',
        '43.139.61.244:8080',
      ),
      fit: BoxFit.cover,
      height: 40,
      width: 40,
      errorWidget: (context, url, error) => placeholder,
      placeholder: (context, url) => placeholder,
    );
    return ClipOval(child: cachedNetworkImage);
  }
}
