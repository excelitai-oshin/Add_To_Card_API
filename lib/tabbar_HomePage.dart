import 'package:add_to_card_api/bottom_nav/navigationbar.dart';
import 'package:add_to_card_api/provider/cart_provider.dart';
import 'package:add_to_card_api/provider/product_provider.dart';
import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:provider/provider.dart';

import 'models/model_bottom_sheet.dart';




class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isSigningOut = false;


  @override
  void initState() {
    ProductProvider productProvider =
    Provider.of<ProductProvider>(context, listen: false);
    productProvider.getData();
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    cart.getCounter();
    super.initState();
  }

  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );
    CartProvider cart = Provider.of<CartProvider>(
      context,
    );
    List men = productProvider.data_list!
        .where(
          (element) => element['category'] == 'men\'s clothing',
    )
        .toList();
    List women = productProvider.data_list!
        .where(
          (element) => element['category'] == 'women\'s clothing',
    )
        .toList();
    List jewelery = productProvider.data_list!
        .where(
          (element) => element['category'] == 'jewelery',
    )
        .toList();
    List electrics = productProvider.data_list!
        .where(
          (element) => element['category'] == 'electronics',
    )
        .toList();

    // print('women ${data}');
    // print('women ${data.length}');
    // print(data[0]['title']);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: (
            FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Center(
                child: Badge(
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(value.getCounter().toString(),
                          style: TextStyle(color: Colors.red));
                    },
                  ),
                  animationDuration: Duration(microseconds: 300),
                  child: Icon(Icons.shopping_bag),
                ),
              ),

            )), bottomNavigationBar: (
          bottomAppBar(context,Colors.amber)),

          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey,
            elevation: 0,
            title: Text("BPPSHOP "),
            actions: [
              MaterialButton(
                  onPressed: () {
                    // signOut();
                    //
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                    color: Colors.blueGrey,
                    padding: EdgeInsets.all(10),
                    child: Text('SignOut'),
                  )),

            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(3.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    // isScrollable: true,
                    indicator: BoxDecoration(
                        color: Color.fromRGBO(102, 117, 102, 1),
                        borderRadius: BorderRadius.circular(5.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Men'),
                      Tab(text: 'Jewelery'),
                      Tab(text: 'Women'),
                      Tab(text: 'Electics'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: productProvider.data_list?.length,
                            shrinkWrap: true,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  showModalBottomSheet<void>(
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return MyBottomSheet(


                                        productId:  productProvider
                                            .data_list![index]['id']
                                            .toString(),
                                        productsImage: productProvider
                                            .data_list![index]['image']
                                            .toString(),
                                        productName: productProvider.data_list![index]['title']
                                            .toString(),
                                        productPrice: double.parse(productProvider.data_list![index]['price'].toString()),
                                    //    Description: productProvider.data_list!  [index]["description"],
                                        //  count: double.parse(productProvider.data_list![index]['count'].toString()),

                                      );
                                    },
                                  );
                                },
                                child: Card(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              child: Image.network(productProvider
                                                  .data_list![index]['image']
                                                  .toString())),
                                        ),
                                        Text(
                                          productProvider.data_list![index]['title']
                                              .toString(),
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          'Price ${productProvider.data_list![index]['price'].toString()}',
                                          // style: TextStyle(),
                                          // '৳ ${double.tryParse(productProvider.data_list[index][pr]!)?.toStringAsFixed(1)}',
                                          // style: TextStyle(color: Colors.green),
                                        )
                                      ],
                                    )),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              itemCount: men.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                // men.sort((a, b) => a['price'].compareTo(b['price']));
                                // for (var p in men) {
                                //  // print(p['price']);
                                // }
                                return Card(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              child: Image.network(
                                                  men[index]['image'].toString())),
                                        ),
                                        Text(
                                          men[index]['title'].toString(),
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          'Price ${men[index]['price'].toString()}',
                                          style: TextStyle(),
                                        )
                                      ],
                                    ));
                              })
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: GridView.builder(
                          itemCount: jewelery.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Expanded(
                                        child: Image.network(
                                            jewelery[index]['image'].toString()),
                                      )),
                                  Text(jewelery[index]['title'].toString()),
                                  Text(
                                    'Price ${jewelery[index]['price'].toString()}',
                                    style: TextStyle(),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              itemCount: women.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Image.network(women[index]
                                            ['image']
                                                .toString())),
                                      ),
                                      Text(women[index]['title'].toString()),
                                      Text(
                                        'Price ${women[index]['price'].toString()}',
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              itemCount: electrics.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Image.network(
                                                electrics[index]['image']
                                                    .toString())),
                                      ),
                                      Text(
                                          electrics[index]['title'].toString()),
                                      Text(
                                        'Price ${electrics[index]['price'].toString()}',
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          )),
    );

  }
}

