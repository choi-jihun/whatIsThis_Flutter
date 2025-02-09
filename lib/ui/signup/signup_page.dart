import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/state/auth_state.dart';
import 'package:whatisthis/ui/mainScreen.dart';
import 'package:whatisthis/viewmodel/signup_view_model.dart';

class SignupPage extends ConsumerWidget {
  SignupPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(signupViewModelProvider);
    final viewModel = ref.read(signupViewModelProvider.notifier);

    ref.listen<AuthState>(signupViewModelProvider, (previous, next) {
      if (next is AuthSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Mainscreen()),
        );
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '사용자 이름'),
            ),
            if (authState is AuthLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () => viewModel.signUp(
                  _emailController.text,
                  _passwordController.text,
                  _nameController.text,
                ),
                child: const Text('회원가입'),
              ),
            if (authState is AuthError)
              Text(authState.message,
                  style: const TextStyle(color: Colors.red)),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('이미 계정이 있으신가요? 로그인하기'),
            ),
          ],
        ),
      ),
    );
  }
}
