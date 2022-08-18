import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';
import 'package:testproject/common/widgets/app_button.dart';

class OrderReviewPage extends StatefulWidget {
  const OrderReviewPage({Key? key}) : super(key: key);

  @override
  State<OrderReviewPage> createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  late final List<OrderModel> _carts =
      (ModalRoute.of(context)!.settings.arguments as List<dynamic>)[0];
  late final String _address =
      (ModalRoute.of(context)!.settings.arguments as List<dynamic>)[1];

  double get totalPrice {
    if (_carts.isNotEmpty) {
      double price = 0;
      for (OrderModel order in _carts) {
        price += order.price * order.count;
      }
      return price;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 30, left: 30, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Products', style: TextStyles.textStyle3),
                          IconButton(
                            onPressed: () {},
                            constraints: const BoxConstraints(),
                            splashRadius: 25,
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset(
                              'assets/images/bottom.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: SingleChildScrollView(
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
                                            child: Image.asset(
                                                _carts[index].imageUrl),
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
                    ),
                    Container(
                      color: const Color(0xffF3F6F8),
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SHIPPING',
                            style: TextStyles.textStyle2Grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              leading: SvgPicture.asset(
                                'assets/images/location.svg',
                                height: 28,
                                width: 28,
                              ),
                              horizontalTitleGap: 0,
                              minLeadingWidth: 27,
                              title: Text(
                                _address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.textStyle3
                                    .copyWith(fontSize: 15),
                              ),
                              trailing: SizedBox(
                                width: 80,
                                height: 35,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xffFFDB47)),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Change',
                                      style: TextStyles.textStyle3.copyWith(
                                          color: Colors.black, fontSize: 13),
                                    ))),
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                    color: const Color(0xffF3F6F8), width: 2)),
                            child: Center(
                              child: ListTile(
                                isThreeLine: true,
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                dense: true,
                                leading: SvgPicture.asset(
                                  'assets/images/shipping.svg',
                                  width: 28,
                                  height: 28,
                                ),
                                title: Text(
                                  'Standard',
                                  style: TextStyles.textStyle3
                                      .copyWith(color: Colors.black),
                                ),
                                subtitle: Text(
                                  '2-3 days',
                                  style: TextStyles.textStyle2Grey,
                                ),
                                trailing: SvgPicture.asset(
                                  'assets/images/arrow-long-down.svg',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Payment',
                            style: TextStyles.textStyle2Grey
                                .copyWith(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff171717),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: ListTile(
                                dense: true,
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                leading: SvgPicture.asset(
                                  'assets/images/master_card.svg',
                                  height: 28,
                                  width: 28,
                                ),
                                horizontalTitleGap: 10,
                                title: Text(
                                  '* * * *    9000',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textStyle3.copyWith(
                                      fontSize: 15, color: Colors.white),
                                ),
                                trailing: SizedBox(
                                  width: 80,
                                  height: 35,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xffFFDB47)),
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Change',
                                        style: TextStyles.textStyle3.copyWith(
                                            color: Colors.black, fontSize: 13),
                                      ))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xffF3F6F8),
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipping',
                                style: TextStyles.textStyle2Grey
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Free',
                                style: TextStyles.textStyle2Grey.copyWith(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: TextStyles.textStyle2.copyWith(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                '\$ ${Utils().myFormat.format(totalPrice)}',
                                style: TextStyles.textStyle3
                                    .copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: AppButton(
                  text: 'PLACE ORDER',
                  widget: Image.asset('assets/images/arrow-long-right.png'),
                  function: () async {
                    await Future.delayed(const Duration(milliseconds: 800));
                    Navigator.pushNamed(context, '/orderComplete',
                        arguments: _carts);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
