import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../data/services/auth_service.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../features/auth/presentation/widgets/password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final usernameController = useTextEditingController();
    final isLoading = useState(false);
    final errorMessage = useState<String?>(null);
    final selectedRole = useState<String>('Host'); // Default role

    // Add form key and validation states
    final emailError = useState<String?>(null);
    final passwordError = useState<String?>(null);
    final confirmPasswordError = useState<String?>(null);
    final usernameError = useState<String?>(null);
    final isPasswordVisible = useState(false);
    final isConfirmPasswordVisible = useState(false);

    // Add real-time validation
    useEffect(() {
      void validateFields() {
        emailError.value = ValidationUtils.validateEmail(emailController.text);
        passwordError.value = ValidationUtils.validateSignupPassword(
          passwordController.text,
        );
        confirmPasswordError.value = ValidationUtils.validateConfirmPassword(
          confirmPasswordController.text,
          passwordController.text,
        );
        usernameError.value = ValidationUtils.validateUsername(
          usernameController.text,
        );
      }

      emailController.addListener(validateFields);
      passwordController.addListener(validateFields);
      confirmPasswordController.addListener(validateFields);
      usernameController.addListener(validateFields);

      return () {
        emailController.removeListener(validateFields);
        passwordController.removeListener(validateFields);
        confirmPasswordController.removeListener(validateFields);
        usernameController.removeListener(validateFields);
      };
    }, [emailController, passwordController, confirmPasswordController, usernameController]);

    Future<void> handleSignup() async {
      if (emailError.value != null || 
          passwordError.value != null || 
          confirmPasswordError.value != null ||
          usernameError.value != null) {
        errorMessage.value = 'Please fix the errors before continuing';
        return;
      }

      try {
        isLoading.value = true;
        errorMessage.value = null;
        
        await ref.read(authProvider.notifier).createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
          username: usernameController.text.trim(),
          role: selectedRole.value, // Use selected role
        );
        
        if (context.mounted) {
          context.go('/host');
        }
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase Auth errors
        errorMessage.value = switch (e.code) {
          'email-already-in-use' => 'This email is already registered',
          'invalid-email' => 'Please enter a valid email address',
          'weak-password' => 'Password is too weak. Use at least 6 characters',
          _ => 'Registration failed: ${e.message}',
        };
      } catch (e) {
        errorMessage.value = 'An unexpected error occurred. Please try again';
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF3A81F1),
                const Color(0xFF3A81F1).withOpacity(0.8),
              ],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Create Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign up to get started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(
                                'assets/images/college_logo.png',
                                height: 100,
                              ),
                              const SizedBox(height: 24),
                              if (errorMessage.value != null) ...[
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.error.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: Theme.of(context).colorScheme.error,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: SelectableText(
                                          errorMessage.value!,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.error,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              TextFormField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorText: usernameError.value,
                                ),
                                textInputAction: TextInputAction.next,
                                onChanged: (_) => usernameError.value = ValidationUtils.validateUsername(
                                  usernameController.text,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorText: emailError.value,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) => emailError.value = ValidationUtils.validateEmail(
                                  emailController.text,
                                ),
                              ),
                              const SizedBox(height: 16),
                              PasswordField(
                                controller: passwordController,
                                labelText: 'Password',
                                errorText: passwordError.value,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) => passwordError.value = 
                                  ValidationUtils.validateSignupPassword(passwordController.text),
                              ),
                              const SizedBox(height: 16),
                              PasswordField(
                                controller: confirmPasswordController,
                                labelText: 'Confirm Password',
                                errorText: confirmPasswordError.value,
                                onChanged: (_) => confirmPasswordError.value = 
                                  ValidationUtils.validateConfirmPassword(
                                    confirmPasswordController.text,
                                    passwordController.text,
                                  ),
                                onFieldSubmitted: (_) => handleSignup(),
                              ),
                              const SizedBox(height: 24),
                              DropdownButtonFormField<String>(
                                value: selectedRole.value,
                                decoration: InputDecoration(
                                  labelText: 'Register As',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Security',
                                    child: Text('Security'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Host',
                                    child: Text('Host'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedRole.value = value;
                                  }
                                },
                              ),
                              const SizedBox(height: 24),
                              FilledButton(
                                onPressed: isLoading.value ? null : handleSignup,
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: isLoading.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.person_add),
                                          SizedBox(width: 8),
                                          Text('SIGN UP'),
                                        ],
                                      ),
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () => context.pop(),
                                child: const Text('Already have an account? Login'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '© 2025 RVCE. All rights reserved.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 