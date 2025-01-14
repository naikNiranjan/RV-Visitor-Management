import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/loading_screen.dart';
import 'features/auth/data/services/session_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(sessionServiceProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'RVVM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      routerConfig: router,
      builder: (context, child) {
        if (sessionState.isLoading) {
          return const LoadingScreen();
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
