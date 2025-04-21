import 'package:get_it/get_it.dart';
import 'package:pure_news/view_model/article_view_model.dart';
import 'package:pure_news/view_model/article_web_view_view_model.dart';
import 'package:pure_news/view_model/bootstrap_view_model.dart';
import 'package:pure_news/view_model/feed_view_model.dart';
import 'package:pure_news/view_model/profile_view_model.dart';
import 'package:pure_news/view_model/sign_in_endpoint_view_model.dart';
import 'package:pure_news/view_model/sign_in_password_view_model.dart';
import 'package:pure_news/view_model/sign_in_username_view_model.dart';

class DependencyInjection {
  static void ensureInitialized() {
    GetIt.instance.registerLazySingleton<BootstrapViewModel>(
      () => BootstrapViewModel(),
    );
    GetIt.instance.registerLazySingleton<SignInEndpointViewModel>(
      () => SignInEndpointViewModel(),
    );
    GetIt.instance.registerLazySingleton<SignInUsernameViewModel>(
      () => SignInUsernameViewModel(),
    );
    GetIt.instance.registerLazySingleton<SignInPasswordViewModel>(
      () => SignInPasswordViewModel(),
    );
    GetIt.instance.registerLazySingleton<FeedViewModel>(() => FeedViewModel());
    GetIt.instance.registerLazySingleton<ArticleViewModel>(
      () => ArticleViewModel(),
    );
    GetIt.instance.registerLazySingleton<ArticleWebViewViewModel>(
      () => ArticleWebViewViewModel(),
    );
    GetIt.instance.registerLazySingleton<ProfileViewModel>(
      () => ProfileViewModel(),
    );
  }
}
