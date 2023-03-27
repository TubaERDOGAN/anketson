

import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext{
  double dynamicWith (double val) => MediaQuery.of(this).size.width*val;
  double dynamicHeight (double val) => MediaQuery.of(this).size.height*val;
}

