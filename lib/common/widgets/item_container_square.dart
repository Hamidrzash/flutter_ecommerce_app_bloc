import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/main.dart';

class ItemContainerSquare extends StatelessWidget {
  const ItemContainerSquare(
      {Key? key,
      required this.name,
      required this.inStock,
      required this.imagePath,
      this.isEmpty = false})
      : super(key: key);
  final String imagePath;
  final String name;
  final int inStock;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset('assets/images/container.svg'),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset('assets/images/container.svg'),
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      Image.asset(imagePath),
                      Text(
                        name,
                        style: TextStyles.textStyle3,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${inStock.toString()}+ Product',
                        style: TextStyles.textStyle2Grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
