import 'package:flutter/material.dart';
import '../models/book.dart';
import 'wishlist.dart';

class DetailPage extends StatelessWidget {
  final Book book;

  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(book.imagePath, height: 200)),
            SizedBox(height: 16),
            Text(
              book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "by ${book.author}",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16), 
            Text(
              (book.description),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Price: \$${book.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (!wishlist.contains(book)) {
                    wishlist.add(book);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to Wishlist")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already in Wishlist")));
                  }
                },
                icon: const Icon (Icons.favorite),
                label: const Text("Add to Wishlist"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
