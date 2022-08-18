import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';
import 'package:testproject/common/widgets/app_button.dart';

class OrderCompletePage extends StatefulWidget {
  const OrderCompletePage({Key? key}) : super(key: key);

  @override
  State<OrderCompletePage> createState() => _OrderCompletePageState();
}

class _OrderCompletePageState extends State<OrderCompletePage> {
  late final List<OrderModel> _carts =
      ModalRoute.of(context)!.settings.arguments as List<OrderModel>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(context, (route) {
            return route.settings.name == '/main';
          });
          return false;
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      splashRadius: 25,
                      constraints: const BoxConstraints(),
                      icon: SvgPicture.asset(
                        'assets/images/arrow-long-left.svg',
                        height: 18,
                        width: 18,
                      ),
                    ),
                    Text('ORDER REVIEW', style: TextStyles.textStyle3),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          splashRadius: 25,
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            'assets/images/dots_menu.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFDB47),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                          'assets/images/payment_successful.svg'),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Payment Successful!',
                    style: TextStyles.textStyle1,
                  ),
                  Text(
                    'Orders will arrive in 3 days!',
                    style: TextStyles.textStyle2Grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      color: const Color(0xffF3F6F8),
                      height: 2,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int index = 0; index < _carts.length; index++)
                          for (int i = 0; i < _carts[index].count; i++)
                            Padding(
                              padding: EdgeInsets.only(
                                  left: (index == 0 && i == 0) ? 30 : 0,
                                  right: 15),
                              child: SizedBox(
                                width: 100,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffF3F6F8),
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      child: Center(
                                        child:
                                            Image.asset(_carts[index].imageUrl),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      _carts[index].name,
                                      style: TextStyles.textStyle3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AppButton(
                    text: 'DONE',
                    widget: Image.asset('assets/images/arrow-long-right.png'),
                    function: () {
                      Utils().orderValueNotifier.value = null;
                      Utils().orderValueNotifier.notify();

                      Navigator.popUntil(context, (route) {
                        return route.settings.name == '/main';
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
