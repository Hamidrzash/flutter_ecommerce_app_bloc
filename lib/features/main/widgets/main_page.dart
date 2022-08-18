import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/features/home/bloc/home_bloc.dart';
import 'package:testproject/features/home/widgets/home_page.dart';
import 'package:testproject/features/main/bloc/main_bloc.dart';
import 'package:testproject/features/main/widgets/bottom_navigation_bar.dart';
import 'package:testproject/features/order/bloc/order_bloc.dart';
import 'package:testproject/features/order/widgets/order_page.dart';
import 'package:testproject/features/search/bloc/search_bloc.dart';
import 'package:testproject/features/search/widgets/search_page.dart';
import 'package:testproject/features/user/widgets/user_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late final _bloc = context.read<MainBloc>();

  late TabController _tabController;

  @override
  void initState() {
    _bloc.add(MainGetOrdersDataEvent());
    _tabController = TabController(
        length: 4,
        vsync: this,
        animationDuration: const Duration(milliseconds: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<MainBloc, MasterState>(
        buildWhen: (lastState, currentState) {
          return currentState.requestType == RequestType.main;
        },
        builder: (context, state) {
          return state is RequestLoadingState || state is MainInitial
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Colors.black.withOpacity(0.4),
                  ),
                )
              : TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BlocProvider(
                      create: (context) => HomeBloc(),
                      child: HomePage(carts: _bloc.carts),
                    ),
                    BlocProvider(
                      create: (context) => SearchBloc(),
                      child: SearchPage(
                        carts: _bloc.carts,
                      ),
                    ),
                    BlocProvider(
                      create: (context) => OrderBloc(),
                      child: OrderPage(
                        carts: _bloc.carts,
                      ),
                    ),
                    const UserPage(),
                  ],
                );
        },
      ),
      bottomNavigationBar: BlocBuilder<MainBloc, MasterState>(
        builder: (context, state) {
          return AppButtonNavigationBar(
            bloc: _bloc,
            tabController: _tabController,
          );
        },
      ),
    );
  }
}
