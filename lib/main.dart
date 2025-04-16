import 'package:flutter/material.dart';
import 'data/dummy_books.dart';
import 'pages/home.dart';
import 'pages/wishlist.dart';
import 'pages/my_books.dart';
import 'pages/profile.dart';
import 'widgets/book_card.dart';
import 'pages/categories.dart';

void main() {
  runApp(PetraBookstoreApp());
}

class PetraBookstoreApp extends StatelessWidget {
  const PetraBookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petra Bookstore',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    WishlistPage(),
    MyBooksPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Petra Bookstore")),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                _onTabTapped(0); // Pindah ke Home
              },
            ),
            ListTile(
              title: Text("Categories"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()), // Pindah ke Categories
                );
              },
            ),
            ListTile(
              title: Text("My Books"),
              onTap: () {
                Navigator.pop(context);
                _onTabTapped(2); // Pindah ke My Books
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                // Logout
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Text("Petra Bookstore"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BookSearchDelegate());
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Books'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(icon: Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    final results =
        dummyBooks
            .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    if (results.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("The book you're searching for is not available."),
          ),
        );
      });
      return Center(child: Text("No results found."));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => BookCard(book: results[index]),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        dummyBooks
            .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder:
          (context, index) => ListTile(title: Text(suggestions[index].title)),
    );
  }
}
