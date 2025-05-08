import 'dart:convert';

import 'package:gmgi_test/model/user.dart';
import 'package:http/http.dart' as http;

class UserDatabase {
  Future<List<UserInfo>> fetchUser() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> userList = jsonDecode(response.body);

        return userList.map<UserInfo>((value) {
          String name = value['name'];
          String email = value['email'];
          String company = value['company']['name'];
          return UserInfo(name: name, email: email, company: company);
        }).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}
