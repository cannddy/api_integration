import 'package:apiii/first_page.dart';
import 'package:flutter/material.dart';


class DetailsPage extends StatelessWidget {
  final User user; 
  const DetailsPage({super.key, required this.user});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details"),
      ),
      body: Text(user.address["zipcode"]),
      
    );

  }
}
 

            