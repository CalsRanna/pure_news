import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pure_news/view_model/sign_in_username_view_model.dart';

@RoutePage()
class SignInUsernamePage extends StatefulWidget {
  const SignInUsernamePage({super.key});

  @override
  State<SignInUsernamePage> createState() => _SignInUsernamePageState();
}

class _SignInUsernamePageState extends State<SignInUsernamePage> {
  final viewModel = GetIt.instance<SignInUsernameViewModel>();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel.initController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the username of the RSS Server',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: ShapeDecoration(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                  controller: viewModel.controller,
                  decoration: InputDecoration.collapsed(
                    hintText: 'enter the username',
                  ),
                ),
              ),
              Spacer(),
              FilledButton.tonal(
                onPressed: () => viewModel.pushSignInPasswordPage(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
