import 'package:flutter/material.dart';
import '../models/book.dart';
import 'detail.dart';

List<Book> wishlist = [];

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (wishlist.isEmpty) {
      return Center(child: Text("Wishlist is empty"));
    }

    return ListView.builder(
      itemCount: wishlist.length,
      itemBuilder: (context, index) {
        final book = wishlist[index];
        return ListTile(
          leading: Image.asset(book.imagePath, width: 50),
          title: Text(book.title),
          subtitle: Text(book.author),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailPage(book: book)),
            );
          },
        );
      },
    );
  }
}
