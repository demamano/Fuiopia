import 'package:fuiopia/configs/config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/data/models/models.dart';
import 'package:fuiopia/presentation/screens/register/register/bloc.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuiopia/presentation/screens/register/widgets/register_form.dart';
import 'package:fuiopia/presentation/screens/register/widgets/register_header.dart';

class RegisterScreen extends StatelessWidget {
  final UserModel initialUser;

  const RegisterScreen({Key? key, required this.initialUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const RegisterHeader(),
                RegisterForm(intialUser: initialUser),
              ],
            ),
          ),
          bottomNavigationBar: _buildHaveAccountText(context),
        ),
      ),
    );
  }

  _buildHaveAccountText(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Translate.of(context).translate('already_have_an_account'),
            style: FONT_CONST.REGULAR_DEFAULT_20,
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.LOGIN,
              (_) => false,
            ),
            child: Text(
              Translate.of(context).translate('login'),
              style: FONT_CONST.BOLD_PRIMARY_20,
            ),
          ),
        ],
      ),
    );
  }
}
