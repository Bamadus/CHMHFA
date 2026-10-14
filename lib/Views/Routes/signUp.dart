import 'package:chmhfa_app/Views/widgets/abstract/textfield/pwrdtextfield.dart';
import 'package:chmhfa_app/Views/widgets/abstract/textfield/textfield.dart';
import 'package:chmhfa_app/Views/states/authProvider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

final GlobalKey<FormState> _signupkey = GlobalKey<FormState>();


  double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  Future<String?> user_signup() async {
     var auth = context.read<AuthProvider>();
    try{
      bool success = await context.read<AuthProvider>().signUp(
        _mailController.text.trim(), 
        _passwordController.text.trim(), 
        _usernameController.text.trim());
        if(!success && context.mounted){
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
                  "Sign Up Successful.",
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
          Navigator.pop(context);
        }
    } on FirebaseAuthException catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: 
          Text('There was an error during signup: ${e.message}',
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
  // final isAuthenticating = context.watch<AuthProvider>().status == AuthStatus.authenticating;
    return Scaffold(
      backgroundColor:Color(0xffF8F7F4),
      body: Stack(
        children: [
          // Positioned(
          //   child: Lottie.asset(
          //     'assets/lotties/Authentication_Lock_Login.json',
              
          //     ),
          // ),
          ListView(
                padding: EdgeInsets.all(15),
                // shrinkWrap: true,
                children:[
                  SizedBox(height: screenHeight(context)*0.1,),
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
                    key: _signupkey,
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
                        validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
                        ),
                        SizedBox(height: 15,),
                        Text('Email',
                                style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize:16,
                                    color: Color(0xff092C4C),
                                    fontWeight: FontWeight.w400
                        )),
                        UserField(
                        controller: _mailController,
                        enabled: true,
                        hintText: "e.g:Username@gmail.com",
                        validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
                        ),
                        SizedBox(height: 15,),
                        Text('Password',
                                style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize:16,
                                    color: Color(0xff092C4C),
                                    fontWeight: FontWeight.w400
                        )),
                        Password(
                          controller: _passwordController,
                          enabled: true,
                          hintText: "P4ssw@rd",
                          validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
                        ),
                        SizedBox(height: 15,),
                      ],
                    )
                    ),
                    
                    Positioned(
            top: screenHeight(context) * .85,
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
                  if(_signupkey.currentState!.validate()){
                      user_signup();
                    }
                  },
              child: Consumer<AuthProvider>(
                builder:(context, authProvider, child){
                  return authProvider.status == AuthStatus.loading
                  ?
                  const CircularProgressIndicator(
                    color: Color(0xffe3f2fd),
                    strokeWidth: 6,
                  )
                  :
                  Text("Sign Up",
              style: TextStyle(
                      fontSize: 25,
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
          Row(
                                  children: [
                                    const Text('Login Instead?',
                                      style: TextStyle(
                                          fontSize:16,
                                          fontFamily: 'SourceSansPro',
                                          color: Color(0xff626262),
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    TextButton(onPressed:(){Navigator.pop(context);},
                                        child:const Text('Login',
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
                ],
              )
        ],
      ),
    );
  }
}