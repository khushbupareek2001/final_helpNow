import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:help_now/widgets/prodList_class.dart';
import 'package:help_now/widgets/variants_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class ColorVariation extends StatefulWidget {
  final int id;
  const ColorVariation({Key? key, required this.id}) : super(key: key);

  @override
  _ColorVariationState createState() => _ColorVariationState();
}

class _ColorVariationState extends State<ColorVariation> {
  int colorNo = 0;
  int sizeNo = 0;
  String colorRadio = "";
  String sizeRadio = "";
  List<ProductList> productData = [];
  List<String> color = [];
  List<String> size = [];
  bool iscolor = false;
  bool issize = false;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getProd();
    _controller.text = "1"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: dashBoardAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (iscolor == true)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Choose Color:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: GridView.builder(
                            // physics: new NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  MediaQuery.of(context).size.width,
                              childAspectRatio: 3 / 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (_, i) => productItem(color[i], i),
                            itemCount: color.length,
                          ),
                        ),
                      ],
                    ),
                  // VerticalDivider(
                  //   thickness: 1,
                  //   indent: 10,
                  //   endIndent: height * 0.3,
                  // ),
                  if (iscolor == true)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Choose Size:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: GridView.builder(
                            // physics: new NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  MediaQuery.of(context).size.width,
                              childAspectRatio: 3 / 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (_, i) => productItem1(size[i], i),
                            itemCount: size.length,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Text(
                "Quantity:",
                style: TextStyle(
                  fontFamily: 'Nunito',
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: 60.0,
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(),
                ),
                child: Row(
                  children: <Widget>[
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
                        controller: _controller,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: false,
                          signed: true,
                        ),
                        // inputFormatters: <TextInputFormatter>[
                        //   WhitelistingTextInputFormatter
                        //       .digitsOnly
                        // ],
                      ),
                    ),
                    Container(
                      height: 38.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: InkWell(
                              child: Icon(
                                Icons.arrow_drop_up,
                                size: 18.0,
                              ),
                              onTap: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  currentValue++;
                                  _controller.text = (currentValue)
                                      .toString(); // incrementing value
                                });
                              },
                            ),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 18.0,
                            ),
                            onTap: () {
                              int currentValue = int.parse(_controller.text);
                              setState(() {
                                print("Setting state");
                                currentValue--;
                                _controller.text =
                                    (currentValue > 1 ? currentValue : 1)
                                        .toString(); // decrementing value
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.1),
              Center(
                child: Container(
                  height: height * 0.06,
                  width: width * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      const snackBar = SnackBar(
                        content: Text('Varient selected',
                            textAlign: TextAlign.center),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(HexColor("5685FF")),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Done',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productItem(String color, int ind) {
    return Row(
      children: [
        Radio(
            activeColor: HexColor("5685FF"),
            value: ind,
            groupValue: colorNo,
            onChanged: (val) {
              setState(() {
                colorNo = val as int;
                colorRadio = 'color';
              });
            }),
        Text(
          color,
          textScaleFactor: 1,
          style: TextStyle(
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }

  Widget productItem1(String size, int ind) {
    return Row(
      children: [
        Radio(
            activeColor: HexColor("5685FF"),
            value: ind,
            groupValue: sizeNo,
            onChanged: (val) {
              setState(() {
                sizeNo = val as int;
                sizeRadio = 'size';
              });
            }),
        Text(
          size,
          textScaleFactor: 1,
          style: TextStyle(
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }

  AppBar dashBoardAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.west_outlined,
            color: HexColor("5685FF"),
          ),
        ),
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
          "Select Varients",
          style: TextStyle(
            color: HexColor("5685FF"),
            fontSize: 15,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }

  void getProd() async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    if (decodedJson['product_list'] != null) {
      setState(() {
        for (Map product in decodedJson['product_list']) {
          List<VariantModel> l1 = [];
          if (product['product_variants'] != null &&
              product["id"] == widget.id) {
            for (Map variant in product['product_variants']) {
              l1.add(new VariantModel(
                  variantType: variant['variant_type'],
                  variantValue: variant['variant_value'],
                  productId: variant['product_id']));
              if (variant["variant_type"] == "color") {
                color.add(variant["variant_value"]);
                iscolor = true;
              }
              if (variant["variant_type"] == "size") {
                size.add(variant["variant_value"]);
                issize = true;
              }

              print(variant['variant_type'] + " " + variant['variant_value']);
            }
          }
          TextEditingController controller = TextEditingController();
          controller.text = "1";
          if (product["id"] == widget.id)
            productData.add(
              new ProductList(
                name: product["name"] != null ? product["name"] : "",
                unitprice:
                    product["unitprice"] != null ? product["unitprice"] : "",
                sp: product["sp"] != null ? product["sp"] : 0,
                customcode: product["custom_code"] != null
                    ? product["custom_code"]
                    : "",
                isActive:
                    product["is_active"] != null ? product["is_active"] : false,
                id: product["id"] != null ? product["id"] : "",
                controller: controller,
                prodVarients: l1,
              ),
            );
          // print(productData.length)
        }
      });
    }
  }
}
