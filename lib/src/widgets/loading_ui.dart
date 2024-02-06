import 'package:flutter/material.dart';

class LoadingUI extends StatelessWidget {
  const LoadingUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 25, height: 25, child: CircularProgressIndicator.adaptive());
  }
}
