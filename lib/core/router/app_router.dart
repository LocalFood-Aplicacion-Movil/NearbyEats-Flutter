import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/restaurants/presentation/screens/restaurant_list_screen.dart';
import '../../features/restaurants/presentation/screens/favorites_screen.dart';

GoRouter createRouter() => GoRouter(
      initialLocation: '/login',
      redirect: (context, state) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('jwt_token');
        final isLogin = state.matchedLocation == '/login';
        if (token != null && isLogin) return '/restaurants';
        if (token == null && !isLogin) return '/login';
        return null;
      },
      routes: [
        GoRoute(path: '/login', builder: (context, _) => const LoginScreen()),
        GoRoute(path: '/restaurants', builder: (context, _) => const RestaurantListScreen()),
        GoRoute(path: '/favorites', builder: (context, _) => const FavoritesScreen()),
      ],
    );
