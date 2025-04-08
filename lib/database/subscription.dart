class Subscription {
  String id = '';
  String title = '';
  String url = '';
  String htmlUrl = '';
  String iconUrl = '';

  Subscription.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    htmlUrl = json['htmlUrl'];
    iconUrl = json['iconUrl'];
  }
}
