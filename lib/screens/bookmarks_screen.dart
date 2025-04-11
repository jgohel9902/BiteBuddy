import 'package:flutter/material.dart';
import 'package:bitebuddy/models/restaurant.dart';
import '../services/db_service.dart';
import '../widgets/restaurant_tile.dart';

class BookmarksScreen extends StatefulWidget {
  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late Future<List<Restaurant>> _bookmarks;
  List<Restaurant> _filteredRestaurants = [];
  String _searchText = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text.toLowerCase();
    });
  }

  void _loadBookmarks() {
    setState(() {
      _bookmarks = DBService.getBookmarks();
    });
  }

  List<Restaurant> _filterList(List<Restaurant> list) {
    if (_searchText.isEmpty) return list;
    return list
        .where((r) => r.name.toLowerCase().contains(_searchText))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarked Restaurants')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search bookmarks...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Restaurant>>(
              future: _bookmarks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());

                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));

                if (!snapshot.hasData || snapshot.data!.isEmpty)
                  return Center(child: Text('No bookmarks yet.'));

                final restaurants = _filterList(snapshot.data!);

                if (restaurants.isEmpty)
                  return Center(child: Text('No matches found.'));

                return ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];

                    return Dismissible(
                      key: Key(restaurant.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete?'),
                            content: Text(
                                'Delete "${restaurant.name}" from bookmarks?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (direction) async {
                        await DBService.removeBookmark(restaurant.id);
                        _loadBookmarks();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${restaurant.name} deleted')),
                        );
                      },
                      child: GestureDetector(
                        onTap: () async {
                          final updated = await Navigator.pushNamed(
                            context,
                            '/edit',
                            arguments: restaurant,
                          );
                          if (updated == true) _loadBookmarks();
                        },
                        child: RestaurantTile(restaurant: restaurant),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
