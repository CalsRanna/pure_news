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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await viewModel.init();
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
      appBar: AppBar(),
      body: Watch(
        (context) => Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text('服务器订阅地址'),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      viewModel.endpoint.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Username'),
              trailing: Text(viewModel.username.value),
            ),
            ListTile(
              title: Text('Password'),
              trailing: Text(viewModel.password.value),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(height: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  children: _buildChildren(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
