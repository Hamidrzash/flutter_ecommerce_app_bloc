import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';

class Utils {
  static final Utils _singleton = Utils._internal();

  factory Utils() => _singleton;

  Utils._internal();

  final orderValueNotifier = OrderValueNotifier(null);

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  void showToast(String message, {bool isError = false}) {
    showToastWidget(
      LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          return Container(
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFD2E2E9),
                  blurRadius: 25,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(isError ? 0x4BFFD0CE : 0x3337BC7C),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/${isError ? "error" : "success"}.svg",
                      height: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      message,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textStyle2,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      position: ToastPosition.top,
      duration: const Duration(seconds: 2),
    );
  }
}

class OrderValueNotifier extends ValueNotifier<OrderModel?> {
  OrderValueNotifier(super.value);

  void notify() {
    notifyListeners();
  }
}
