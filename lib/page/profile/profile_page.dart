import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pure_news/view_model/profile_view_model.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final viewModel = GetIt.instance<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text('个人设置')),
      body: Watch((context) {
        var wrap = Wrap(
          alignment: WrapAlignment.start,
          spacing: 8,
          children: _buildChildren(),
        );
        var children = [
          _ListTile(title: '服务器订阅地址', trailing: viewModel.endpoint.value),
          _ListTile(title: '用户名', trailing: viewModel.username.value),
          _ListTile(title: '密码', trailing: viewModel.formattedPassword),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Divider(height: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(width: double.infinity, child: wrap),
          ),
        ];
        return Column(children: children);
      }),
    );
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
      await viewModel.init();
    });
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];
    children.add(Chip(label: Text('所有订阅')));
    for (var subscription in viewModel.subscriptions) {
      children.add(Chip(label: Text(subscription.title)));
    }
    return children;
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final String trailing;
  const _ListTile({required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    var trailingText = Text(
      trailing,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.end,
    );
    var children = [
      Text(title),
      const SizedBox(width: 16),
      Expanded(child: trailingText),
    ];
    return ListTile(title: Row(children: children));
  }
}
