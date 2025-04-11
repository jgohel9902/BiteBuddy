import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart'; // Import your ThemeProvider

class HomeScreen extends StatelessWidget {
  final List<_NavItem> items = [
    _NavItem('Nearby Restaurants', Icons.restaurant, '/restaurants'),
    _NavItem('Bookmarks', Icons.bookmark, '/bookmarks'),
    _NavItem('Map View', Icons.map, '/map'),
    _NavItem('Add Custom Restaurant', Icons.add, '/add'),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BiteBuddy Home'),
        centerTitle: true,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Row(
                children: [
                  Icon(
                    themeProvider.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Colors.white,
                  ),
                  Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (_) => themeProvider.toggleTheme(),
                    activeColor: Colors.white,
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              leading: Icon(item.icon, size: 28, color: Colors.redAccent),
              title: Text(item.title, style: TextStyle(fontSize: 18)),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, item.route),
            ),
          );
        },
      ),
    );
  }
}

class _NavItem {
  final String title;
  final IconData icon;
  final String route;
  _NavItem(this.title, this.icon, this.route);
}
