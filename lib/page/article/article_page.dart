import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pure_news/database/article.dart';
import 'package:pure_news/page/article/component/image_placeholder.dart';
import 'package:pure_news/view_model/article_view_model.dart';

@RoutePage()
class ArticlePage extends StatefulWidget {
  final Article article;
  const ArticlePage({super.key, required this.article});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final viewModel = GetIt.instance<ArticleViewModel>();

  String get _originTitle => widget.article.originTitle;

  String get _publishedAt {
    var published = widget.article.published;
    var time = DateTime.fromMillisecondsSinceEpoch(published * 1000);
    return time.toString().substring(0, 19);
  }

  Widget blockquoteBuilder(String? text) {
    if (text == null) return const SizedBox();
    var colorScheme = Theme.of(context).colorScheme;
    var onSurface = colorScheme.onSurface.withValues(alpha: 0.5);
    var border = Border(left: BorderSide(color: onSurface, width: 4));
    return Container(
      decoration: BoxDecoration(border: border),
      padding: EdgeInsets.only(left: 12),
      child: Text(text, style: TextStyle(color: onSurface)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = [
      _buildArticleTitle(),
      _buildOriginTitleAndPublishAt(),
      _buildContent(),
    ];
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    var floatingActionButton = FloatingActionButton(
      onPressed: pushArticleWebViewPage,
      child: const Icon(HugeIcons.strokeRoundedLinkSquare02),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: SafeArea(child: column)),
      floatingActionButton: floatingActionButton,
    );
  }

  void pushArticleWebViewPage() {
    viewModel.pushArticleWebViewPage(context, widget.article);
  }

  Widget _buildArticleTitle() {
    var textStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.onSurface,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(widget.article.title, style: textStyle),
    );
  }

  Html _buildContent() {
    var htmlStyle = Style(padding: HtmlPaddings.zero, margin: Margins.zero);
    var bodyStyle = Style(
      padding: HtmlPaddings.symmetric(horizontal: 16),
      margin: Margins.zero,
    );
    var extensions = [
      ImageExtension(builder: _imageBuilder),
      _BlockquoteExtension(builder: blockquoteBuilder),
    ];
    return Html(
      data: widget.article.summaryContent,
      extensions: extensions,
      style: {'html': htmlStyle, 'body': bodyStyle},
    );
  }

  Widget _buildOriginTitleAndPublishAt() {
    var theme = Theme.of(context);
    var labelSmall = theme.textTheme.labelSmall;
    var onSurface = theme.colorScheme.onSurface;
    var originTitleTextStyle = labelSmall?.copyWith(
      fontWeight: FontWeight.w500,
      color: onSurface,
    );
    var publishedAtTextStyle = labelSmall?.copyWith(
      fontWeight: FontWeight.w400,
      color: onSurface.withValues(alpha: 0.5),
    );
    var children = [
      TextSpan(text: _originTitle, style: originTitleTextStyle),
      TextSpan(text: ' ', style: publishedAtTextStyle),
      TextSpan(text: _publishedAt, style: publishedAtTextStyle),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text.rich(TextSpan(children: children)),
    );
  }

  Widget _imageBuilder(context) {
    var src = context.attributes['src'] ?? '';
    if (src.trim().isEmpty) return const SizedBox();
    var placeholder = ImagePlaceholder(height: 300, width: double.infinity);
    return CachedNetworkImage(
      errorWidget: (context, url, error) => placeholder,
      fit: BoxFit.cover,
      imageUrl: src,
      placeholder: (context, url) => placeholder,
      width: double.infinity,
    );
  }
}

class _BlockquoteExtension extends HtmlExtension {
  Widget Function(String?)? builder;
  _BlockquoteExtension({this.builder});

  @override
  Set<String> get supportedTags => {'blockquote'};

  @override
  InlineSpan build(ExtensionContext context) {
    var child = builder?.call(context.element?.text);
    return WidgetSpan(child: child ?? const SizedBox());
  }
}
