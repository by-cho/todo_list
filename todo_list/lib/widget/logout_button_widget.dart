import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/login_screen.dart';

class LogoutButtonWidget extends StatefulWidget {
  final logout;
  const LogoutButtonWidget({super.key, required this.logout});

  @override
  State<LogoutButtonWidget> createState() => _LogoutButtonWidgetState();
}

class _LogoutButtonWidgetState extends State<LogoutButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onLogout(context);
      },
      icon: Icon(Icons.logout_outlined),
    );
  }

  Future<dynamic> onLogout(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
            child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.black),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              height: 50,
                              child: Text(
                                '로그아웃 하시겠습니까?',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Divider(),
                            GestureDetector(
                              onTap: () async {
                                await widget.logout.logout();
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) =>
                                      false, // 모든 이전 화면을 제거하고 새로운 화면을 현재 화면으로 설정
                                );
                                setState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    '로그아웃',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10.0), // 원하는 값으로 조절
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            '취소',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
