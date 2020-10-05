import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commers_v1/screens/product_page.dart';
import 'package:e_commers_v1/services/firebase_services.dart';
import 'package:e_commers_v1/widgets/input_field.dart';
import 'package:e_commers_v1/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.orderBy("name").startAt([_searchString]).endAt([_searchString]).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108,
                    bottom: 12,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: "\$${document.data()['price']}",
                      productId: document.id,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              productId: document.id,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45,
            ),
            child: CusotmInput(
              hintText: "Search here...",
              onChanged: (value){
                if(value.isNotEmpty){
                    setState(() {
                      _searchString = value;
                    });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
