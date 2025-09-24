import 'package:e_commerce_flutter/core/wrapper/categorical.dart';
import 'package:e_commerce_flutter/core/wrapper/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});
}
