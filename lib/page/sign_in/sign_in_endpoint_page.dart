import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pure_news/view_model/sign_in_endpoint_view_model.dart';

@RoutePage()
class SignInEndpointPage extends StatefulWidget {
  const SignInEndpointPage({super.key});

  @override
  State<SignInEndpointPage> createState() => _SignInEndpointPageState();
}

class _SignInEndpointPageState extends State<SignInEndpointPage> {
  final viewModel = GetIt.instance<SignInEndpointViewModel>();

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
                'Enter the endpoint of the RSS Server',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Currently, only the google reader compatible servers are supported.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
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
                    hintText: 'enter the endpoint',
                  ),
                ),
              ),
              Spacer(),
              FilledButton.tonal(
                onPressed: () => viewModel.pushSignInUsernamePage(context),
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
