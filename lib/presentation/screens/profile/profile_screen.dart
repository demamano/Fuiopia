import 'package:fuiopia/presentation/common_blocs/auth/bloc.dart';
import 'package:fuiopia/configs/config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/screens/profile/profile_header.dart';
import 'package:fuiopia/presentation/widgets/custom_widgets.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeader(),
              _buildProfileMenuButton(
                text: Translate.of(context).translate("settings"),
                icon: ICON_CONST.SETTING,
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.SETTING);
                },
              ),
              _buildProfileMenuButton(
                text: Translate.of(context).translate("cart"),
                icon: ICON_CONST.CART,
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.CART);
                },
              ),
              _buildProfileMenuButton(
                text: Translate.of(context).translate("my_orders"),
                icon: ICON_CONST.ORDER,
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.MY_ORDERS);
                },
              ),
              _buildProfileMenuButton(
                text: Translate.of(context).translate("delivery_address"),
                icon: ICON_CONST.ADDRESS,
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.DELIVERY_ADDRESS);
                },
              ),
              _buildProfileMenuButton(
                text: Translate.of(context).translate("log_out"),
                icon: ICON_CONST.LOG_OUT,
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildProfileMenuButton({
    required String text,
    required String icon,
    required Function() onPressed,
  }) {
    return CustomListTile(
      leading: SvgPicture.asset(
        icon,
        color: COLOR_CONST.primaryColor,
        width: SizeConfig.defaultSize * 3,
      ),
      title: text,
      onPressed: onPressed,
      trailing: const Icon(Icons.arrow_forward_ios, color: COLOR_CONST.textColor),
    );
  }
}
