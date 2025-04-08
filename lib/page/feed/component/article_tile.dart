import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/database/subscription.dart';

class ArticleTile extends StatefulWidget {
  final Article article;
  final void Function()? onTap;
  final Subscription? subscription;
  const ArticleTile({
    super.key,
    required this.article,
    this.onTap,
    this.subscription,
  });

  @override
  State<ArticleTile> createState() => _ArticleTileState();
}

class _ArticleTileState extends State<ArticleTile> {
  String get _host {
    var uri = Uri.tryParse(widget.article.originHtmlUrl);
    return uri?.host ?? 'widget.article.originHtmlUrl';
  }

  String get _timeAgo {
    var published = widget.article.published;
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
        widget.subscription?.title ?? widget.article.originTitle,
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
      _buildSubscriptionIcon(),
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
      children: [Expanded(child: _buildContent()), _buildCover()],
    );
    var children = [
      articleInformation,
      SizedBox(height: 4),
      Text(widget.article.title, style: titleTextStyle),
      SizedBox(height: 4),
      articleContent,
    ];
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      // color: Theme.of(context).colorScheme.surfaceContainerHigh,
    );
    var container = Container(
      decoration: boxDecoration,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: column,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: container,
    );
  }

  Widget _buildContent() {
    var document = parse(widget.article.summaryContent);
    return Text(
      document.body?.text.trim() ?? '',
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCover() {
    var document = parse(widget.article.summaryContent);
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

  ClipOval _buildSubscriptionIcon() {
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
      imageUrl: widget.subscription?.iconUrl ?? '',
      fit: BoxFit.cover,
      height: 40,
      width: 40,
      errorWidget: (context, url, error) => placeholder,
      placeholder: (context, url) => placeholder,
    );
    return ClipOval(child: cachedNetworkImage);
  }
}
