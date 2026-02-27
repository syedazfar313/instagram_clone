import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'signup_screen.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool _obscure    = true;

  late AnimationController _ctrl;
  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;
  late Animation<double> _formFade;
  late Animation<Offset> _formSlide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 900));

    _logoFade  = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl,
        curve: const Interval(0, 0.5, curve: Curves.easeOut)));
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _ctrl,
        curve: const Interval(0, 0.5, curve: Curves.easeOut)));

    _formFade  = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl,
        curve: const Interval(0.3, 1, curve: Curves.easeOut)));
    _formSlide = Tween<Offset>(
      begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _ctrl,
        curve: const Interval(0.3, 1, curve: Curves.easeOut)));

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() => Navigator.pushReplacement(context,
    PageRouteBuilder(
      pageBuilder: (_, anim, __) => FadeTransition(
        opacity: anim, child: const HomeScreen()),
      transitionDuration: const Duration(milliseconds: 400),
    ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(children: [
            const SizedBox(height: 80),

            // Animated Logo
            FadeTransition(opacity: _logoFade,
              child: SlideTransition(position: _logoSlide,
                child: const Text('Instagram',
                  style: TextStyle(fontSize: 42, color: Colors.white,
                    fontWeight: FontWeight.w300, letterSpacing: 1)))),

            const SizedBox(height: 40),

            // Animated Form
            FadeTransition(opacity: _formFade,
              child: SlideTransition(position: _formSlide,
                child: Column(children: [

                  _field(_emailCtrl, 'Phone number, username, or email'),
                  const SizedBox(height: 10),

                  _field(_passCtrl, 'Password', obscure: _obscure,
                    suffix: GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Text(_obscure ? 'Show' : 'Hide',
                        style: TextStyle(color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                  ),

                  Align(alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {},
                      child: Text('Forgot password?',
                        style: TextStyle(color: AppColors.blue,
                          fontWeight: FontWeight.w600, fontSize: 13)))),

                  const SizedBox(height: 4),
                  _blueBtn('Log In', _login),
                  const SizedBox(height: 20),

                  Row(children: [
                    Expanded(child: Divider(color: AppColors.border)),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR', style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600, fontSize: 12))),
                    Expanded(child: Divider(color: AppColors.border)),
                  ]),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: _login,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.g_mobiledata, color: AppColors.blue, size: 26),
                      const SizedBox(width: 8),
                      Text('Log in with Google',
                        style: TextStyle(color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600, fontSize: 14)),
                    ]),
                  ),

                  const SizedBox(height: 60),

                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Don't have an account? ",
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                        PageRouteBuilder(
                          pageBuilder: (_, anim, __) => FadeTransition(
                            opacity: anim, child: const SignupScreen()),
                          transitionDuration: const Duration(milliseconds: 300),
                        )),
                      child: Text('Sign up.',
                        style: TextStyle(color: AppColors.blue,
                          fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                  ]),
                ]))),

            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String hint,
      {bool obscure = false, Widget? suffix}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border)),
      child: TextField(
        controller: c, obscureText: obscure,
        style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: suffix != null
            ? Padding(padding: const EdgeInsets.only(right: 12), child: suffix)
            : null,
          suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0)),
      ),
    );
  }

  Widget _blueBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.blue, borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        child: const Text('Log In',
          style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.w700, fontSize: 14)),
      ),
    );
  }
}