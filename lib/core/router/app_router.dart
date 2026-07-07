import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/restaurants/presentation/screens/restaurant_list_screen.dart';
import '../../features/restaurants/presentation/screens/favorites_screen.dart';
import '../../features/legal/presentation/screens/terms_screen.dart';
import '../../features/groups/presentation/screens/groups_list_screen.dart';
import '../../features/groups/presentation/screens/group_form_screen.dart';
import '../../features/groups/presentation/screens/group_detail_screen.dart';
import '../../features/colleagues/presentation/screens/colleague_form_screen.dart';
import '../../features/calculations/presentation/screens/viability_screen.dart';

GoRouter createRouter() => GoRouter(
      initialLocation: '/login',
      redirect: (context, state) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('jwt_token');
        final isLogin = state.matchedLocation == '/login';
        final isPublic = isLogin || state.matchedLocation == '/terms';
        if (token != null && isLogin) return '/restaurants';
        if (token == null && !isPublic) return '/login';
        return null;
      },
      routes: [
        GoRoute(path: '/login', builder: (context, _) => const LoginScreen()),
        GoRoute(path: '/terms', builder: (context, _) => const TermsScreen()),
        GoRoute(path: '/restaurants', builder: (context, _) => const RestaurantListScreen()),
        GoRoute(path: '/favorites', builder: (context, _) => const FavoritesScreen()),
        GoRoute(path: '/groups', builder: (context, _) => const GroupsListScreen()),
        GoRoute(path: '/groups/new', builder: (context, _) => const GroupFormScreen()),
        GoRoute(
          path: '/groups/:id',
          builder: (context, state) =>
              GroupDetailScreen(groupId: int.parse(state.pathParameters['id']!)),
        ),
        GoRoute(
          path: '/groups/:id/colleagues/new',
          builder: (context, state) =>
              ColleagueFormScreen(groupId: int.parse(state.pathParameters['id']!)),
        ),
        GoRoute(
          path: '/groups/:id/viability',
          builder: (context, state) =>
              ViabilityScreen(groupId: int.parse(state.pathParameters['id']!)),
        ),
      ],
    );
