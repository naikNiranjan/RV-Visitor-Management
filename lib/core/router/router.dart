import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/data/services/session_service.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/visitor_management/presentation/screens/main_screen.dart';
import '../../features/visitor_management/presentation/screens/host_home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final sessionState = ref.watch(sessionServiceProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation == '/login' || 
                         state.matchedLocation == '/signup';

      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }

      if (isLoggedIn && isAuthRoute) {
        final userRole = sessionState.valueOrNull?.role?.toLowerCase();
        return userRole == 'security' ? '/register' : '/host';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/host',
        builder: (context, state) => const HostHomeScreen(),
      ),
    ],
  );
}); 