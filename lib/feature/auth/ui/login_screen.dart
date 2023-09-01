import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/app/app.dart';
import 'package:weather/feature/feature.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _signIn(AuthCubit authCubit) => authCubit.signIn(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40.0),
                Text(
                  tr('auth.login'),
                  style: TextStyles.h1,
                ),
                const SizedBox(height: 12.0),
                Text(
                  tr('auth.loginDescription'),
                  style: TextStyles.b2.copyWith(color: AppColors.greyText),
                ),
                const SizedBox(height: 24.0),
                AppTextField(
                  controller: _controllerEmail,
                  labelText: 'Email',
                ),
                const SizedBox(height: 32.0),
                AppTextField(
                  controller: _controllerPassword,
                  labelText: tr('auth.password'),
                  obscureText: _obscureText,
                  suffixIcon: GestureDetector(
                    onTap: _toggle,
                    child: SvgPicture.asset(
                      _obscureText ? AppPart.icons.eyeOff : AppPart.icons.eye,
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      _signIn(context.read<AuthCubit>());
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.blue),
                    fixedSize: MaterialStateProperty.all(
                      const Size(double.maxFinite, 48),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: Text(
                    tr('auth.signIn'),
                    style: TextStyles.b1Medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
