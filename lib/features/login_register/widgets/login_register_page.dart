import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/pref.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/common/widgets/app_button.dart';
import 'package:testproject/common/widgets/app_button_blue.dart';
import 'package:testproject/features/login_register/bloc/sign_in_bloc.dart';
import 'package:testproject/main.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final TextEditingController _editingControllerEmail = TextEditingController();
  final TextEditingController _editingControllerPassword =
      TextEditingController();
  final TextEditingController _editingControllerUsername =
      TextEditingController();

  late final _bloc = BlocProvider.of<LoginRegisterBloc>(context);

  @override
  void dispose() {
    _editingControllerEmail.dispose();
    _editingControllerPassword.dispose();
    _editingControllerUsername.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bloc.add(GetLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginRegisterBloc, MasterState>(
        listener: (lastState, currentState) {
          if (currentState is RequestSuccessfulState &&
              currentState.requestType == RequestType.login) {
            Navigator.pushReplacementNamed(context, '/main');
            Utils().showToast('Login was successful');
          } else if (currentState is RequestSuccessfulState &&
              currentState.requestType == RequestType.register) {
            Utils().showToast('Register was successful');
            Navigator.pushReplacementNamed(context, '/main');
          } else if (currentState is RequestFailedState &&
              currentState.requestType == RequestType.login) {
            Utils().showToast(currentState.error, isError: true);
          } else if (currentState is RequestFailedState &&
              currentState.requestType == RequestType.register) {
            Utils().showToast(currentState.error, isError: true);
          } else if (currentState is RequestFailedState &&
              currentState.requestType == RequestType.location) {
            Utils().showToast(
                'Error receiving your location please check your internet connection and turn on you location',
                isError: true);
          }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 30),
                        child: Row(
                          children: [
                            IconButton(
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                _bloc.add(GetLocationEvent());
                              },
                              iconSize: 30,
                              splashRadius: 25,
                              padding: EdgeInsets.zero,
                              icon: const Center(
                                child: Icon(
                                  Icons.location_on_outlined,
                                ),
                              ),
                            ),
                            BlocBuilder<LoginRegisterBloc, MasterState>(
                              buildWhen: (lastState, currentState) {
                                return (currentState
                                            is RequestSuccessfulState &&
                                        currentState.requestType ==
                                            RequestType.location) ||
                                    (currentState is RequestLoadingState &&
                                        currentState.requestType ==
                                            RequestType.location) ||
                                    (currentState is RequestFailedState &&
                                        currentState.requestType ==
                                            RequestType.location);
                              },
                              builder: (context, state) {
                                if (state is RequestLoadingState &&
                                    state.requestType == RequestType.location) {
                                  return const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.black54,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    Pref.deviceLocation,
                                    style: TextStyles.textStyle3
                                        .copyWith(fontSize: 15),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<LoginRegisterBloc, MasterState>(
                        buildWhen: (lastState, currentState) {
                          return currentState is RegisterDisabledState ||
                              currentState is RegisterEnabledState;
                        },
                        builder: (context, state) {
                          return Text(
                            state is RegisterEnabledState
                                ? 'Getting Started'
                                : 'Let’s Sign You In',
                            style: TextStyles.textStyle1,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 10),
                        child: BlocBuilder<LoginRegisterBloc, MasterState>(
                          buildWhen: (lastState, currentState) {
                            return currentState is RegisterDisabledState ||
                                currentState is RegisterEnabledState;
                          },
                          builder: (context, state) {
                            return Text(
                              state is RegisterEnabledState
                                  ? 'Create an account to continue!'
                                  : 'Welcome back, you’ve been missed!',
                              style: TextStyles.textStyle2,
                            );
                          },
                        ),
                      ),
                      BlocBuilder<LoginRegisterBloc, MasterState>(
                        buildWhen: (lastState, currentState) {
                          return currentState is RegisterDisabledState ||
                              currentState is RegisterEnabledState;
                        },
                        builder: (context, state) {
                          return Container(
                            child: state is RegisterEnabledState
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: TextStyles.textStyle2Grey,
                                      ),
                                      TextField(
                                        style: TextStyles.textStyle1,
                                        controller: _editingControllerEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: Colors.black,
                                        decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.email_outlined),
                                            prefixIconColor: Colors.black,
                                            hoverColor: Colors.black),
                                        autocorrect: false,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          );
                        },
                      ),
                      BlocBuilder<LoginRegisterBloc, MasterState>(
                        buildWhen: (lastState, currentState) {
                          return currentState is RegisterDisabledState ||
                              currentState is RegisterEnabledState;
                        },
                        builder: (context, state) {
                          return Text(
                            state is RegisterEnabledState
                                ? 'Username'
                                : 'Username or Email',
                            style: TextStyles.textStyle2Grey,
                          );
                        },
                      ),
                      BlocBuilder<LoginRegisterBloc, MasterState>(
                        buildWhen: (lastState, currentState) {
                          return currentState is RegisterDisabledState ||
                              currentState is RegisterEnabledState;
                        },
                        builder: (context, state) {
                          return TextField(
                            style: TextStyles.textStyle1,
                            controller: state is RegisterEnabledState
                                ? _editingControllerUsername
                                : _editingControllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_sharp),
                                prefixIconColor: Colors.black,
                                hoverColor: Colors.black),
                            autocorrect: false,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Password',
                        style: TextStyles.textStyle2Grey,
                      ),
                      BlocBuilder<LoginRegisterBloc, MasterState>(
                        buildWhen: (lastState, currentState) =>
                            currentState is VisibleObscureTextState,
                        builder: (context, state) {
                          return TextField(
                            style: TextStyles.textStyle1,
                            controller: _editingControllerPassword,
                            cursorColor: Colors.black,
                            obscureText: _bloc.isObscure,
                            decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.lock_outline_sharp),
                                suffixIcon: IconButton(
                                  icon: Icon(_bloc.isObscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: () =>
                                      _bloc.add(VisibleObscureTextEvent()),
                                  splashRadius: 25,
                                ),
                                suffixIconColor: Colors.black,
                                prefixIconColor: Colors.black,
                                hoverColor: Colors.black),
                            autocorrect: false,
                          );
                        },
                      ),
                      BlocBuilder<LoginRegisterBloc, MasterState>(
                        buildWhen: (lastState, currentState) {
                          return currentState is RegisterEnabledState ||
                              currentState is RegisterDisabledState;
                        },
                        builder: (context, state) {
                          return Container(
                            child: state is RegisterEnabledState
                                ? Row(
                                    children: [
                                      BlocBuilder<LoginRegisterBloc,
                                          MasterState>(
                                        buildWhen: (lastState, currentState) =>
                                            currentState
                                                is AcceptConditionState,
                                        builder: (context, state) {
                                          return Checkbox(
                                              value: _bloc.isConditionAccepted,
                                              onChanged: (value) => _bloc
                                                  .add(AcceptConditionEvent()));
                                        },
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'By creating an account, you agree to our',
                                            style: TextStyles.textStyle2
                                                .copyWith(
                                                    fontSize: 13,
                                                    color: Colors.black),
                                          ),
                                          Text(
                                            'Term & Conditions',
                                            style: TextStyles.textStyle3
                                                .copyWith(fontSize: 13),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                      ),
                                      child: Text(
                                        'Forgot your Password?',
                                        style: TextStyles.textStyle3
                                            .copyWith(fontSize: 14),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/recoveryPassword'),
                                    )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: BlocBuilder<LoginRegisterBloc, MasterState>(
                        buildWhen: (lastState, currentState) {
                          return currentState is RegisterDisabledState ||
                              currentState is RegisterEnabledState;
                        },
                        builder: (context, state) {
                          return AppButton(
                              text: state is RegisterEnabledState
                                  ? 'SIGN UP'
                                  : 'SIGN IN',
                              padding: 0,
                              widget: Image.asset('assets/images/log_in.png'),
                              function: () {
                                final String email =
                                    _editingControllerEmail.text.trim();
                                final String password =
                                    _editingControllerPassword.text.trim();
                                final String username =
                                    _editingControllerUsername.text.trim();
                                if (state is RegisterEnabledState) {
                                  if (email.isNotEmpty &&
                                      Utils().validateEmail(email)) {
                                    if (username.isNotEmpty) {
                                      if (password.isNotEmpty) {
                                        if (_bloc.isConditionAccepted) {
                                          _bloc.add(RegisterEvent(
                                              email: email,
                                              userName: username,
                                              pass: password));
                                        } else {
                                          Utils().showToast(
                                              'Terms of Use must be accepted to continue!',
                                              isError: true);
                                        }
                                      } else {
                                        Utils().showToast(
                                            'Please enter your password',
                                            isError: true);
                                      }
                                    } else {
                                      Utils().showToast(
                                          'Please enter your username',
                                          isError: true);
                                    }
                                  } else {
                                    Utils().showToast('Please enter your email',
                                        isError: true);
                                  }
                                } else {
                                  if (email.isNotEmpty &&
                                      Utils().validateEmail(email)) {
                                    if (password.isNotEmpty) {
                                      _bloc.add(LogInEvent(
                                          email: email, pass: password));
                                    } else {
                                      Utils().showToast(
                                          'Please enter your password',
                                          isError: true);
                                    }
                                  } else {
                                    Utils().showToast('Please enter your email',
                                        isError: true);
                                  }
                                }
                              });
                        },
                      ),
                    ),
                    BlocBuilder<LoginRegisterBloc, MasterState>(
                      buildWhen: (lastState, currentState) {
                        return currentState is RegisterDisabledState ||
                            currentState is RegisterEnabledState;
                      },
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state is RegisterEnabledState
                                  ? 'Already have an account? '
                                  : "Don't have an account? ",
                              style: TextStyles.textStyle2Grey,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () => state is RegisterEnabledState
                                  ? _bloc.emit(RegisterDisabledState())
                                  : _bloc.emit(RegisterEnabledState()),
                              child: Text(
                                state is RegisterEnabledState
                                    ? 'Sign In'
                                    : "Sign up",
                                style: TextStyles.textStyle3
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Container(
                      height: 2,
                      color: const Color(0xffF3F6F8),
                    ),
                  ],
                ),
                const Expanded(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: AppButton2(
                      text: 'Connect with Facebook',
                      widget: Image.asset('assets/images/facebook.png'),
                      function: () {
                        _bloc.add(FacebookEvent());
                        Utils().showToast('Not possible at this moment',
                            isError: true);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
