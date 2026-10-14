import 'package:chmhfa_app/Views/Routes/reset_pwrd.dart';
import 'package:chmhfa_app/Views/Routes/signUp.dart';
import 'package:chmhfa_app/Views/routes/home.dart';
import 'package:chmhfa_app/Views/widgets/abstract/textfield/textfield.dart';
import 'package:chmhfa_app/Views/states/authProvider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  String errormessage= '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _username_error;
  String? _pswrd_error;
  // final final bool _isChecked = false;


  Future<void> user_login() async {
     var auth = context.read<AuthProvider>();
      try {
          bool success = await auth.login(
                _usernameController.text.trim(),
                _passwordController.text.trim(),
              );
          if (!success && context.mounted) {
            // Show error if login fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: 
                Text(
                  auth.errorMessage ?? "Login Failed",
                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize:18,
                                    color: Color(0xffedf2fb),     
                        )),
                          backgroundColor: Color(0xffba324f),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 15,
                          right: 15, 
                          bottom: 150
                          ),
                  ),
                );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: 
                Text(
                  "Welcome!!",
                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize:18,
                                    color: Color(0xffedf2fb),     
                        )),
                          backgroundColor: Color(0xff52b788),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 15,
                          right: 15, 
                          bottom: 100
                          ),
                  ),
                );
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
          }
      } on FirebaseAuthException catch (e) {
        if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: 
          Text('An error has occured: ${e.message}',
          style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize:18,
                                      color: Color(0xffedf2fb),     
                          )),
                            backgroundColor: Color(0xffba324f),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(15),
                            margin: const EdgeInsets.only(left: 15,
                            right: 15, 
                            bottom: 150
                            ),
          ),
        );
      }
      }
    return;
  }

  @override
  Widget build(BuildContext context) {
  final isAuthenticating = context.watch<AuthProvider>().status == AuthStatus.loading;

    return Scaffold(
      backgroundColor:Color(0xffF8F7F4),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffd7e3fc).withOpacity(0.65),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
              margin: EdgeInsets.only(
                top: screenHeight(context) * 0.15,
                bottom: screenHeight(context) * 0.15,
                left:screenWidth(context) * 0.05,
                right:screenWidth(context) * 0.05,
              ),
              // My Login Details......
            child: Center(
              child: ListView(
                padding: EdgeInsets.only(left:10, right: 10),
                // shrinkWrap: true,
                children:[
                  SizedBox(height: screenHeight(context)*0.05,),
                  CircleAvatar(
                radius: 79,
                backgroundColor: Color.fromARGB(255, 134, 159, 209).withOpacity(0.65),
                child:Icon(
                  size: 100,
                  color: Color.fromARGB(150, 24, 24, 25).withOpacity(0.65),
                  Icons.person_2_rounded)
                ),
              SizedBox(height: 20,),
                Form(
                       key: _loginKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                              child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('Username',
                                style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize:16,
                                    color: Color(0xff092C4C),
                                    fontWeight: FontWeight.w400
                        )),
                        UserField(
                        controller: _usernameController,
                        enabled: true,
                        hintText: "user@name",
                        validator: (v){
                                  if(v!.isEmpty){
                                    return "This field is required";
                                  }
                                  return null;
                                },
                        ),
                        SizedBox(height: 15,),
                        Text('Password',
                                style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize:16,
                                    color: Color(0xff092C4C),
                                    fontWeight: FontWeight.w400
                        )),
                        AppPassword(
                          controller: _passwordController,
                          enabled: true,
                          hintText: "P4ssword",
                          validator: (v){
                                  if(v!.isEmpty){
                                    return "This field is required";
                                  }
                                  return null;
                                },
                        ),
                              Row(
                                  children: [
                                    const Text('Forgot Password?',
                                      style: TextStyle(
                                          fontSize:16,
                                          fontFamily: 'SourceSansPro',
                                          color: Color(0xff626262),
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    TextButton(onPressed:(){
                                      Navigator.push(
                                                  context,
                                                   MaterialPageRoute(
                                                         builder: (context) => const Reset_Psswrd(),
                                               ),
                                             );
                                    },
                                        child:const Text('Reset Password',
                                          style: TextStyle(
                                            color: Color(0xff0085FF),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            fontFamily: 'SourceSansPro',
                                            decoration: TextDecoration.underline,
                                            decorationColor: Color(0xff0085FF),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                      ],
                                            )
                                            )
                ],
              )
            ),
          ),
          Positioned(
            top: screenHeight(context) * .8,
            left: screenWidth(context) * .27,
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(5),
                  overlayColor: WidgetStateProperty.all(Color.fromARGB(255, 20, 55, 101).withOpacity(0.5)),
                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 97, 144, 238)),
                  foregroundColor: WidgetStateProperty.all(Color(0xffe3f2fd)),
                  padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 60, vertical: 20))
                ),
                onPressed: (){
                  if(_loginKey.currentState!.validate()){
                    user_login();
                  }
                }, 
              child: 
              Consumer<AuthProvider>(
                builder:(context, authProvider, child){
                  return authProvider.status == AuthStatus.loading
                  ?
                  const CircularProgressIndicator(
                    color: Color(0xffe3f2fd),
                    strokeWidth: 6,
                  )
                  :
                  Text("Login",
              style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'SourceSansPro',
                      color: Color(0xffe3f2fd),
                      ),
              );
                }
                )
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight(context) * .04,
            left: screenWidth(context) * .05,
            child: Row(
                                    children: [
                                      const Text('Sign Up Instead?',
                                        style: TextStyle(
                                            fontSize:16,
                                            fontFamily: 'SourceSansPro',
                                            color: Color(0xff626262),
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      TextButton(onPressed:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));
                                        },
                                          child:const Text('Sign Up',
                                            style: TextStyle(
                                              color: Color(0xff0085FF),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              fontFamily: 'SourceSansPro',
                                              decoration: TextDecoration.underline,
                                              decorationColor: Color(0xff0085FF),
                                            ),
                                          )
                                      )
                                    ],
                                  ),
          ),
        ],
      )
    );
  }
}