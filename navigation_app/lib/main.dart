import 'package:flutter/material.dart';
import 'package:navigation_app/fooderlich_theme.dart';
import 'package:provider/provider.dart';
import 'package:navigation_app/models/grocery_manager.dart';
import 'package:navigation_app/models/profile_manager.dart';
import 'models/models.dart';
//import 'screens/splash_screen.dart';
// TODO: Import app_router
import 'package:navigation_app/navigation/app_router.dart';

void main() {
  runApp(
    const NavigationApp(),
  );
}

class NavigationApp extends StatefulWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  _NavigationAppState createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  // TODO: Create AppStateManager
  final _appStateManager = AppStateManager();

  // TODO: Define AppRouter
  late AppRouter _appRouter;


  // TODO: Initialize app router
  @override
void initState() {
  _appRouter = AppRouter(
    appStateManager: _appStateManager,
    groceryManager: _groceryManager,
    profileManager: _profileManager,
  );
  super.initState();
}


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        // TODO: Add AppStateManager ChangeNotifierProvider
        ChangeNotifierProvider(create: (context) => _appStateManager,),

      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            title: 'Fooderlich',
            // TODO: Replace with Router widget
           // home: const SplashScreen(),
           home: Router(
	routerDelegate: _appRouter,
  // TODO: Add backButtonDispatcher
  backButtonDispatcher: RootBackButtonDispatcher(),

),

          );
        },
      ),
    );
  }
}
