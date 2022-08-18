import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/features/main/bloc/main_bloc.dart';
import 'package:testproject/main.dart';

class AppButtonNavigationBar extends StatelessWidget {
  const AppButtonNavigationBar(
      {Key? key, required this.tabController, required this.bloc})
      : super(key: key);
  final TabController tabController;
  final MainBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      currentIndex: tabController.index,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          activeIcon: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: const Color(0xffFFDB47),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/page1.svg'),
                const SizedBox(
                  width: 7,
                ),
                Text('Home',
                    style: TextStyles.textStyle2.copyWith(color: Colors.black))
              ],
            ),
          ),
          icon: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/page1.svg'),
              ],
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: const Color(0xffFFDB47),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/page2.svg'),
                const SizedBox(
                  width: 7,
                ),
                Text('Search',
                    style: TextStyles.textStyle2.copyWith(color: Colors.black))
              ],
            ),
          ),
          icon: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/page2.svg'),
              ],
            ),
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          activeIcon: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: const Color(0xffFFDB47),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/page3.svg'),
                const SizedBox(
                  width: 7,
                ),
                Text('Order',
                    style: TextStyles.textStyle2.copyWith(color: Colors.black))
              ],
            ),
          ),
          icon: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder(
                    valueListenable: Utils().orderValueNotifier,
                    builder: (context, value, child) {
                      return Badge(
                        showBadge: bloc.carts.isNotEmpty,
                        badgeContent: Text(
                          (bloc.itemCount).toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        padding: const EdgeInsets.all(6),
                        elevation: 0,
                        position: BadgePosition.bottomEnd(),
                        badgeColor: Colors.black,
                        child: SvgPicture.asset('assets/images/page3.svg'),
                      );
                    })
              ],
            ),
          ),
          label: 'Order',
        ),
        BottomNavigationBarItem(
          activeIcon: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: const Color(0xffFFDB47),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/page4.svg'),
                const SizedBox(
                  width: 7,
                ),
                Text('User',
                    style: TextStyles.textStyle2.copyWith(color: Colors.black))
              ],
            ),
          ),
          icon: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/page4.svg'),
              ],
            ),
          ),
          label: 'User',
        ),
      ],
      onTap: (pageIndex) {
        FocusScope.of(context).unfocus();
        tabController.index = pageIndex;
        bloc.add(PageChangeEvent(pageIndex: pageIndex));
      },
    );
  }
}
