import 'dart:convert';

import 'package:apiii/details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var userMap in jsonData) {
      User user = User(
        userMap["name"],
        userMap["username"],
        userMap["email"],
        userMap["address"],
      );
      users.add(user);
    }
    // print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("User List")),
        body: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var user = snapshot.data[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                user: user,
                              ),
                            ));
                      },
                      title: Text(user.name),
                      subtitle: Text(user.username),
                      trailing: Text(
                        user.email,
                      ),
                    );
                  },
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ));
  }
}

class User {
  final String name, username, email;
  final Map<String, dynamic> address;
  User(this.name, this.username, this.email, this.address);
}
