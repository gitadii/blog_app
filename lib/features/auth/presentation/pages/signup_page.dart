import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/show_snakbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnakBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loader();
        }
        return Form(
          key: formKey,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(),
              backgroundColor: const Color(0xff17171B),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign up.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    AuthField(
                      hint: 'Name',
                      controller: nameController,
                      isObscure: false,
                    ),
                    const SizedBox(height: 15.0),
                    AuthField(
                      hint: 'Email',
                      controller: emailController,
                      isObscure: false,
                    ),
                    const SizedBox(height: 15.0),
                    AuthField(
                      hint: 'Password',
                      controller: passwordController,
                      isObscure: true,
                    ),
                    const SizedBox(height: 10.0),
                    AuthGradientButton(
                      text: 'Sign up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignUp(
                                  email: emailController.text.trim(),
                                  name: nameController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(),
                    GestureDetector(
                      onTap: () => Routemaster.of(context).pop(),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
