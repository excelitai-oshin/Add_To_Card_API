import 'package:add_to_card_api/cart_screen2.dart';
import 'package:add_to_card_api/database/db_helper.dart';
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
import 'cart_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen(
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
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          //  id:6  ,
          productId: 6.toString(),
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
            backgroundColor:Colors.grey,
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

class ProductsDetails2 extends StatefulWidget {
  ProductsDetails2(
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
  State<ProductsDetails2> createState() => _ProductsDetails2State();
}

class _ProductsDetails2State extends State<ProductsDetails2> {
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
          //  id:6  ,
          productId: 6.toString(),
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

    return SingleChildScrollView(
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
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                        text: 'Tk ${widget.productPrice!.toString()} ',
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
                                                ExpandableController.of(context);
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
                                        ),  ],
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

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
        ));
  }
}








// import 'package:add_to_card_api/provider/cart_provider.dart';
// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'database/db_helper.dart';
// import 'models/cart_models.dart';
//
//
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   DBHelper? dbHelper = DBHelper();
//   List<bool> tapped = [];
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<CartProvider>().getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 113, 174, 225),
//         title: const Text('My Shopping Cart'),
//         actions: [
//           Badge(
//             badgeContent: Consumer<CartProvider>(
//               builder: (context, value, child) {
//                 return Text(
//                   value.counter.toString(),
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 );
//               },
//             ),
//             position: const BadgePosition(start: 30, bottom: 30),
//             child: IconButton(
//               onPressed: () {
//
//               },
//               icon: const Icon(Icons.shopping_cart),
//             ),
//           ),
//           const SizedBox(
//             width: 20.0,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           FutureBuilder(
//             future: cart.getData(),
//             builder: (context,AsyncSnapshot<List<Cart>>snapshot){
//               if(snapshot.hasData){
//                 return Expanded(
//                   child: Consumer<CartProvider>(
//                     builder: (BuildContext context, provider, widget) {
//                       if (provider.cart.isEmpty) {
//                         return const Center(
//                             child: Text(
//                               'Your Cart is Empty',
//                               style:
//                               TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
//                             ));
//                       } else {
//                         return ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: provider.cart.length,
//                             itemBuilder: (context, index) {
//                               return Card(
//                                 // color: Colors.blueGrey.shade200,
//                                 elevation: 5.0,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Image(
//                                         height: 80,
//                                         width: 80,
//                                         image:
//                                         AssetImage(provider.cart[index].image!),
//                                       ),
//                                       SizedBox(
//                                         width: 170,
//                                         child: Container(
//                                           child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               const SizedBox(
//                                                 height: 5.0,
//                                               ),
//                                               RichText(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 1,
//                                                 text: TextSpan(
//                                                     text: 'Name: ',
//                                                     style: TextStyle(
//                                                         color: Colors.blueGrey.shade800,
//                                                         fontSize: 16.0),
//                                                     children: [
//                                                       TextSpan(
//                                                           text:
//                                                           '${provider.cart[index].productName!}\n',
//                                                           style: const TextStyle(
//                                                               fontWeight:
//                                                               FontWeight.bold)),
//                                                     ]),
//                                               ),
//                                               RichText(
//                                                 maxLines: 1,
//                                                 text: TextSpan(
//                                                     text: 'Unit: ',
//                                                     style: TextStyle(
//                                                         color: Colors.blueGrey.shade800,
//                                                         fontSize: 16.0),
//                                                     children: [
//                                                       TextSpan(
//                                                           text:
//                                                           '${provider.cart[index].unitTag!}\n',
//                                                           style: const TextStyle(
//                                                               fontWeight:
//                                                               FontWeight.bold)),
//                                                     ]),
//                                               ),
//                                               RichText(
//                                                 maxLines: 1,
//                                                 text: TextSpan(
//                                                     text: 'Price: ' r"$",
//                                                     style: TextStyle(
//                                                         color: Colors.blueGrey.shade800,
//                                                         fontSize: 16.0),
//                                                     children: [
//                                                       TextSpan(
//                                                           text:
//                                                           '${provider.cart[index].productPrice!}\n',
//                                                           style: const TextStyle(
//                                                               fontWeight:
//                                                               FontWeight.bold)),
//                                                     ]),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           GestureDetector(
//                                               onTap: () {
//                                                 dbHelper!.deleteCartItem(
//                                                     provider.cart[index].id!);
//                                                 provider.removeItem(
//                                                     provider.cart[index].id!);
//                                                 provider.removeCounter();
//                                               },
//                                               child: Icon(
//                                                 Icons.delete,
//                                                 color: Colors.red.shade800,
//                                               )),
//                                           SizedBox(height: 15,),
//                                           ValueListenableBuilder<int>(
//                                               valueListenable:
//                                               provider.cart[index].quantity!,
//                                               builder: (context, val, child) {
//                                                 return PlusMinusButtons(
//                                                   addQuantity: () {
//                                                     cart.addQuantity(
//                                                         provider.cart[index].id!);
//                                                     dbHelper!
//                                                         .updateQuantity(Cart(
//                                                         id: index,
//                                                         productId:
//                                                         index.toString(),
//                                                         productName: provider
//                                                             .cart[index]
//                                                             .productName,
//                                                         initialPrice: provider
//                                                             .cart[index]
//                                                             .initialPrice,
//                                                         productPrice: provider
//                                                             .cart[index]
//                                                             .productPrice,
//                                                         quantity: ValueNotifier(
//                                                             provider.cart[index]
//                                                                 .quantity!.value),
//                                                         unitTag: provider
//                                                             .cart[index].unitTag,
//                                                         image: provider
//                                                             .cart[index].image))
//                                                         .then((value) {
//                                                       setState(() {
//                                                         cart.addTotalPrice(
//                                                             double.parse(provider
//                                                                 .cart[index]
//                                                                 .productPrice
//                                                                 .toString()));
//                                                       });
//                                                     });
//                                                   },
//                                                   deleteQuantity: () {
//                                                     cart.deleteQuantity(
//                                                         provider.cart[index].id!);
//                                                     cart.removeTotalPrice(
//                                                         double.parse(provider
//                                                             .cart[index].productPrice
//                                                             .toString()));
//                                                   },
//                                                   text: val.toString(),
//                                                 );
//                                               }),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });
//                       }
//                     },
//                   ),
//                 );
//
//               }
//               return Text('');
//
//             },),
//           Consumer<CartProvider>(
//             builder: (BuildContext context, value, Widget? child) {
//               final ValueNotifier<int?> totalPrice = ValueNotifier(null);
//               for (var element in value.cart) {
//                 totalPrice.value =
//                     (element.productPrice! * element.quantity!.value) +
//                         (totalPrice.value ?? 0);
//               }
//               return Column(
//                 children: [
//                   ValueListenableBuilder<int?>(
//                       valueListenable: totalPrice,
//                       builder: (context, val, child) {
//                         return ReusableWidget(
//                             title: 'Sub-Total',
//                             value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
//                       }),
//                 ],
//               );
//             },
//           )
//         ],
//       ),
//       bottomNavigationBar: InkWell(
//         onTap: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Payment Successful'),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         },
//         child: Container(
//           color: Colors.black.withOpacity(.2),
//           alignment: Alignment.center,
//           height: 50.0,
//           child: const Text(
//             'Proceed to Pay',
//             style: TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PlusMinusButtons extends StatelessWidget {
//   final VoidCallback deleteQuantity;
//   final VoidCallback addQuantity;
//   final String text;
//   const PlusMinusButtons(
//       {Key? key,
//         required this.addQuantity,
//         required this.deleteQuantity,
//         required this.text})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(width: 10,),  Container(
//             alignment: Alignment.center,
//
//             decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(.2),
//                 borderRadius: BorderRadius.circular(50)),
//             child: GestureDetector(
//                 onTap: deleteQuantity, child:  Center(child: Icon(Icons.remove,size: 22,)))),
//         SizedBox(width: 10,),   Text(text,style: TextStyle(fontSize: 17 ),),SizedBox(width: 10,),
//         Container(
//             decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(.2),
//                 borderRadius: BorderRadius.circular(50)),
//             child: GestureDetector(
//                 onTap: addQuantity, child: const Icon(Icons.add,size: 22,))),
//       ],
//     );
//   }
// }
//
// class ReusableWidget extends StatelessWidget {
//   final String title, value;
//   const ReusableWidget({Key? key, required this.title, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           Text(
//             value.toString(),
//             style: Theme.of(context).textTheme.subtitle2,
//           ),
//         ],
//       ),
//     );
//   }
// }
