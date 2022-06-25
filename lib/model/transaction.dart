import 'package:help_now/widgets/variants_model.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0) // all fields
  late String name;

  @HiveField(4) // all fields
  late String unitprice;

  @HiveField(5) // all fields
  late int sp;

  @HiveField(6) // all fields
  late int id;

  @HiveField(7) // all fields
  late bool variantavailable;

  

  // @HiveField(1)
  // late DateTime createdDate;

  // @HiveField(2)
  // late bool isExpense = true;

  // @HiveField(3)
  // late double amount;
}
