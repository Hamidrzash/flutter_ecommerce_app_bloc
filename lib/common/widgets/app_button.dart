import 'package:flutter/material.dart';
import 'package:testproject/main.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {Key? key,
      required this.text,
      required this.widget,
      required this.function,
      this.padding = 16})
      : super(key: key);
  final String text;
  final Widget widget;
  double padding;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Opacity(
        opacity: function != null ? 1 : 0.6,
        child: ElevatedButton(
          onPressed: function,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xffFFDB47)),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(60)),
          ),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Center(
                  child: Text(
                text,
                style: TextStyles.textStyle3.copyWith(color: Colors.black),
              )),
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: widget,
              )
            ],
          ),
        ),
      ),
    );
  }
}
