import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../models/book.dart';

class BookService {
  static const String _baseUrl = "https://localhost:7027";

  Future<List<Book>> getMyBooks() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse(_baseUrl + "/api/book/mybooks"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception("Kitaplar alınamadı");
    }
  }

  Future<void> purchaseBook(int bookId) async {
    final token = await AuthService().getToken();
    final response = await http.post(
      Uri.parse(_baseUrl + "/api/book/purchase"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'bookId': bookId}),
    );

    if (response.statusCode != 200) {
      throw Exception("Satın alma başarısız");
    }
  }

  Future<List<Book>> getAllBooks() async {
    final response = await http.get(
      Uri.parse(_baseUrl + "/api/book/all"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception("Tüm kitaplar alınamadı");
    }
  }

  Future<void> deleteBook(int bookId) async{
    final token = await AuthService().getToken();
    final response = await http.delete(
      Uri.parse(_baseUrl + "/api/book/delete/$bookId"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if(response.statusCode != 200){
      throw Exception("Kitap silinemedi");
    }
  }
}


