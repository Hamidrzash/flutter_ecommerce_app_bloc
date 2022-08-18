import 'package:flutter/material.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/common/widgets/order_container.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';
import 'package:testproject/common/widgets/app_button.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({Key? key, required this.orderList}) : super(key: key);
  final List<OrderModel> orderList;

  int get itemCount {
    int itemCount = 0;
    for (var element in orderList) {
      itemCount += element.count;
    }
    return itemCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF3F6F8),
                      ),
                      width: 50,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'My Cart',
                    style: TextStyles.textStyle1,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ValueListenableBuilder(
                    builder: (context, value, child) {
                      return orderList.isNotEmpty
                          ? Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFDB47),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  itemCount.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          : Container();
                    },
                    valueListenable: Utils().orderValueNotifier,
                  ),
                ],
              ),
              ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: Flexible(
                  fit: FlexFit.loose,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ValueListenableBuilder(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              for (int index = 0;
                                  index < orderList.length;
                                  index++)
                                Column(
                                  children: [
                                    index == 0
                                        ? const SizedBox(
                                            height: 8,
                                          )
                                        : Container(),
                                    OrderContainer(
                                      orderModel: orderList[index],
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                        valueListenable: Utils().orderValueNotifier,
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(
                  text: 'CHECKOUT',
                  widget: Image.asset('assets/images/arrow-long-right.png'),
                  function: () {
                    Navigator.pushNamed(context, '/shipping',
                        arguments: orderList);
                  }),
            ],
          ),
        ));
  }
}
