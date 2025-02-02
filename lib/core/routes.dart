import 'package:e_shop_app/screens/auth/login_screen.dart';
import 'package:e_shop_app/screens/auth/signup_screen.dart';
import 'package:e_shop_app/screens/main/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => SignupScreen())
  ],
);
