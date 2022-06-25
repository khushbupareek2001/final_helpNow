import 'package:flutter/cupertino.dart';
import 'package:help_now/widgets/variants_model.dart';

class ProductList {
  String name;
  String unitprice;
  int sp;
  // String productVariants;
  String customcode;
  bool isActive;
  int id;
  TextEditingController controller;
  List<VariantModel> prodVarients;
  ProductList({
    required this.name,
    required this.unitprice,
    required this.sp,
    // required this.productVariants,
    required this.customcode,
    required this.isActive,
    required this.id,
    required this.controller,
    required this.prodVarients,
  });
}
