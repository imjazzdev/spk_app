import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/colors.dart';

class ItemData extends StatelessWidget {
  final int id;
  final String title;
  final String subtitle;
  final List<Widget> widget;

  ItemData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(color: ColorSelect.cborder)),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID'),
                  Text(title),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('${id}'), Text(subtitle)],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget,
              ),
            )
          ],
        ));
  }
}
