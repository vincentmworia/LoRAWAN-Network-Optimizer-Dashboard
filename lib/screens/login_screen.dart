import 'package:flutter/material.dart';

import '../helpers/app_info.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      if (_username.text.trim() == 'admin' && _password.text == 'admin') {
        Navigator.of(context).pushReplacementNamed('/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid credentials'),
            backgroundColor: AppInfo.appPrimaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body:  Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/Lora.webp', fit: BoxFit.cover),
                Container(color: AppInfo.opaqueColor(Colors.black, 0.5)),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      width: appWidth > 900 ? 600 : appWidth * 0.9,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 48,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// Logos
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Siegen.webp',
                                  width: 120,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 32),
                                Image.asset(
                                  'assets/images/Eminent.png',
                                  width: 120,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            /// Title
                            Text(
                              "Welcome to\n${AppInfo.appTitle}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppInfo.appPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: 46),

                            /// Username Field
                            TextFormField(
                              controller: _username,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppInfo.appPrimaryColor,
                                ),
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Enter username'
                                  : null,
                            ),
                            const SizedBox(height: 30),

                            /// Password Field
                            TextFormField(
                              controller: _password,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: AppInfo.appPrimaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppInfo.appPrimaryColor,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscureText = !_obscureText,
                                  ),
                                ),
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Enter password'
                                  : null,
                            ),
                            const SizedBox(height: 46),

                            /// Login Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton.icon(
                                onPressed: _isLoading ? null : _login,
                                icon: _isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Icon(Icons.login),
                                label: Text(
                                  _isLoading ? 'Logging in...' : 'Login',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppInfo.appPrimaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
