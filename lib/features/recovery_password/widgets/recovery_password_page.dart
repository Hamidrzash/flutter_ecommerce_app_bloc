import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/common/pref.dart';
import 'package:testproject/features/recovery_password/bloc/recovery_password_bloc.dart';
import 'package:testproject/main.dart';
import 'package:testproject/common/widgets/app_button.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final TextEditingController _editingControllerEmail = TextEditingController();
  late final _bloc = context.read<RecoveryPasswordBloc>();

  @override
  void dispose() {
    // TODO: implement dispose
    _editingControllerEmail.dispose();
    super.dispose();
  }

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
                  'Password Recovery',
                  style: TextStyles.textStyle1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Text(
                  'Enter your Phone number to recover\nyour password',
                  style: TextStyles.textStyle2,
                ),
              ),
              Text(
                'Email',
                style: TextStyles.textStyle2Grey,
              ),
              BlocBuilder<RecoveryPasswordBloc, RecoveryPasswordState>(
                buildWhen: (lastState, currentState) =>
                    currentState is InputValidateState,
                bloc: _bloc,
                builder: (context, state) {
                  return TextField(
                    style: TextStyles.textStyle1,
                    onChanged: (value) {
                      _bloc.add(InputValidateEvent(email: value));
                    },
                    controller: _editingControllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        suffixIcon: _bloc.isValid
                            ? const Icon(
                                Icons.check,
                                color: Color(0xff02C697),
                              )
                            : null,
                        hoverColor: Colors.black),
                    autocorrect: false,
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              AppButton(
                  text: 'CONTINUE',
                  widget: Image.asset('assets/images/arrow-long-right.png'),
                  function: () {
                    if (_bloc.isValid) {
                      Navigator.pushNamed(context, '/otpAuthentication',
                          arguments: _editingControllerEmail.text);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
