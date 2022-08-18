import 'package:flutter/material.dart';
import 'package:testproject/main.dart';

class AppButton2 extends StatelessWidget {
  const AppButton2(
      {Key? key,
      required this.text,
      required this.widget,
      required this.function})
      : super(key: key);
  final String text;
  final Widget widget;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xff0002FC)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(60)),
      ),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Center(
              child: Text(
            text,
            style: TextStyles.textStyle3.copyWith(color: Colors.white),
          )),
          widget
        ],
      ),
    );
  }
}
