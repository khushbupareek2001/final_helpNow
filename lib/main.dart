import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:help_now/model/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:help_now/all_products.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());
  // await Hive.openBox<Transaction>('transactions');

  runApp(MyApp());
}

var url = "https://mocki.io/v1/26ca1ca6-332a-46fe-9df8-392d87a0ecf2";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      home: AllProducts(),
    );
  }
}
