import 'package:flutter/material.dart';
import 'package:fuiopia/constants/font_constant.dart';
import 'package:fuiopia/data/models/delivery_address_model.dart';
import 'package:fuiopia/presentation/widgets/others/custom_card_widget.dart';
import 'package:fuiopia/presentation/widgets/others/text_row.dart';
import 'package:fuiopia/utils/translate.dart';

class DeliveryAddressCard extends StatelessWidget {
  final DeliveryAddressModel deliveryAddress;
  final Function()? onPressed;
  final bool showDefautTick;

  const DeliveryAddressCard({
    Key? key,
    required this.deliveryAddress,
    this.onPressed,
    this.showDefautTick = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                Translate.of(context).translate("delivery_address"),
                style: FONT_CONST.BOLD_PRIMARY_18,
              ),
              const Spacer(),
              _buildDefaultText(context),
            ],
          ),
          TextRow(
            title: Translate.of(context).translate("name"),
            content: deliveryAddress.receiverName,
          ),
          TextRow(
            title: Translate.of(context).translate("phone_number"),
            content: deliveryAddress.phoneNumber,
          ),
          TextRow(
            title: Translate.of(context).translate("detail_address"),
            content: deliveryAddress.toString(),
          ),
        ],
      ),
    );
  }

  _buildDefaultText(BuildContext context) {
    return deliveryAddress.isDefault && showDefautTick
        ? Text(
            "${"[${Translate.of(context).translate("default")}"}]",
            style: FONT_CONST.REGULAR_PRIMARY,
          )
        : Container();
  }
}
