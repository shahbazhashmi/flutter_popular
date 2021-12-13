import 'package:flutter/material.dart';
import 'package:flutter_popular/flavor.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

void main() {
  runApp(Provider<Flavor>.value(value: Flavor.staging, child: MyApp()));
}
