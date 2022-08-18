import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/widgets/item_container_rectangle_vertical.dart';
import 'package:testproject/features/search/bloc/search_bloc.dart';
import 'package:testproject/main.dart';
import 'package:testproject/model/order_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.carts}) : super(key: key);
  final List<OrderModel> carts;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  late final _bloc = context.read<SearchBloc>();
  final TextEditingController _editingControllerSearch =
      TextEditingController();
  String lastInputValue = '';

  @override
  void initState() {
    _bloc.add(GetPopularSearchesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            child: TextField(
              cursorColor: Colors.black,
              onChanged: (text) {
                if (text != lastInputValue) {
                  lastInputValue = text;
                  if (text.trim().isNotEmpty) {
                    _bloc.add(SearchItemEvent(text: text));
                  } else {
                    _bloc.add(EmptySearchEvent());
                  }
                }
              },
              onSubmitted: (text) {
                if (text.trim().isNotEmpty &&
                    !_bloc.recentSearch.contains(text)) {
                  _bloc.add(RecentSearchAddEvent(text: text));
                }
              },
              controller: _editingControllerSearch,
              style: TextStyles.textStyle3.copyWith(color: Colors.black),
              decoration: InputDecoration(
                fillColor: const Color(0xffF3F6F8),
                filled: true,
                suffixIconConstraints: const BoxConstraints(),
                hintStyle: TextStyles.textStyle3.copyWith(color: Colors.black),
                hintText: 'Search on CaStore',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    'assets/images/search.svg',
                    height: 24,
                    width: 24,
                  ),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Container(
            color: const Color(0xffF3F6F8),
            height: 2,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<SearchBloc, MasterState>(
                        builder: (context, state) {
                          return _bloc.recentSearch.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'RECENT SEARCHES',
                                        style: TextStyles.textStyle2Grey
                                            .copyWith(fontSize: 15),
                                      ),
                                      for (int i = 3,
                                              index =
                                                  _bloc.recentSearch.length - 1;
                                          index > -1 && i > 0;
                                          index--, i--)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 24),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.access_time_sharp),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    _bloc.add(
                                                        RecentSearchChangeEvent(
                                                            index: index));
                                                  },
                                                  icon: const Icon(Icons.close),
                                                ),
                                                dense: true,
                                                onTap: () {
                                                  _editingControllerSearch
                                                          .text =
                                                      _bloc.recentSearch[index];
                                                  if (_editingControllerSearch
                                                          .text !=
                                                      lastInputValue) {
                                                    lastInputValue =
                                                        _editingControllerSearch
                                                            .text;
                                                    if (_editingControllerSearch
                                                        .text
                                                        .trim()
                                                        .isNotEmpty) {
                                                      _bloc.add(SearchItemEvent(
                                                          text:
                                                              _editingControllerSearch
                                                                  .text));
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    } else {
                                                      _bloc.add(
                                                          EmptySearchEvent());
                                                    }
                                                  }
                                                },
                                                title: Text(
                                                  _bloc.recentSearch[index],
                                                  style: TextStyles.textStyle3
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                color: const Color(0xffF3F6F8),
                                                height: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              : Container();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 24),
                        child: BlocBuilder<SearchBloc, MasterState>(
                          builder: (context, state) {
                            return state is RequestLoadingState &&
                                    state.requestType == RequestType.searchItem
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      color: Colors.black.withOpacity(0.4),
                                    ))
                                : Text(
                                    state.requestType ==
                                                RequestType.searchItem ||
                                            _editingControllerSearch
                                                .text.isNotEmpty
                                        ? 'FOUND ${_bloc.foundedItems.length} RESULTS'
                                        : 'POPULAR SEARCHES',
                                    style: TextStyles.textStyle2Grey
                                        .copyWith(fontSize: 15),
                                  );
                          },
                        ),
                      ),
                      BlocBuilder<SearchBloc, MasterState>(
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
                              : state is EmptySearchState ||
                                      state.requestType ==
                                          RequestType.popularSearches ||
                                      _editingControllerSearch.text.isEmpty
                                  ? Column(
                                      children: [
                                        for (int index = 0;
                                            index < _bloc.popularSearch.length;
                                            index++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Navigator.pushNamed(context,
                                                        '/productDetail',
                                                        arguments: [
                                                          widget.carts,
                                                          _bloc.popularSearch[
                                                              index - 1]
                                                        ]);
                                                  },
                                                  child:
                                                      ItemContainerRectangleVertical(
                                                          name: _bloc
                                                              .popularSearch[
                                                                  index]
                                                              .name,
                                                          price: _bloc
                                                              .popularSearch[
                                                                  index]
                                                              .price,
                                                          imagePath: _bloc
                                                              .popularSearch[
                                                                  index]
                                                              .imageUrl),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Navigator.pushNamed(context,
                                                        '/productDetail',
                                                        arguments: [
                                                          widget.carts,
                                                          _bloc.popularSearch[
                                                              index]
                                                        ]);
                                                  },
                                                  child:
                                                      ItemContainerRectangleVertical(
                                                    name: _bloc
                                                        .popularSearch[++index]
                                                        .name,
                                                    price: _bloc
                                                        .popularSearch[index]
                                                        .price,
                                                    imagePath: _bloc
                                                        .popularSearch[index]
                                                        .imageUrl,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        for (int index = 0;
                                            index < _bloc.foundedItems.length;
                                            index++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Navigator.pushNamed(context,
                                                        '/productDetail',
                                                        arguments: [
                                                          widget.carts,
                                                          _bloc.foundedItems[
                                                              index - 1]
                                                        ]);
                                                  },
                                                  child:
                                                      ItemContainerRectangleVertical(
                                                          name: _bloc
                                                              .foundedItems[
                                                                  index]
                                                              .name,
                                                          price: _bloc
                                                              .foundedItems[
                                                                  index]
                                                              .price,
                                                          imagePath: _bloc
                                                              .foundedItems[
                                                                  index]
                                                              .imageUrl),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Navigator.pushNamed(context,
                                                        '/productDetail',
                                                        arguments: [
                                                          widget.carts,
                                                          _bloc.foundedItems[
                                                              index]
                                                        ]);
                                                  },
                                                  child:
                                                      ItemContainerRectangleVertical(
                                                    name: _bloc
                                                        .foundedItems[++index]
                                                        .name,
                                                    price: _bloc
                                                        .foundedItems[index]
                                                        .price,
                                                    imagePath: _bloc
                                                        .foundedItems[index]
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
                    ],
                  ),
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
