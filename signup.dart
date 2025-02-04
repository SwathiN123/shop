import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/auth.dart';

import 'auth_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  late String name, email, password, confirmpassword;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  Auth vishnuauth = Auth();
  bool _isloading = false;
  signup() {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      vishnuauth.signupmethod(context, email, password).then((value) {
        if (value != null) {
          setState(() {
            _isloading = false;
          });

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => AuthScreen()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
      ),
      body: _isloading
          ? Container(
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 23, 82, 131),
                  strokeWidth: 5.5,
                ),
              ),
            )
          : Form(
              key: formkey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: namecontroller,
                      validator: (val) {
                        return val!.isEmpty ? "Enter Name" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (val) {
                        return val!.isEmpty ? "Enter Email" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      validator: (val) {
                        return val!.isEmpty ? "Enter Password" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: confirmpasswordController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please re-enter password';
                        }
                        print(passwordController.text);

                        print(confirmpasswordController.text);
                        if (passwordController.text !=
                            confirmpasswordController.text) {
                          return "Password does not match";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Confirm-Password',
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                        onTap: () {
                          signup();
                        },
                        child: const Text("Signup")),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AuthScreen()));
                            },
                            child: const Text(
                              "sign in",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
