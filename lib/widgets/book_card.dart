import 'package:flutter/material.dart';
import '../models/book.dart';
import '../pages/detail.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
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
  }
}
