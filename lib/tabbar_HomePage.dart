import 'package:add_to_card_api/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:provider/provider.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {

  void initState() {
    ProductProvider productProvider =
    Provider.of<ProductProvider>(context, listen: false);
    productProvider.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    TabController _tabController = TabController(length: 5, vsync: this);
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

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 70,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.black54,
                    ),

                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Discover", style: TextStyle(fontSize: 30)),
            ),
          ),
          SizedBox(
            height: 30,
          ),

          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 14, right: 11),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "MENS",
                  ),
                  Tab(
                    text: "WOMENS",
                  ),
                  Tab(
                    text: "Jewelery",
                  ),
                  Tab(
                    text: "Electronics",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
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
                            return Card(
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
                                      style: TextStyle(),
                                    )
                                  ],
                                ));
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
                                              women[index]['image'].toString())),
                                    ),
                                    Text(
                                      women[index]['title'].toString(),
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      'Price ${women[index]['price'].toString()}',
                                      style: TextStyle(),
                                    )
                                  ],
                                ));
                          })
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.builder(
                          itemCount: jewelery.length,
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
                                              jewelery[index]['image'].toString())),
                                    ),
                                    Text(
                                      jewelery[index]['title'].toString(),
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      'Price ${jewelery[index]['price'].toString()}',
                                      style: TextStyle(),
                                    )
                                  ],
                                ));
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
                                              electrics[index]['image'].toString())),
                                    ),
                                    Text(
                                      electrics[index]['title'].toString(),
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      'Price ${electrics[index]['price'].toString()}',
                                      style: TextStyle(),
                                    )
                                  ],
                                ));
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),bottomNavigationBar: BottomAppBar(


    ),
    );
  }
}