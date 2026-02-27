import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailCtrl    = TextEditingController();
  final _nameCtrl     = TextEditingController();
  final _userCtrl     = TextEditingController();
  final _passCtrl     = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(children: [
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(height: 16),

            const Text('Instagram',
              style: TextStyle(fontSize: 42, color: Colors.white,
                fontWeight: FontWeight.w300, letterSpacing: 1)),

            const SizedBox(height: 12),

            Text('Sign up to see photos and videos\nfrom your friends.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16, fontWeight: FontWeight.w600)),

            const SizedBox(height: 24),

            // Avatar upload circle
            GestureDetector(
              onTap: () {},
              child: Stack(children: [
                Container(
                  width: 90, height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surface2,
                    border: Border.all(color: AppColors.border, width: 2),
                  ),
                  child: Icon(Icons.person, size: 44, color: AppColors.textSecondary),
                ),
                Positioned(bottom: 0, right: 0,
                  child: Container(
                    width: 26, height: 26,
                    decoration: BoxDecoration(
                      color: AppColors.blue, shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  )),
              ]),
            ),

            const SizedBox(height: 24),
            _field(_emailCtrl, 'Mobile number or email'),
            const SizedBox(height: 10),
            _field(_nameCtrl, 'Full Name'),
            const SizedBox(height: 10),
            _field(_userCtrl, 'Username'),
            const SizedBox(height: 10),
            _field(_passCtrl, 'Password', obscure: true),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HomeScreen())),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text('Sign Up',
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w700, fontSize: 14)),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'By signing up, you agree to our Terms,\nPrivacy Policy and Cookies Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),

            const SizedBox(height: 24),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Have an account? ',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text('Log in.',
                  style: TextStyle(color: AppColors.blue,
                    fontWeight: FontWeight.w700, fontSize: 14)),
              ),
            ]),

            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String hint, {bool obscure = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: c, obscureText: obscure,
        style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}