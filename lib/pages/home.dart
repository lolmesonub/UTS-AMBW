import 'package:flutter/material.dart';
import '../data/dummy_books.dart';
import '../widgets/book_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyBooks.length,
      itemBuilder: (context, index) {
        return BookCard(book: dummyBooks[index]);
      },
    );
  }
}
