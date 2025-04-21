import 'package:get_it/get_it.dart';
import 'package:pure_news/database/subscription.dart';
import 'package:pure_news/util/shared_preferences_util.dart';
import 'package:pure_news/view_model/feed_view_model.dart';
import 'package:pure_news/view_model/view_model.dart';
import 'package:signals/signals_flutter.dart';

class ProfileViewModel extends ViewModel {
  final _feedViewModel = GetIt.instance<FeedViewModel>();
  var endpoint = signal('');
  var password = signal('');
  var username = signal('');

  String get formattedPassword {
    return password.value.split('').map((_) => '*').join();
  }

  List<Subscription> get subscriptions => _feedViewModel.subscriptions.value;

  Future<void> init() async {
    endpoint.value = await SharedPreferencesUtil.getEndpoint();
    password.value = await SharedPreferencesUtil.getPassword();
    username.value = await SharedPreferencesUtil.getUsername();
  }
}