//
//
// class MyTabbedPage extends StatefulWidget {
//   const MyTabbedPage({Key? key}) : super(key: key);
//   @override
//   State<MyTabbedPage> createState() => _MyTabbedPageState();
// }
//
// class _MyTabbedPageState extends State<MyTabbedPage>
//     with SingleTickerProviderStateMixin {
//   //List<Map<String, dynamic>> juwerieslist = [];
//
//   static const List<Tab> myTabs = <Tab>[
//     Tab(text: 'All'),
//     Tab(text: 'Men'),
//     Tab(text: 'Jewelery'),
//     Tab(text: 'Women'),
//     Tab(text: 'Electics'),
//   ];
//
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     ProductProvider productProvider =
//         Provider.of<ProductProvider>(context, listen: false);
//     productProvider.getdata();
//
//     super.initState();
//     _tabController = TabController(vsync: this, length: myTabs.length);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ProductProvider productProvider = Provider.of<ProductProvider>(
//       context,
//     );
//     List men = productProvider.data_list
//         .where(
//           (element) => element['category'] == 'men\'s clothing',
//         )
//         .toList();
//     List women = productProvider.data_list
//         .where(
//           (element) => element['category'] == 'women\'s clothing',
//         )
//         .toList();
//     List jewelery = productProvider.data_list
//         .where(
//           (element) => element['category'] == 'jewelery',
//         )
//         .toList();
//     List electrics = productProvider.data_list
//         .where(
//           (element) => element['category'] == 'electronics',
//         )
//         .toList();
//
//     // print('women ${data}');
//     // print('women ${data.length}');
//     // print(data[0]['title']);
//
//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         // toolbarHeight: 80,
//         // flexibleSpace: Container(decoration: BoxDecoration(
//         //  // color: LinearGradient(colors: [])
//         // ),),
//         // backgroundColor:Color(0xffFF6000),
//         title: AppBar(
//           title: Text(' BPPSHOP'),
//         ),
//         bottom: TabBar(
//           isScrollable: true,
//           controller: _tabController,
//           tabs: myTabs,
//         ),
//       ),
//       body: TabBarView(controller: _tabController, children: [
//         SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                   itemCount: productProvider.data_list.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     productProvider.data_list
//                         .sort((a, b) => a['price'].compareTo(b['price']));
//                     for (var p in productProvider.data_list) {
//                       print(p['price']);
//                     }
//                     return Card(
//                         child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                               child: Image.network(productProvider
//                                   .data_list[index]['image']
//                                   .toString())),
//                         ),
//                         Text(
//                           productProvider.data_list[index]['title'].toString(),
//                           style: TextStyle(),
//                         ),
//                         Text(
//                           'Price ${productProvider.data_list[index]['price'].toString()}',
//                           style: TextStyle(),
//                         )
//                       ],
//                     ));
//                   })
//             ],
//           ),
//         ),
//         SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                   itemCount: men.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     // men.sort((a, b) => a['price'].compareTo(b['price']));
//                     // for (var p in men) {
//                     //  // print(p['price']);
//                     // }
//                     return Card(
//                         child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                               child: Image.network(
//                                   men[index]['image'].toString())),
//                         ),
//                         Text(
//                           men[index]['title'].toString(),
//                           style: TextStyle(),
//                         ),
//                         Text(
//                           'Price ${men[index]['price'].toString()}',
//                           style: TextStyle(),
//                         )
//                       ],
//                     ));
//                   })
//             ],
//           ),
//         ),
//         SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                   itemCount: jewelery.length,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: Column(
//                         children: [
//                           Container(
//                               child: Expanded(
//                             child: Image.network(
//                                 jewelery[index]['image'].toString()),
//                           )),
//                           Text(jewelery[index]['title'].toString()),
//                           Text(
//                             'Price ${jewelery[index]['price'].toString()}',
//                             style: TextStyle(),
//                           )
//                         ],
//                       ),
//                     );
//                   })
//             ],
//           ),
//         ),
//         SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                   itemCount: women.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Container(
//                                 child: Image.network(
//                                     women[index]['image'].toString())),
//                           ),
//                           Text(women[index]['title'].toString()),
//                           Text(
//                             'Price ${women[index]['price'].toString()}',
//                             style: TextStyle(),
//                           )
//                         ],
//                       ),
//                     );
//                   })
//             ],
//           ),
//         ),
//         SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                   itemCount: electrics.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Container(
//                                 child: Image.network(
//                                     electrics[index]['image'].toString())),
//                           ),
//                           Text(electrics[index]['title'].toString()),
//                           Text(
//                             'Price ${electrics[index]['price'].toString()}',
//                             style: TextStyle(),
//                           )
//                         ],
//                       ),
//                     );
//                   })
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }
