import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BookListPage extends StatefulWidget {
  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> _myBooks = [];
  bool _loading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMyBooks();
  }

  Future<void> _loadMyBooks() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      var books = await BookService().getMyBooks();
      setState(() {
        _myBooks = books;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _purchaseBook(int bookId) async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      await BookService().purchaseBook(bookId);
      await _loadMyBooks();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Book purchased successfully!")),
      );
    } catch (e) {
      setState(() {
        _errorMessage = "Purchase failed: ${e.toString()}";
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildBookList() {
    if (_myBooks.isEmpty) {
      return Center(child: Text("You have not purchased any books yet."));
    }

    return ListView.builder(
      itemCount: _myBooks.length,
      itemBuilder: (context, index) {
        final book = _myBooks[index];
        return ListTile(
          title: Text(book.title),
          subtitle: Text("Author: ${book.author}\nPrice: \$${book.price.toStringAsFixed(2)}"),
        );
      },
    );
  }

  // Örnek satın alma butonu (kitap ID 5)
  Widget _buildPurchaseButton() {
    return ElevatedButton(
      onPressed: _loading ? null : () => _purchaseBook(5),
      child: Text("Purchase Book ID 5"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Books"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadMyBooks,
          ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(child: _buildBookList()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildPurchaseButton(),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_errorMessage!, style: TextStyle(color: Colors.red)),
                  ),
              ],
            ),
    );
  }
}
