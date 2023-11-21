import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_list/authentication/kakao_auth.dart';
import 'package:todo_list/view/home_screen.dart';
import 'package:todo_list/view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = LoginViewModel(KaKaoAuth());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SafeArea(
        child: Center(
          child: !viewModel.isLogined
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ToDo List',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            await viewModel.login();
                            setState(() {});
                            print(viewModel.isLogined);
                          },
                          child: Text(
                            '카카오톡으로 로그인',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: HomeScreen(
                        userId: viewModel.user?.id,
                        userInfo: viewModel.user?.kakaoAccount?.profile,
                        logout: viewModel,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
