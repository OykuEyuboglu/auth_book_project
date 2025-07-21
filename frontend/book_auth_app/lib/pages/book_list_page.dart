import 'package:flutter/material.dart'; 
import '../services/book_service.dart';
import '../models/book.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> myBooks = [];
  List<Book> allBooks = [];
  Book? selectedBook;
  bool isLoading = true;
  bool showDropdown = false;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final bookService = BookService();
      final fetchedMyBooks = await bookService.getMyBooks();
      final fetchedAllBooks = await bookService.getAllBooks();

      setState(() {
        myBooks = fetchedMyBooks;
        allBooks = fetchedAllBooks;
        isLoading = false;
      });
    } catch (e) {
      print('Hata: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> purchaseBook() async {
    if (selectedBook != null) {
      await BookService().purchaseBook(selectedBook!.id);
      await fetchBooks();
      setState(() {
        selectedBook = null;
        showDropdown = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Satın Aldığınız Kitaplar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: myBooks.isEmpty
                        ? const Center(
                            child: Text("Henüz kitap satın almadınız."),
                          )
                        : ListView.separated(
                            itemCount: myBooks.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final book = myBooks[index];
                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.book,
                                    color: Color.fromARGB(255, 12, 12, 12),
                                  ),
                                  title: Text(book.title),
                                  subtitle: Text(
                                    "Yazar: ${book.author}\n₺${book.price}",
                                  ),
                                  isThreeLine: true,

                                  trailing: IconButton(

                                    padding: const EdgeInsets.only(top: 8.0),
                                    icon: Icon(Icons.delete, color: const Color.fromARGB(255, 167, 29, 19)),
                                    onPressed: () async {
                                      try {
                                        await BookService().deleteBook(book.id);
                                        await fetchBooks();
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Kitap silindi.")),
                                          );
                                          
                                      } catch (e) {
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Silme başarısız: $e")),
                                        );
                                      }
                                    },
                                  ),
  
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        showDropdown = !showDropdown;
                      });
                    },
                    icon: Icon(
                      showDropdown ? Icons.keyboard_arrow_up : Icons.add,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    label: const Text(
                      "Kitap Eklemek İçin Tıklayın",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  if (showDropdown)
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButton<Book>(
                            value: selectedBook,
                            hint: const Text("Bir kitap seçin"),
                            isExpanded: true,
                            items: allBooks
                                .where(
                                  (book) =>
                                      !myBooks.any((b) => b.id == book.id),
                                )
                                .map((book) {
                                  return DropdownMenuItem<Book>(
                                    value: book,
                                    child: Text(
                                      "${book.title} - ₺${book.price}",
                                    ),
                                  );
                                })
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBook = value;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: selectedBook != null
                                ? purchaseBook
                                : null,
                            icon: const Icon(Icons.save_alt),
                            label: const Text("Kaydet"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                224,
                                229,
                                238,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}