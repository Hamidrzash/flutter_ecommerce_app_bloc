import 'package:flutter/material.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';

class OrderContainer extends StatelessWidget {
  OrderContainer({Key? key, required this.orderModel}) : super(key: key);

  OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          width: 305,
          height: 142,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xffF3F6F8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(orderModel.imageUrl),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderModel.name,
                        style: TextStyles.textStyle3,
                      ),
                      Text(
                        orderModel.color,
                        style: TextStyles.textStyle2Grey,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$${Utils().myFormat.format(orderModel.price)}',
                        style:
                            TextStyles.textStyle2.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                            clipBehavior: Clip.hardEdge,
                            child: IconButton(
                              onPressed: () {
                                if (orderModel.count > 1) {
                                  orderModel.count--;
                                  Utils().orderValueNotifier.value = orderModel;
                                  Utils().orderValueNotifier.notify();
                                } else if (orderModel.count == 1) {
                                  orderModel.count = 0;
                                  Utils().orderValueNotifier.value = orderModel;
                                  Utils().orderValueNotifier.notify();
                                }
                              },
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                orderModel.count == 1
                                    ? Icons.delete
                                    : Icons.remove_rounded,
                                color: const Color(0xff8F92A1),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                orderModel.count.toString(),
                                style: TextStyles.textStyle3
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                            clipBehavior: Clip.hardEdge,
                            child: IconButton(
                              onPressed: () {
                                if (orderModel.count < orderModel.inStock) {
                                  orderModel.count++;
                                  Utils().orderValueNotifier.value = orderModel;
                                  Utils().orderValueNotifier.notify();
                                }
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.add_rounded,
                                color: Color(0xff8F92A1),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
