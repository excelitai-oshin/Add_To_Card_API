import 'package:add_to_card_api/models/cart_models.dart';
import 'package:add_to_card_api/provider/cart_provider.dart';
import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../database/db_helper.dart';


class MyBottomSheet extends StatefulWidget {
  MyBottomSheet(
      {this.productId,
        this.productName,
        this.productPrice,
        this.products_details,
        this.productsImage});
  String? productId;
  String? productName;
  var productPrice;
  String? products_details;
  String? productsImage;

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  DBHelper dbHelper = DBHelper();
  @override
  void initState() {
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    cart.getCounter();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);
    saveData() {
      dbHelper
          .insert(
        Cart(
          // id: ,
          productId: widget.productId,
          productName: 'ddd',
          initialPrice: 100,
          productPrice: 100,
          quantity: ValueNotifier(1),
          unitTag: 'Tk',
          image: widget.productsImage,
        ),
      )
          .then((value) {
        cart.addTotalPrice(double.parse(widget.productPrice.toString()));
        cart.addCounter();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product add successfully'),
            duration: Duration(seconds: 2),
          ),
        );
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return Container(
      height: 400,
      color: Colors.amber,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text('Product Deatiels'),
            actions: [
              Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.counter.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                position: const BadgePosition(start: 30, bottom: 30),
                child: IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const CartScreen2()));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
            ]),
        body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height,
                    child: Stack(
                      children: [
                        Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          child: Container(
                            // margin: EdgeInsets.only(top: size.height * .015),
                            // height: 500,
                            decoration: BoxDecoration(
                              //color: Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stylish Products',
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                widget.productName.toString(),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'price :\n',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            )),
                                        TextSpan(
                                            text:
                                            'Tk ${widget.productPrice!.toString()} ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ))
                                      ])),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Container(
                                          height: 150,
                                          width: 100,
                                          child: Image.network(
                                            widget.productsImage.toString(),
                                            fit: BoxFit.fill,
                                          )))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(,),
                                  //  Text(widget.products_details.toString()),

                                  ExpandableNotifier(
                                      child: ScrollOnExpand(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              // padding: EdgeInsets.only(left: 14),
                                                child: Text('Description :',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.bold))),
                                            Expandable(
                                              collapsed: Container(
                                                  height: 20,
                                                  child: Html(
                                                    data:
                                                    '${widget.products_details.toString()}',
                                                  )),
                                              expanded: Container(
                                                  child: Html(
                                                      data:
                                                      '${widget.products_details.toString()}')),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Builder(
                                                  builder: (context) {
                                                    var controller =
                                                    ExpandableController.of(
                                                        context);
                                                    return FlatButton(
                                                      child: Text(
                                                        controller!.expanded
                                                            ? 'View More'
                                                            : 'View Less',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13),
                                                      ),
                                                      onPressed: () {
                                                        controller.toggle();
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                saveData();
                                                print("tttytyyn .bn");
                                                // dbHelper
                                                //     .insert(
                                                //   Cart(
                                                //     //  id:6  ,
                                                //     productId: widget.productId,
                                                //     productName: widget.productName,
                                                //     initialPrice: 100,
                                                //     productPrice:widget.productPrice,
                                                //     quantity: ValueNotifier(1),
                                                //     unitTag: 'Tk',
                                                //     image: widget.productsImage,
                                                //   ),
                                                // )
                                                //     .then((value) {
                                                //   cart.addTotalPrice(double.parse(widget.productPrice.toString()));
                                                //   cart.addCounter();
                                                //   ScaffoldMessenger.of(context).showSnackBar(
                                                //     const SnackBar(
                                                //       content: Text('Product add successfully'),
                                                //       duration: Duration(seconds: 2),
                                                //     ),
                                                //   );
                                                //   print('Product Added to cart');
                                                // }).onError((error, stackTrace) {
                                                //   print(error.toString());
                                                // });
                                              },
                                              child: Container(
                                                color: Colors.black.withOpacity(.2),
                                                alignment: Alignment.center,
                                                height: 50.0,
                                                child: const Text(
                                                  'Add to cart',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('Allah')  ],
              ),
            )),
        //  bottomNavigationBar: InkWell(
        //       onTap: () {
        //      saveData();
        //       },
        //       child: Container(
        //         color: Colors.black.withOpacity(.2),
        //         alignment: Alignment.center,
        //         height: 50.0,
        //         child: const Text(
        //           'Add to cart',
        //           style: TextStyle(
        //             fontSize: 18.0,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     ),
      ),
    );
  }
}

