import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class ApiService {

  Future<List<UserModel>> fetchUsers() async {
    const url = "https://jsonplaceholder.typicode.com/users";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {

      final List data = jsonDecode(res.body);
      return data.map((e) => UserModel.fromJson(e)).toList();

    } else {
      
      throw Exception("API Error");
    }
  }
}
