import 'package:busybe3daejeon/auth/signin.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {  
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => SignInState();
}

class SignInState extends State<SignInScreen> {

  // UI 관련 함수
  bool loading = false;
  User? user;

  void pressGoogle() async {
    await signInWithGoogle();
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
  }

  void pressApple() async {
    await signInWithApple();
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
  }
    
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Scaffold(
          body : Column(            
            children: [

              const Spacer(),

              const Center(
                child: Text(
                  "BusyBE3 대전",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900
                  )
                ),
              ),

              const SizedBox(height: 10,),

              Center(
                child: Text(
                  "로그인한 계정 : ${user?.email}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900
                  )
                ),
              ),

              const Spacer(),
            ],
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width - 40, // padding 20
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: pressApple,
                  child: Container(
                    padding : const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color : const Color(0xFF000000),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "애플로 로그인하기",
                          style : TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          )
                        )
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: pressGoogle,
                  child: Container(
                    padding : const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color : const Color(0xFF4285F4),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "구글로 로그인하기",
                          style : TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}