import 'package:flutter/material.dart';

import '../../utils/constants.dart';
class UniversalCard extends StatelessWidget {
  final Widget widget;
  const UniversalCard({Key? key,required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Expanded(
          child: Card(
            shape: cardRadius,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: widget
            ),
          ),
        )
      ],
    );
  }
}
