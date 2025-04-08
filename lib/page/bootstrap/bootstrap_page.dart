import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pure_news/view_model/bootstrap_view_model.dart';

@RoutePage()
class BootstrapPage extends StatefulWidget {
  const BootstrapPage({super.key});

  @override
  State<BootstrapPage> createState() => _BootstrapPageState();
}

class _BootstrapPageState extends State<BootstrapPage> {
  final viewModel = GetIt.instance<BootstrapViewModel>();
  @override
  void initState() {
    super.initState();
    viewModel.bootstrap(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
