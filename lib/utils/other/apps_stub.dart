/// This is made to support apps that depend on dart:io or dart:ffi
library stub;

import 'package:flutter/widgets.dart';

class Files extends StatelessWidget {
  const Files({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class Terminal extends StatelessWidget {
  const Terminal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
