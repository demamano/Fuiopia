import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/widgets/buttons/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailProductAppBar extends StatelessWidget {
  const DetailProductAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize,
        horizontal: SizeConfig.defaultPadding,
      ),
      child: Row(
        children: [
          _buildBackButton(context),
          const Spacer(),
          const CartButton(color: COLOR_CONST.textColor),
        ],
      ),
    );
  }

  _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: SizeConfig.defaultSize * 4,
        width: SizeConfig.defaultSize * 4,
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF5F6F9),
        ),
        child: SvgPicture.asset(ICON_CONST.CANCEL),
      ),
    );
  }
}
