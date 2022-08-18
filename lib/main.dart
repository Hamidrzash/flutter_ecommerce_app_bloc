import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:testproject/common/pref.dart';
import 'package:testproject/features/main/bloc/main_bloc.dart';
import 'package:testproject/features/main/widgets/main_page.dart';
import 'package:testproject/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:testproject/features/onboarding/widgets/onboarding_page.dart';
import 'package:testproject/features/login_register/bloc/sign_in_bloc.dart';
import 'package:testproject/features/login_register/widgets/login_register_page.dart';
import 'package:testproject/features/order/bloc/order_bloc.dart';
import 'package:testproject/features/order_complete/bloc/order_complete_bloc.dart';
import 'package:testproject/features/order_complete/widgets/order_complete_page.dart';
import 'package:testproject/features/order_review/bloc/order_review_bloc.dart';
import 'package:testproject/features/order_review/widgets/order_review_page.dart';
import 'package:testproject/features/otp_authentication/bloc/otp_authentication_bloc.dart';
import 'package:testproject/features/otp_authentication/widgets/otp_authentication_page.dart';
import 'package:testproject/features/payment_method/bloc/payment_method_bloc.dart';
import 'package:testproject/features/payment_method/widget/payment_method_page.dart';
import 'package:testproject/features/productDetail/widgets/product_detail.dart';
import 'package:testproject/features/recovery_password/bloc/recovery_password_bloc.dart';
import 'package:testproject/features/recovery_password/widgets/recovery_password_page.dart';
import 'package:testproject/features/shipping/bloc/shipping_bloc.dart';
import 'package:testproject/features/shipping/widgets/shipping_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  isLoggedIn = await Pref().isLoggedIn;
  runApp(const MyApp());
}

bool isLoggedIn = false;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: isLoggedIn ? '/main' : '/onBoarding',
        routes: {
          '/onBoarding': (_) => BlocProvider(
                create: (context) => OnboardingBloc(),
                child: const OnBoardingPage(),
              ),
          '/loginRegister': (_) => BlocProvider(
                create: (context) => LoginRegisterBloc(),
                child: const LoginRegisterPage(),
              ),
          '/recoveryPassword': (_) => BlocProvider(
                create: (context) => RecoveryPasswordBloc(),
                child: const RecoveryPasswordPage(),
              ),
          '/otpAuthentication': (_) => BlocProvider(
                create: (context) => OtpAuthenticationBloc(),
                child: const OTPAuthenticationPage(),
              ),
          '/main': (_) => BlocProvider(
                create: (context) => MainBloc(),
                child: const MainPage(),
              ),
          '/productDetail': (_) => BlocProvider(
                create: (context) => OrderBloc(),
                child: const ProductDetailPage(),
              ),
          '/shipping': (_) => BlocProvider(
                create: (context) => ShippingBloc(),
                child: const ShippingPage(),
              ),
          '/paymentMethod': (_) => BlocProvider(
                create: (context) => PaymentMethodBloc(),
                child: const PaymentMethodPage(),
              ),
          '/orderReview': (_) => BlocProvider(
                create: (context) => OrderReviewBloc(),
                child: const OrderReviewPage(),
              ),
          '/orderComplete': (_) => BlocProvider(
                create: (context) => OrderCompleteBloc(),
                child: const OrderCompletePage(),
              ),
        },
      ),
    );
  }
}

class TextStyles {
  static TextStyle textStyle1 =
      const TextStyle(fontSize: 24, fontFamily: 'DMSans Bold');
  static TextStyle textStyle2Shadow = TextStyle(
      fontSize: 14,
      shadows: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
      fontFamily: 'DMSans Medium',
      height: 1.7,
      color: Colors.black54);
  static TextStyle textStyle2Grey = TextStyle(
      fontSize: 13,
      fontFamily: 'DMSans Medium',
      height: 1.7,
      color: Colors.black.withOpacity(0.4));
  static TextStyle textStyle2 = const TextStyle(
      fontSize: 15,
      fontFamily: 'DMSans Medium',
      height: 1.7,
      color: Colors.black54);
  static TextStyle textStyle3 =
      const TextStyle(fontSize: 17, fontFamily: 'DMSans Bold');
}
