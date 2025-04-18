class Article {
  String id = '';
  int published = 0;
  String title = '';
  String canonicalHref = '';
  String originStreamId = '';
  String originHtmlUrl = '';
  String originTitle = '';
  String summaryContent = '';

  Article.fromJson(dynamic json) {
    id = json['id'];
    published = json['published'];
    title = json['title'];
    var canonical = json['canonical'];
    if (canonical != null) {
      canonicalHref = canonical[0]['href'];
    }
    var origin = json['origin'];
    if (origin != null) {
      originStreamId = origin['streamId'];
      originHtmlUrl = origin['htmlUrl'];
      originTitle = origin['title'];
    }
    var summary = json['summary'];
    if (summary != null) {
      summaryContent = summary['content'];
    }
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['id'] = id;
    json['published'] = published;
    json['title'] = title;
    json['canonicalHref'] = canonicalHref;
    json['originStreamId'] = originStreamId;
    json['originHtmlUrl'] = originHtmlUrl;
    json['originTitle'] = originTitle;
    json['summaryContent'] = summaryContent;
    return json;
  }

  @override
  String toString() {
    return 'Article${toJson()}';
  }
}
