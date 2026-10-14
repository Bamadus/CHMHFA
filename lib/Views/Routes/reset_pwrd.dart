
import 'package:chmhfa_app/Views/states/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Reset_Psswrd extends StatefulWidget {
  const Reset_Psswrd({super.key});

  @override
  State<Reset_Psswrd> createState() => _Reset_PsswrdState();
}

class _Reset_PsswrdState extends State<Reset_Psswrd> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;
  bool _emailSent = false;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final auth = context.read<AuthProvider>();

    final success = await auth.forgotPassword(
      _emailController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _emailSent = success;
    });

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            auth.errorMessage ?? 'Password reset failed',
          ),
          backgroundColor: const Color(0xffba324f),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F7F4),
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: const Color(0xffF8F7F4),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.lock_reset_rounded,
                    size: 100,
                    color: Color(0xff6190EE),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Forgot your password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff092C4C),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    _emailSent
                        ? 'If an account exists for this email, '
                          'check your inbox for a password reset link.'
                        : 'Enter your registered email address '
                          'to receive a password reset link.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff626262),
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (!_emailSent) ...[
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'example@gmail.com',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';

                        if (email.isEmpty) {
                          return 'Email address is required';
                        }

                        if (!RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(email)) {
                          return 'Enter a valid email address';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed:
                          _isLoading ? null : _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xff6190EE),
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child:
                                  CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Send Reset Link',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ] else ...[
                    const Icon(
                      Icons.mark_email_read_outlined,
                      size: 70,
                      color: Color(0xff52b788),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Please check your inbox and spam folder.',
                      textAlign: TextAlign.center,
                    ),
                  ],

                  const SizedBox(height: 25),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Color(0xff0085FF),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
