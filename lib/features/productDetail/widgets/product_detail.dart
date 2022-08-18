import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/common/widgets/app_button.dart';
import 'package:testproject/features/productDetail/widgets/bottom_sheet.dart';
import 'package:testproject/main.dart';
import 'package:badges/badges.dart';
import 'package:testproject/model/order_model.dart';
import 'package:testproject/model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final List<OrderModel> orderList =
      (ModalRoute.of(context)!.settings.arguments as List<dynamic>)[0];
  late final ProductModel productModel =
      (ModalRoute.of(context)!.settings.arguments as List<dynamic>)[1];

  int get itemCount {
    int itemCount = 0;
    for (var element in orderList) {
      itemCount += element.count;
    }
    return itemCount;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: IconButton(
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
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              onPressed: () {
                if (orderList.isNotEmpty) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top,
                    ),
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return AppBottomSheet(
                        orderList: orderList,
                      );
                    },
                  );
                }
              },
              constraints: const BoxConstraints(),
              splashRadius: 25,
              padding: EdgeInsets.zero,
              icon: ValueListenableBuilder(
                valueListenable: Utils().orderValueNotifier,
                builder: (context, value, child) {
                  return orderList.isNotEmpty
                      ? IgnorePointer(
                          child: Badge(
                            showBadge: true,
                            badgeContent: Text(
                              itemCount.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            padding: const EdgeInsets.all(6),
                            elevation: 0,
                            position: BadgePosition.bottomEnd(),
                            badgeColor: Colors.black,
                            child: SvgPicture.asset(
                              'assets/images/page3.svg',
                            ),
                          ),
                        )
                      : SvgPicture.asset(
                          'assets/images/page3.svg',
                        );
                },
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xffF3F6F8),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  Column(
                    children: [
                      Container(
                        color: const Color(0xffF3F6F8),
                        height: MediaQuery.of(context).size.height * 0.47,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 4),
                                    child: Text(
                                      'Speakers',
                                      style: TextStyles.textStyle2Grey
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    productModel.name,
                                    style: TextStyles.textStyle1,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    'From',
                                    style: TextStyles.textStyle2Grey
                                        .copyWith(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '\$${Utils().myFormat.format(productModel.price)}',
                                    style: TextStyles.textStyle3,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    'Available Colors',
                                    style: TextStyles.textStyle2Grey
                                        .copyWith(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffFFDB47),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF8B6C3),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff000000),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior()
                              .copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(
                                      height: 80,
                                    ),
                                    Text(
                                      'Wireless, smart home speaker',
                                      style: TextStyles.textStyle3,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'A wireless speaker with a dynamic acoustic performance designed to be positioned up against the wall on a shelf or side table in your home. Impressive sound compared to its size.',
                                      style: TextStyles.textStyle2
                                          .copyWith(height: 1.3),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50, right: 10),
                        child: Image.asset('assets/images/speaker.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: Utils().orderValueNotifier,
                builder: (context, value, child) {
                  return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: AppButton(
                        text:
                            !orderList.any((item) => item.id == productModel.id)
                                ? 'ADD TO CART'
                                : 'ITEM ADDED TO CART',
                        widget: Container(),
                        function: !orderList
                                .any((item) => item.id == productModel.id)
                            ? () {
                                Utils().orderValueNotifier.value = OrderModel(
                                    id: productModel.id,
                                    name: productModel.name,
                                    imageUrl: productModel.imageUrl,
                                    price: productModel.price,
                                    color: 'Black',
                                    inStock: productModel.inStock,
                                    count: 1);
                              }
                            : null,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
