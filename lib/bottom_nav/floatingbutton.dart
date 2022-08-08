
import 'package:add_to_card_api/models/cart_models.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart_screen.dart';

// Consumer<Cart>
floatingButton(BuildContext context,Color color) {

  Badge(
    child: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CartScreen()));
        },
        child: Icon(
          Icons.shopping_bag_sharp,
          color: Colors.black,
        ),

    ),
  );
}