import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/features/payment_method/bloc/payment_method_bloc.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';
import 'package:testproject/common/widgets/app_button.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  late final List<OrderModel> _carts =
      (ModalRoute.of(context)!.settings.arguments as List<dynamic>)[0];
  late final String _address =
      (ModalRoute.of(context)!.settings.arguments as List<dynamic>)[1];
  late final _bloc = context.read<PaymentMethodBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
                Text('PAYMENT METHOD', style: TextStyles.textStyle3),
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
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      splashRadius: 25,
                      constraints: const BoxConstraints(),
                      icon: SvgPicture.asset(
                        'assets/images/card.svg',
                        height: 18,
                        width: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text('Credit Card', style: TextStyles.textStyle3),
                  ],
                ),
                Row(
                  children: [
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F6F8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 90,
                    width: 40,
                    child: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: -20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff171717).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14.4)),
                        height: 100,
                        width: 190,
                      ),
                    ),
                    Positioned(
                      right: -10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffA2A2A2),
                            borderRadius: BorderRadius.circular(19)),
                        height: 120,
                        width: 210,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(24)),
                      height: 140,
                      width: 230,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '**** 9000',
                                  style: TextStyles.textStyle2
                                      .copyWith(color: Colors.white),
                                ),
                                Text('01 / 22',
                                    style: TextStyles.textStyle2.copyWith(
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Travel Card',
                                  style: TextStyles.textStyle2Grey.copyWith(
                                      color: Colors.white.withOpacity(0.6)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '&3,580.04',
                                      style: TextStyles.textStyle2.copyWith(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    SvgPicture.asset(
                                        'assets/images/master_card.svg'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: const Color(0xffF3F6F8),
            height: 2,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/paypal.svg',
              width: 28,
              height: 28,
            ),
            isThreeLine: true,
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            minVerticalPadding: 5,
            subtitle: Text(
              'Hello.carrotlabs@gmail.com',
              style: TextStyles.textStyle2Grey,
            ),
            trailing: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                return Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        width: 2,
                        color: _bloc.paymentMethod == PaymentMethod.payPal
                            ? const Color(0xff02C697)
                            : const Color(0xffF3F6F8)),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/check.svg',
                      color: _bloc.paymentMethod == PaymentMethod.payPal
                          ? const Color(0xff02C697)
                          : const Color(0xffF3F6F8),
                    ),
                  ),
                );
              },
            ),
            onTap: () {
              _bloc.add(ChangePaymentMethodEvent(
                  paymentMethod: PaymentMethod.payPal));
            },
            title: Text(
              'PayPal',
              style: TextStyles.textStyle3.copyWith(color: Colors.black),
            ),
          ),
          Container(
            color: const Color(0xffF3F6F8),
            height: 2,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/apple_pay.svg',
              height: 28,
              width: 28,
            ),
            isThreeLine: true,
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            minVerticalPadding: 5,
            subtitle: Text(
              '**** 9000',
              style: TextStyles.textStyle2Grey,
            ),
            trailing: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                return Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        width: 2,
                        color: _bloc.paymentMethod == PaymentMethod.applePay
                            ? const Color(0xff02C697)
                            : const Color(0xffF3F6F8)),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/check.svg',
                      color: _bloc.paymentMethod == PaymentMethod.applePay
                          ? const Color(0xff02C697)
                          : const Color(0xffF3F6F8),
                    ),
                  ),
                );
              },
            ),
            onTap: () {
              _bloc.add(ChangePaymentMethodEvent(
                  paymentMethod: PaymentMethod.applePay));
            },
            title: Text(
              'Apple Pay',
              style: TextStyles.textStyle3.copyWith(color: Colors.black),
            ),
          ),
          Container(
            color: const Color(0xffF3F6F8),
            height: 2,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: AppButton(
                text: 'ORDER REVIEW',
                widget: Image.asset('assets/images/arrow-long-right.png'),
                function: () {
                  Navigator.pushNamed(context, '/orderReview',
                      arguments: [_carts, _address]);
                }),
          )
        ],
      )),
    );
  }
}
