import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatisthis/state/auth_state.dart';
import 'package:whatisthis/ui/mainScreen.dart';
import 'package:whatisthis/ui/signup/signup_page.dart';
import 'package:whatisthis/viewmodel/login_view_model.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(loginViewModelProvider);

    ref.listen<AsyncValue<AuthState>>(loginViewModelProvider, (previous, next) {
      next.whenData((state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Mainscreen()),
          );
        }
      });
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
            authState.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text(
                error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
              data: (state) => Column(
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(loginViewModelProvider.notifier).signIn(
                              _emailController.text,
                              _passwordController.text,
                            ),
                    child: const Text('로그인'),
                  ),
                  if (state is AuthError)
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignupPage()),
              ),
              child: const Text('계정이 없으신가요? 회원가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}
