import 'package:flutter/material.dart';

import '../api_service/http_product.dart';
class ProductProvider extends ChangeNotifier{
  List<Map<String,dynamic>>? data_list =[];

  getData()async{
    var data =await ApiService().getdata();
    data_list=data;
    notifyListeners();
  }
}
