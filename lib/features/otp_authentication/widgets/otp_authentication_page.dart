import 'package:flutter/material.dart';

import 'package:testproject/common/pref.dart';
import 'package:testproject/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:testproject/common/widgets/app_button.dart';

class OTPAuthenticationPage extends StatefulWidget {
  const OTPAuthenticationPage({Key? key}) : super(key: key);

  @override
  State<OTPAuthenticationPage> createState() => _OTPAuthenticationPageState();
}

class _OTPAuthenticationPageState extends State<OTPAuthenticationPage> {
  final TextEditingController _editingControllerCode = TextEditingController();
  late final String emailAddress =
      ModalRoute.of(context)!.settings.arguments.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 30),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 30,
                    ),
                    Text(
                      Pref.deviceLocation,
                      style: TextStyles.textStyle3.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'OTP Authentication',
                  style: TextStyles.textStyle1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Text(
                  'An authentication code has been\n sent to $emailAddress',
                  style: TextStyles.textStyle2,
                ),
              ),
              PinCodeTextField(
                appContext: context,
                autoFocus: true,
                length: 4,
                animationType: AnimationType.fade,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                autoDisposeControllers: false,
                enableActiveFill: true,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderWidth: 2,
                  fieldWidth: 60,
                  selectedFillColor: Colors.transparent,
                  selectedColor: Colors.black.withOpacity(0.2),
                  inactiveColor: Colors.black.withOpacity(0.2),
                  activeColor: Colors.black.withOpacity(0.2),
                  activeFillColor: Colors.transparent,
                  errorBorderColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                ),
                textStyle: TextStyles.textStyle1,
                controller: _editingControllerCode,
                onChanged: (_) {},
              ),
              const SizedBox(
                height: 50,
              ),
              AppButton(
                  text: 'CONTINUE',
                  widget: Image.asset('assets/images/arrow-long-right.png'),
                  function: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
