import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:testproject/main.dart';
import 'package:testproject/common/widgets/app_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late final _bloc = context.read<OnboardingBloc>();
  List<String> imagePath = [
    'assets/images/onBoarding.png',
    'assets/images/onBoarding.png',
    'assets/images/onBoarding.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          initialPage: 1,
                          aspectRatio: MediaQuery.of(context).size.aspectRatio,
                          onPageChanged: (index, reason) {
                            _bloc.add(SlideChangedEvent(index: index));
                          },
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                        ),
                        itemCount: imagePath.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Image.asset(imagePath[itemIndex]),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: BlocBuilder<OnboardingBloc, OnboardingState>(
                        bloc: _bloc,
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int index = 0;
                                  index < imagePath.length;
                                  index++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: AnimatedContainer(
                                    height: 5,
                                    duration: const Duration(milliseconds: 100),
                                    width: _bloc.slideIndex == index ? 16 : 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: _bloc.slideIndex == index
                                          ? const Color(0xFFFFDB47)
                                          : const Color(0xFF8F92A1),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 62, right: 35, left: 35),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Welcome to CaStore !',
                        style: TextStyles.textStyle1,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'With long experience in the audio industry,\nwe create the best quality products',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyles.textStyle2Shadow,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 36, top: 12),
                      child: AppButton(
                        text: 'GET STARTED',
                        widget:
                            Image.asset('assets/images/arrow-long-right.png'),
                        function: () => Navigator.pushReplacementNamed(
                            context, '/loginRegister'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
