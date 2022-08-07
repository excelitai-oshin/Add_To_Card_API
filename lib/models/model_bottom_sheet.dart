import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MyBottomSheet extends StatefulWidget {
  static const routeName = '/bottomSheet';

  String? image;
  String? title;
  double? price;
  double? count;
  String? description;
  MyBottomSheet({
    this.image,
    this.title,
    this.price,
    this.description,
    this.count
  });

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  // int count = 1;

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(35, 10, 35, 80),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 150,
                    child: Image.network(
                      widget.image!,
                    ),
                  ),
                ),
                Text(
                  widget.title!,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),

                RichText(
                  text: TextSpan(
                    text: '৳ ${widget.price!}  ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.green),
                    children: <TextSpan>[
                      TextSpan(
                        text: '৳ ${widget.price!}  ',
                        // text: '৳ ${double.tryParse(widget.productPrePrice!)!.toStringAsFixed(1)}',
                        style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough),
                      ),
                      TextSpan(text: "")
                    ],
                  ),
                ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Html(
                      data: "${widget.description}",
                    ),
                  ),SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Size:  ',
                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: (16)),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),child: Text("S",style: TextStyle(color: Colors.white),),

                            ),SizedBox(width: 10,),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),child: Text("M",style: TextStyle(color: Colors.white),),

                            ),SizedBox(width: 10,),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),child: Text("L",style: TextStyle(color: Colors.white)),

                            ),SizedBox(width: 10,),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),child: Text("X",style: TextStyle(color: Colors.white)),

                            ),
                            SizedBox(width: 10,),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),child: Text("XL",style: TextStyle(color: Colors.white)),

                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'required',
                      style: TextStyle(
                          color: Theme.of(context).errorColor,
                          fontSize: 14),
                    ),
                  ],
                ),
                // widget.color =="null"||widget.color ==null
                //     ? Container()
                //     :
SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Color:  ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: Colors.amber)),
                          child:
                         // Text("${widget.color}"),
                          Text("fbghtyhjuy")
                        ),Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: Colors.amber)),
                            child:
                            // Text("${widget.color}"),
                            Text("fbghtyhjuy")
                        ),Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: Colors.amber)),
                            child:
                            // Text("${widget.color}"),
                            Text("fbghtyhjuy")
                        ),
                      ],
                    ),SizedBox(height: 20,),
                Text('Quantity'),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor)),
                            child: TextButton(
                                onPressed: () {
                                  // Navigator.of(context)
                                  //     .pushNamed(ProductDetails.routeName,
                                  //     arguments: MyBottomSheet(
                                  //       productId: widget.productId,
                                  //       productImage: widget.productImage,
                                  //       productPrice: widget.productPrice,
                                  //       productPrePrice: widget.productPrePrice,
                                  //       productName: widget.productName,
                                  //       productDetail: widget.productDetail,
                                  //       qty: widget.qty,
                                  //       color: widget.color,
                                  //       size: widget.size,
                                  //       video: widget.video,
                                  //     ));

                                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductDetails(args.title)));
                                },
                                child: Text(
                                  'View Details',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Add to cart',
                                  style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {
                              // print("product added");
                              // cart.addItem(
                              //   widget.productId!,
                              //   widget.productPrice!,
                              //   widget.productName.toString(),
                              //   widget.productImage.toString(),
                              //   widget.qty,
                              // );
                              //
                              // Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    )
                    // Container(
                    //   width: 120,
                    //   height: 40,
                    //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Center(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         IconButton(
                    //           onPressed: () {
                    //             // setState(() {
                    //             //   if (widget.qty > 1) widget.qty--;
                    //             // });
                    //           },
                    //           icon: Icon(Icons.remove),
                    //         ),
                    //         Text("jhmjm",
                    //          // '${widget.qty}',
                    //           style: TextStyle(fontSize: 18),
                    //         ),
                    //         IconButton(
                    //           onPressed: () {
                    //             // setState(() {
                    //             //   widget.qty++;
                    //             // }
                    //           //  );
                    //           },
                    //           icon: Icon(Icons.add),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),

                  ],
                ),


                //   widget.size == "null"||widget.size == null
                //       ? Container()
                //       : Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           Text(
                //             'Size:  ',
                //             style: TextStyle(fontWeight: FontWeight.w600),
                //           ),
                //           GestureDetector(
                //             onTap: () {},
                //             child: Container(
                //               padding: EdgeInsets.symmetric(
                //                   horizontal: 6, vertical: 4),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey,
                //                 borderRadius: BorderRadius.circular(6),
                //               ),
                //               child: Text(
                //                 "${widget.size}",
                //                 style: TextStyle(color: Colors.white),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Text(
                //         'required',
                //         style: TextStyle(
                //             color: Theme.of(context).errorColor,
                //             fontSize: 10),
                //       ),
                //     ],
                //   ),
                //   // SizedBox(
                //   //   height: 20,
                //   // ),
                //   widget.color =="null"||widget.color ==null
                //       ? Container()
                //       : Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Color:  ',
                //             style: TextStyle(fontWeight: FontWeight.w600),
                //           ),
                //           GestureDetector(
                //             onTap: () {},
                //             child: Container(
                //               padding: EdgeInsets.symmetric(
                //                   horizontal: 15, vertical: 6),
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(6),
                //                   border: Border.all(
                //                       width: 1, color: Colors.amber)),
                //               child: Text("${widget.color}"),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Text(
                //         'required',
                //         style: TextStyle(
                //           color: Theme.of(context).errorColor,
                //           fontSize: 10,
                //         ),
                //       )
                //     ],
                //   ),
                //   Row(
                //     children: [
                //       Text('Quantity'),
                //       Container(
                //         width: 120,
                //         height: 40,
                //         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.grey),
                //             borderRadius: BorderRadius.circular(6)),
                //         child: Center(
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               IconButton(
                //                 onPressed: () {
                //                   setState(() {
                //                     if (widget.qty > 1) widget.qty--;
                //                   });
                //                 },
                //                 icon: Icon(Icons.remove),
                //               ),
                //               Text(
                //                 '${widget.qty}',
                //                 style: TextStyle(fontSize: 18),
                //               ),
                //               IconButton(
                //                 onPressed: () {
                //                   setState(() {
                //                     widget.qty++;
                //                   });
                //                 },
                //                 icon: Icon(Icons.add),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                //   Container(
                //     margin: EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Container(
                //           padding:
                //           EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(6),
                //               border: Border.all(
                //                   color: Theme.of(context).primaryColor)),
                //           child: TextButton(
                //               onPressed: () {
                //                 Navigator.of(context)
                //                     .pushNamed(ProductDetails.routeName,
                //                     arguments: MyBottomSheet(
                //                       productId: widget.productId,
                //                       productImage: widget.productImage,
                //                       productPrice: widget.productPrice,
                //                       productPrePrice: widget.productPrePrice,
                //                       productName: widget.productName,
                //                       productDetail: widget.productDetail,
                //                       qty: widget.qty,
                //                       color: widget.color,
                //                       size: widget.size,
                //                       video: widget.video,
                //                     ));
                //
                //                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductDetails(args.title)));
                //               },
                //               child: Text(
                //                 'View Details',
                //                 style: TextStyle(
                //                     color: Theme.of(context).primaryColor),
                //               )),
                //         ),
                //         SizedBox(
                //           height: 5,
                //         ),
                //         ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             primary: Colors.amber,
                //           ),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.shopping_cart,
                //                 color: Colors.white,
                //               ),
                //               Text(
                //                 'Add to cart',
                //                 style:
                //                 TextStyle(fontSize: 18, color: Colors.white),
                //               ),
                //             ],
                //           ),
                //           onPressed: () {
                //             print("product added");
                //             cart.addItem(
                //               widget.productId!,
                //               widget.productPrice!,
                //               widget.productName.toString(),
                //               widget.productImage.toString(),
                //               widget.qty,
                //             );
                //
                //             Navigator.pop(context);
                //           },
                //         )
                //       ],
                //     ),
                //   )
                //

            ),

          Positioned(
              right: 3,
              top: -12,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      ),
    );
  }
}
