import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/main.dart';

class ItemContainerRectangleVertical extends StatelessWidget {
  const ItemContainerRectangleVertical(
      {Key? key,
      required this.name,
      required this.price,
      required this.imagePath,
      this.isEmpty = false})
      : super(key: key);
  final String imagePath;
  final String name;
  final double price;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? SvgPicture.asset('assets/images/container_rectangle.svg')
        : Stack(
            clipBehavior: Clip.none,
            fit: StackFit.passthrough,
            alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset('assets/images/container_rectangle.svg'),
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
                      '\$${Utils().myFormat.format(price)}',
                      style: TextStyles.textStyle2Grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
