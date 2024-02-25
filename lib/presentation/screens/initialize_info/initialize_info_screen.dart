import 'package:fuiopia/configs/config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/screens/initialize_info/widgets/initialize_info_form.dart';
import 'package:fuiopia/presentation/screens/initialize_info/widgets/initialize_info_header.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';

class InitializeInfoScreen extends StatelessWidget {
  const InitializeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              InitializeInfoHeader(),
              InitializeInfoForm(),
            ],
          ),
        ),
        bottomNavigationBar: _buildHaveAccountText(context),
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
            Translate.of(context).translate("already_have_an_account"),
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
              Translate.of(context).translate("login"),
              style: FONT_CONST.BOLD_PRIMARY_20,
            ),
          ),
        ],
      ),
    );
  }
}
