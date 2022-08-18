import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/widgets/item_container_rectangle_vertical.dart';
import 'package:testproject/common/widgets/item_container_square.dart';
import 'package:testproject/features/home/bloc/home_bloc.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.carts}) : super(key: key);

  final List<OrderModel> carts;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final _bloc = context.read<HomeBloc>();

  @override
  void initState() {
    _bloc.add(HomeGetDataEvent());
    super.initState();
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
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  splashRadius: 25,
                  constraints: const BoxConstraints(),
                  icon: SvgPicture.asset(
                    'assets/images/menu.svg',
                    height: 18,
                    width: 18,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      constraints: const BoxConstraints(),
                      splashRadius: 25,
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        'assets/images/qr.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('Scan',
                        style: TextStyles.textStyle3.copyWith(fontSize: 15))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Browse by Categories',
                          style: TextStyles.textStyle3,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: BlocBuilder<HomeBloc, MasterState>(
                            builder: (context, state) {
                              return state is RequestSuccessfulState
                                  ? Row(
                                      children: [
                                        for (int index = 0;
                                            index <
                                                _bloc.categoriesItems.length;
                                            index++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 30,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: index == 0 ? 30 : 0),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: ItemContainerSquare(
                                                  name: _bloc
                                                      .categoriesItems[index]
                                                      .name,
                                                  inStock: _bloc
                                                      .categoriesItems[index]
                                                      .inStock,
                                                  imagePath: _bloc
                                                      .categoriesItems[index]
                                                      .imageUrl,
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        for (int index = 0; index < 2; index++)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: index == 0 ? 30 : 0),
                                              child: const ItemContainerSquare(
                                                name: '',
                                                inStock: 0,
                                                imagePath: '',
                                                isEmpty: true,
                                              ),
                                            ),
                                          )
                                      ],
                                    );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      color: const Color(0xffF3F6F8),
                      height: 2,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Recommended for You',
                          style: TextStyles.textStyle3,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: BlocBuilder<HomeBloc, MasterState>(
                        builder: (context, state) {
                          return state is RequestLoadingState
                              ? Column(
                                  children: [
                                    for (int index = 0; index < 8; index++)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            ItemContainerRectangleVertical(
                                                name: '',
                                                price: 0,
                                                isEmpty: true,
                                                imagePath: ''),
                                            ItemContainerRectangleVertical(
                                              name: '',
                                              price: 0,
                                              isEmpty: true,
                                              imagePath: '',
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    for (int index = 0;
                                        index < _bloc.recommendedItems.length;
                                        index++)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/productDetail',
                                                    arguments: [
                                                      widget.carts,
                                                      _bloc.recommendedItems[
                                                          index - 1]
                                                    ]);
                                              },
                                              child:
                                                  ItemContainerRectangleVertical(
                                                      name: _bloc
                                                          .recommendedItems[
                                                              index]
                                                          .name,
                                                      price: _bloc
                                                          .recommendedItems[
                                                              index]
                                                          .price,
                                                      imagePath: _bloc
                                                          .recommendedItems[
                                                              index]
                                                          .imageUrl),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/productDetail',
                                                    arguments: [
                                                      widget.carts,
                                                      _bloc.recommendedItems[
                                                          index]
                                                    ]);
                                              },
                                              child:
                                                  ItemContainerRectangleVertical(
                                                name: _bloc
                                                    .recommendedItems[++index]
                                                    .name,
                                                price: _bloc
                                                    .recommendedItems[index]
                                                    .price,
                                                imagePath: _bloc
                                                    .recommendedItems[index]
                                                    .imageUrl,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
