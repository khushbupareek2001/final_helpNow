import 'package:flutter/material.dart';
import 'package:help_now/color_variation.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:help_now/boxes.dart';
import 'package:help_now/model/transaction.dart';
import 'package:help_now/widgets/transaction_dialog.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: dashBoardAppBar(),
        body: ValueListenableBuilder<Box<Transaction>>(
          valueListenable: Boxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<Transaction>();

            return buildContent(transactions);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () => showDialog(
        //     context: context,
        //     builder: (context) => TransactionDialog(
        //       onClickedDone: addTransaction,
        //     ),
        //   ),
        // ),
      );

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
        width: MediaQuery.of(context).size.width * 0.3,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: HexColor("5685FF"),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          "Cart",
          style: TextStyle(
            color: HexColor("5685FF"),
            fontSize: 15,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }

  Widget buildContent(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No item added yet!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    } else {
      // final netExpense = transactions.fold<double>(
      //   0,
      //   (previousValue, transaction) => transaction.isExpense
      //       ? previousValue - transaction.amount
      //       : previousValue + transaction.amount,
      // );

      final netExpense = 0;
      final newExpenseString = '\$${netExpense.toStringAsFixed(2)}';
      final color = netExpense > 0 ? Colors.green : Colors.red;

      return Column(
        children: [
          // SizedBox(height: 24),
          // Text(
          //   'Net Expense: $newExpenseString',
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 20,
          //     color: color,
          //   ),
          // ),
          // SizedBox(height: 24),

          // Container(
          //   height: MediaQuery.of(context).size.height * 0.065,
          //   width: MediaQuery.of(context).size.width * 0.4,
          //   padding: EdgeInsets.only(right: 15,bottom: 15),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(HexColor("5685FF")),
          //       elevation: MaterialStateProperty.all(2),
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //       ),
          //     ),
          //     child: Text(
          //       'Add to cart',
          //       textScaleFactor: 1,
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 15,
          //         fontFamily: 'Nunito',
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];

                return buildTransaction(context, transaction);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(
    BuildContext context,
    Transaction transaction,
  ) {
    final color = Colors.green;
    // print(transaction.id);
    // print(transaction.variantavailable);

    return Card(
      color: Colors.white,
      elevation: 8,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          transaction.name,
          // transaction.name + "   " + transaction.unitprice, //Later updates
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: transaction.variantavailable == true
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ColorVariation(id: transaction.id)),
                  );
                },
                child: Text(
                  "Choose Varient",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            : Container(),
        trailing: Text(
          "₹" + transaction.sp.toString(),
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, transaction),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Transaction transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () {},
              // onPressed: () => Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => TransactionDialog(
              //       transaction: transaction,
              //       onClickedDone: (name, amount, isExpense) =>
              //           editTransaction(transaction, name, "", 0),
              //     ),
              //   ),
              // ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteTransaction(transaction),
            ),
          )
        ],
      );

  // Future addTransaction(String name, double amount, bool isExpense) async {
  //   final transaction = Transaction()
  //     ..name = name
  //     ..createdDate = DateTime.now()
  //     ..amount = amount
  //     ..isExpense = isExpense;

  //   final box = Boxes.getTransactions();
  //   box.add(transaction);
  //   //box.put('mykey', transaction);

  //   // final mybox = Boxes.getTransactions();
  //   // final myTransaction = mybox.get('key');
  //   // mybox.values;
  //   // mybox.keys;
  // }

  void editTransaction(
    Transaction transaction,
    String name,
    String unitprice,
    int sp,
  ) {
    transaction.name = name;
    transaction.unitprice = unitprice;
    transaction.sp = sp;
    // transaction.varientList=l1;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    transaction.save();
  }

  void deleteTransaction(Transaction transaction) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    transaction.delete();
    //setState(() => transactions.remove(transaction));
  }
}