// class ProductsDetails2 extends StatefulWidget {
//   ProductsDetails2(
//       {this.productId,
//         this.productName,
//         this.productPrice,
//         this.products_details,
//         this.productsImage});
//   String? productId;
//   String? productName;
//   var productPrice;
//   String? products_details;
//   String? productsImage;
//
//   @override
//   State<ProductsDetails2> createState() => _ProductsDetails2State();
// }
//
// class _ProductsDetails2State extends State<ProductsDetails2> {
//   DBHelper dbHelper = DBHelper();
//   @override
//   void initState() {
//     CartProvider cart = Provider.of<CartProvider>(context, listen: false);
//     cart.getCounter();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final cart = Provider.of<CartProvider>(context);
//
//
//     return SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: size.height,
//                 child: Stack(
//                   children: [
//                     Card(
//                       elevation: 10,
//                       shadowColor: Colors.black,
//                       child: Container(
//                         // margin: EdgeInsets.only(top: size.height * .015),
//                         // height: 500,
//                         decoration: BoxDecoration(
//                           //color: Colors.grey[300],
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(24),
//                                 topRight: Radius.circular(24))),
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Stylish Products',
//                             style: TextStyle(fontSize: 13),
//                           ),
//                           Text(
//                             widget.productName.toString(),
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w600),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               RichText(
//                                   text: TextSpan(children: [
//                                     TextSpan(
//                                         text: 'price :\n',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.black,
//                                         )),
//                                     TextSpan(
//                                         text: 'Tk ${widget.productPrice!.toString()} ',
//                                         style: TextStyle(
//                                           fontSize: 17,
//                                           color: Colors.black,
//                                         ))
//                                   ])),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Expanded(
//                                   child: Container(
//                                       height: 150,
//                                       width: 100,
//                                       child: Image.network(
//                                         widget.productsImage.toString(),
//                                         fit: BoxFit.fill,
//                                       )))
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Text(,),
//                               //  Text(widget.products_details.toString()),
//
//                               ExpandableNotifier(
//                                   child: ScrollOnExpand(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         Container(
//                                           // padding: EdgeInsets.only(left: 14),
//                                             child: Text('Description :',
//                                                 style: TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight: FontWeight.bold))),
//                                         Expandable(
//                                           collapsed: Container(
//                                               height: 20,
//                                               child: Html(
//                                                 data:
//                                                 '${widget.products_details.toString()}',
//                                               )),
//                                           expanded: Container(
//                                               child: Html(
//                                                   data:
//                                                   '${widget.products_details.toString()}')),
//                                         ),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: <Widget>[
//                                             Builder(
//                                               builder: (context) {
//                                                 var controller =
//                                                 ExpandableController.of(context);
//                                                 return FlatButton(
//                                                   child: Text(
//                                                     controller!.expanded
//                                                         ? 'View More'
//                                                         : 'View Less',
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize: 13),
//                                                   ),
//                                                   onPressed: () {
//                                                     controller.toggle();
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             print("tttytyyn .bn");
//                                               dbHelper
//                                                   .insert(
//                                                 Cart(
//                                                   //  id:6  ,
//                                                   productId: widget.productId,
//                                                   productName: widget.productName,
//                                                   initialPrice: 100,
//                                                   productPrice:widget.productPrice,
//                                                   quantity: ValueNotifier(1),
//                                                   unitTag: 'Tk',
//                                                   image: widget.productsImage,
//                                                 ),
//                                               )
//                                                   .then((value) {
//                                                 cart.addTotalPrice(double.parse(widget.productPrice.toString()));
//                                                 cart.addCounter();
//                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                   const SnackBar(
//                                                     content: Text('Product add successfully'),
//                                                     duration: Duration(seconds: 2),
//                                                   ),
//                                                 );
//                                                 print('Product Added to cart');
//                                               }).onError((error, stackTrace) {
//                                                 print(error.toString());
//                                               });
//                                             },
//
//                                           child: Container(
//                                             color: Colors.black.withOpacity(.2),
//                                             alignment: Alignment.center,
//                                             height: 50.0,
//                                             child: const Text(
//                                               'Add to cart',
//                                               style: TextStyle(
//                                                 fontSize: 18.0,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                         ),  ],
//                                     ),
//                                   ))
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//
//           //  bottomNavigationBar: InkWell(
//           //       onTap: () {
//           //      saveData();
//           //       },
//           //       child: Container(
//           //         color: Colors.black.withOpacity(.2),
//           //         alignment: Alignment.center,
//           //         height: 50.0,
//           //         child: const Text(
//           //           'Add to cart',
//           //           style: TextStyle(
//           //             fontSize: 18.0,
//           //             fontWeight: FontWeight.bold,
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//         ));
//   }
// }
