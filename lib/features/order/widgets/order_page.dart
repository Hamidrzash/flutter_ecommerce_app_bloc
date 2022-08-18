import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/common/widgets/order_container.dart';
import 'package:testproject/features/order/bloc/order_bloc.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';
import 'package:testproject/model/product_model.dart';
import 'package:testproject/common/widgets/app_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key, required this.carts}) : super(key: key);
  final List<OrderModel> carts;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin {
  late final _bloc = context.read<OrderBloc>();

  double get totalPrice {
    if (widget.carts.isNotEmpty) {
      double price = 0;
      for (OrderModel order in widget.carts) {
        price += order.price * order.count;
      }
      return price;
    }
    return 0;
  }

  @override
  void initState() {
    _bloc.add(GetOrdersDataEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.add(ChangeOrderDataEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // IconButton(
              //   onPressed: () {},
              //   padding: EdgeInsets.zero,
              //   splashRadius: 25,
              //   constraints: const BoxConstraints(),
              //   icon: SvgPicture.asset(
              //     'assets/images/arrow-long-left.svg',
              //     height: 18,
              //     width: 18,
              //   ),
              // ),
              Text('MY CART', style: TextStyles.textStyle3),
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
          child: BlocBuilder<OrderBloc, MasterState>(
            builder: (context, state) {
              return state is RequestLoadingState
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    )
                  : ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ValueListenableBuilder(
                            valueListenable: Utils().orderValueNotifier,
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  for (int index = 0;
                                      index < _bloc.orderList.length;
                                      index++)
                                    Column(
                                      children: [
                                        index == 0
                                            ? const SizedBox(
                                                height: 8,
                                              )
                                            : Container(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/productDetail',
                                                arguments: [
                                                  widget.carts,
                                                  ProductModel(
                                                      id: 0,
                                                      name: _bloc
                                                          .orderList[index]
                                                          .name,
                                                      imageUrl: _bloc
                                                          .orderList[index]
                                                          .imageUrl,
                                                      price: _bloc
                                                          .orderList[index]
                                                          .price,
                                                      rate: 5,
                                                      inStock: _bloc
                                                          .orderList[index]
                                                          .inStock),
                                                  _bloc.orderList[index]
                                                ]);
                                          },
                                          child: OrderContainer(
                                            orderModel: _bloc.orderList[index],
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
        Container(
          height: 2,
          color: const Color(0xffF3F6F8),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyles.textStyle2.copyWith(color: Colors.black),
                  ),
                  ValueListenableBuilder(
                      valueListenable: Utils().orderValueNotifier,
                      builder: (context, value, child) {
                        return Text(
                          '\$ ${Utils().myFormat.format(totalPrice)}',
                          style: TextStyles.textStyle3,
                        );
                      })
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ValueListenableBuilder(
                  valueListenable: Utils().orderValueNotifier,
                  builder: (context, value, child) {
                    return AppButton(
                        text: 'CHECKOUT',
                        widget:
                            Image.asset('assets/images/arrow-long-right.png'),
                        function: widget.carts.isNotEmpty
                            ? () {
                                Navigator.pushNamed(context, '/shipping',
                                    arguments: widget.carts);
                              }
                            : null);
                  }),
            ],
          ),
        )
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
