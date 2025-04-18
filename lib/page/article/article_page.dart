// ignore_for_file: unused_element_parameter

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:get_it/get_it.dart';
import 'package:html/dom.dart' hide Text;
import 'package:html/parser.dart';
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

  @override
  Widget build(BuildContext context) {
    var render = _Render(html: widget.article.summaryContent);
    var children = [
      _buildArticleTitle(),
      _buildOriginTitleAndPublishAt(),
      ...render.build(),
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
}

class _Render {
  final TextStyle? aTextStyle;
  final TextStyle? bTextStyle;
  final TextStyle? h2TextStyle;
  final TextStyle? h3TextStyle;
  final String html;
  final TextStyle? pTextStyle;

  final List<Widget> _children = [];

  _Render({
    this.aTextStyle,
    this.bTextStyle,
    this.h2TextStyle,
    this.h3TextStyle,
    required this.html,
    this.pTextStyle,
  });

  List<Widget> build() {
    var document = parse(html);
    for (var child in document.children) {
      _renderNode(child);
    }
    return _children;
  }

  Widget _buildATag(Element a) {
    var textStyle = TextStyle(color: Colors.blue);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Text(a.text, style: textStyle.merge(aTextStyle)),
    );
  }

  Widget _buildBTag(Element b) {
    if (b.text.trim().isEmpty) return const SizedBox();
    var textStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Text(b.text, style: textStyle.merge(pTextStyle)),
    );
  }

  Widget _buildH2Tag(Element h2) {
    var textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(h2.text, style: textStyle.merge(h2TextStyle)),
    );
  }

  Widget _buildH3Tag(Element h3) {
    var textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(h3.text, style: textStyle.merge(h3TextStyle)),
    );
  }

  Widget _buildHrTag(Element h3) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Divider(height: 1),
    );
  }

  Widget _buildImgTag(Element node) {
    var src = node.attributes['src'] ?? '';
    if (src.trim().isEmpty) return const SizedBox();
    var alt = node.attributes['alt'] ?? '';
    var placeholder = ImagePlaceholder(height: 300, width: double.infinity);
    var image = CachedNetworkImage(
      errorWidget: (context, url, error) => placeholder,
      placeholder: (context, url) => placeholder,
      imageUrl: src,
    );
    var children = [
      image,
      if (alt.trim().isNotEmpty) const SizedBox(height: 4),
      if (alt.trim().isNotEmpty) Text(alt),
    ];
    return Column(children: children);
  }

  Widget _buildPTag(Element p) {
    if (p.text.trim().isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Text(p.text, style: pTextStyle),
    );
  }

  Widget _buildSpanTag(Element span) {
    if (span.text.trim().isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Text(span.text, style: pTextStyle),
    );
  }

  Widget _buildUnsupportedTag(Element tag) {
    if (kReleaseMode) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Text('$tag ${tag.text}', style: pTextStyle),
    );
  }

  void _renderNode(Element node) {
    switch (node.localName) {
      case 'a':
        _children.add(_buildATag(node));
        break;
      case 'b':
        _children.add(_buildBTag(node));
        break;
      case 'h2':
        _children.add(_buildH2Tag(node));
        break;
      case 'h3':
        _children.add(_buildH3Tag(node));
        break;
      case 'hr':
        _children.add(_buildHrTag(node));
        break;
      case 'img':
        _children.add(_buildImgTag(node));
        break;
      case 'p':
        _children.add(_buildPTag(node));
      case 'span':
        _children.add(_buildSpanTag(node));
        break;
      default:
        if (node.children.isNotEmpty) {
          for (var child in node.children) {
            _renderNode(child);
          }
        } else {
          _children.add(_buildUnsupportedTag(node));
        }
        break;
    }
  }
}
