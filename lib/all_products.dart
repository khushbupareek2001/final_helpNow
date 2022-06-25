import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:help_now/model/transaction.dart';
import 'package:help_now/page/transaction_page.dart';
import 'package:help_now/widgets/app_drawer.dart';
import 'package:help_now/widgets/prodList_class.dart';
import 'package:help_now/widgets/variants_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'boxes.dart';
import 'main.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<ProductList> productData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProd();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: dashBoardAppBar(),
      drawer: Appdrawer(),
      body: Container(
        padding: EdgeInsets.all(18),
        child: GridView.builder(
          // physics: new NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width,
            childAspectRatio: 3 / 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, i) => productItem(
            productData[i].name,
            productData[i].unitprice,
            productData[i].sp,
            productData[i].customcode,
            productData[i].isActive,
            productData[i].id,
            productData[i].controller,
            productData[i].prodVarients,
            height,
            width,
            context,
          ),
          itemCount: productData.length,
        ),
      ),
    );
  }

  AppBar dashBoardAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.grid_view_rounded,
              color: HexColor("5685FF"),
              size: 30,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: HexColor("5685FF"),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          "All Products",
          style: TextStyle(
            color: HexColor("5685FF"),
            fontSize: 15,
            fontFamily: 'Nunito',
          ),
        ),
      ),
      // actions: [
      //   InkWell(
      //     onTap: () async {
      //       await Hive.openBox<Transaction>('transactions');
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => TransactionPage()),
      //       );
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.fromLTRB(5, 20, 25, 10),
      //       child: Text(
      //         "Done",
      //         style: TextStyle(
      //           color: Colors.green,
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           "Count:",
      //           style: TextStyle(color: Colors.grey),
      //         ),
      //         Text(
      //           "Units:",
      //           style: TextStyle(color: Colors.grey),
      //         ),
      //         Text(
      //           "Price:₹",
      //           style: TextStyle(color: Colors.grey),
      //         ),
      //       ],
      //     ),
      //   )
      // ],
    );
  }

  Widget productItem(
    String name,
    String unitprice,
    int sp,
    String customcode,
    bool isActive,
    int id,
    TextEditingController controller,
    List<VariantModel> l1,
    double height,
    double width,
    BuildContext context,
  ) {
    return Card(
      elevation: 8,
      child: GridTile(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, top: 12, right: 8, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.2,
                height: height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColor("E1EAFF"),
                ),
                alignment: Alignment.center,
                child: Text(
                  "₹" + unitprice,
                  textScaleFactor: 1,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.5,
                    child: Text(
                      name,
                      textScaleFactor: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    "Special Price: ₹" + sp.toString(),
                    textScaleFactor: 1,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width * 0.25,
                    height: height * 0.035,
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: width * 0.08,
                          child: InkWell(
                            child: Icon(
                              Icons.add,
                              size: 15.0,
                            ),
                            onTap: () {
                              int currentValue = int.parse(controller.text);
                              setState(() {
                                currentValue++;
                                controller.text = (currentValue)
                                    .toString(); // incrementing value
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            controller: controller,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: true,
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.08,
                          height: height * 0.035,
                          child: InkWell(
                            child: Icon(
                              Icons.remove,
                              size: 15.0,
                            ),
                            onTap: () {
                              int currentValue = int.parse(controller.text);
                              setState(() {
                                print("Setting state");
                                currentValue--;
                                controller.text =
                                    (currentValue > 1 ? currentValue : 1)
                                        .toString(); // decrementing value
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.add,
                      color: HexColor("5685FF"),
                    ),
                    onTap: () async {
                      // Hive.registerAdapter(TransactionAdapter());

                      await Hive.openBox<Transaction>('transactions');
                      addTransaction(
                          name, unitprice, sp, l1, id, controller.text);
                      const snackBar = SnackBar(
                        content: Text('Added item to cart',
                            textAlign: TextAlign.center),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addTransaction(String name, String unitprice, int sp,
      List<VariantModel> l1, int id, String controller) async {
    final transaction = Transaction()
      ..name = name
      ..unitprice = controller
      ..sp = sp
      ..id = id
      ..variantavailable = l1.isEmpty ? false : true;

    final box = Boxes.getTransactions();
    box.add(transaction);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void getProd() async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    if (decodedJson['product_list'] != null) {
      setState(() {
        for (Map product in decodedJson['product_list']) {
          List<VariantModel> l1 = [];
          TextEditingController controller = TextEditingController();
          controller.text = "1";
          if (product['product_variants'] != null)
            for (Map variant in product['product_variants']) {
              l1.add(new VariantModel(
                  variantType: variant['variant_type'],
                  variantValue: variant['variant_value'],
                  productId: variant['product_id']));
              print(variant['variant_type'] + " " + variant['variant_value']);
            }
          productData.add(
            new ProductList(
              name: product["name"] != null ? product["name"] : "",
              unitprice:
                  product["unitprice"] != null ? product["unitprice"] : "",
              sp: product["sp"] != null ? product["sp"] : 0,
              customcode:
                  product["custom_code"] != null ? product["custom_code"] : "",
              isActive:
                  product["is_active"] != null ? product["is_active"] : false,
              id: product["id"] != null ? product["id"] : "",
              controller: controller,
              prodVarients: l1,
            ),
          );
        }
      });
    }
  }
}
