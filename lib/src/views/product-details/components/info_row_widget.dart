import 'package:flutter/material.dart';

class InfoRowWidget extends StatelessWidget {
  const InfoRowWidget({
    super.key,
    this.rowName,
    this.rowInfo,
    this.rowChild,
    this.rowNameChild,
    this.mainAlign = MainAxisAlignment.start,
    this.crossAlign = CrossAxisAlignment.start,
  });
  final String? rowName;
  final Widget? rowNameChild;
  final String? rowInfo;
  final Widget? rowChild;
  final MainAxisAlignment mainAlign;
  final CrossAxisAlignment crossAlign;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAlign,
      crossAxisAlignment: crossAlign,
      children: [
        SizedBox(
          width: 100,
          child:
              rowNameChild != null
                  ? rowNameChild!
                  : Text(
                    "$rowName:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      letterSpacing: -0.5,
                    ),
                  ),
        ),
        rowChild != null
            ? rowChild!
            : Text(
              rowInfo!,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                letterSpacing: -0.5,
              ),
            ),
      ],
    );
  }
}
