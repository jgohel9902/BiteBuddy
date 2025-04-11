import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitebuddy/models/restaurant.dart';
import 'package:bitebuddy/providers/theme_provider.dart';
import 'package:bitebuddy/screens/add_restaurant_screen.dart';
import 'package:bitebuddy/screens/bookmarks_screen.dart';
import 'package:bitebuddy/screens/edit_restaurant_screen.dart';
import 'package:bitebuddy/screens/home_screen.dart';
import 'package:bitebuddy/screens/map_screen.dart';
import 'package:bitebuddy/screens/splash_screen.dart';
import 'package:bitebuddy/screens/restaurant_list_screen.dart';
import 'package:bitebuddy/screens/restaurant_detail_screen.dart';
import 'package:bitebuddy/services/api_service.dart';
import 'package:bitebuddy/services/db_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: BiteBuddyApp(),
    ),
  );
}

class BiteBuddyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'BiteBuddy',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.currentTheme,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
        colorScheme: ColorScheme.dark(
          primary: Colors.redAccent,
          secondary: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/restaurants': (context) => RestaurantListScreen(),
        '/bookmarks': (context) => BookmarksScreen(),
        '/map': (context) => MapScreen(),
        '/add': (context) => AddRestaurantScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final restaurant = settings.arguments as Restaurant;
          return MaterialPageRoute(
            builder: (_) => EditRestaurantScreen(restaurant: restaurant),
          );
        } else if (settings.name == '/details') {
          final restaurant = settings.arguments as Restaurant;
          return MaterialPageRoute(
            builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
          );
        }
        return null;
      },
    );
  }
}
