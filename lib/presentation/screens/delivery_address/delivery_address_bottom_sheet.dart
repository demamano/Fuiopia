import 'package:fuiopia/data/models/location_model.dart';
import 'package:fuiopia/presentation/common_blocs/profile/bloc.dart';
import 'package:fuiopia/data/models/models.dart';
import 'package:fuiopia/configs/router.dart';
import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/utils/dialog.dart';
import 'package:fuiopia/presentation/widgets/custom_widgets.dart';
import 'package:fuiopia/utils/translate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'address_picker/address_picker.dart';

class DeliveryAddressModelBottomSheet extends StatefulWidget {
  final DeliveryAddressModel? deliveryAddress;

  const DeliveryAddressModelBottomSheet({Key? key, this.deliveryAddress})
      : super(key: key);
  @override
  _DeliveryAddressModelBottomSheetState createState() =>
      _DeliveryAddressModelBottomSheetState();
}

class _DeliveryAddressModelBottomSheetState
    extends State<DeliveryAddressModelBottomSheet> {
  // [deliveryAddress] is null, that means addresses is empty
  // So name and phoneNumber is default
  // And isDefaultAddress = true
  DeliveryAddressModel? get deliveryAddress => widget.deliveryAddress;

  // local states
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  LocationModel selectedCity = const LocationModel();
  LocationModel selectedDistrict = const LocationModel();
  LocationModel selectedWard = const LocationModel();
  bool isDefaultAddress = true;

  bool get isPopulated =>
      nameController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      detailAddressController.text.isNotEmpty &&
      selectedCity.name.isNotEmpty &&
      selectedDistrict.name.isNotEmpty &&
      selectedWard.name.isNotEmpty;

  @override
  void initState() {
    super.initState();

    var profileState = BlocProvider.of<ProfileBloc>(context).state;

    if (deliveryAddress != null) {
      nameController.text = deliveryAddress!.receiverName;
      phoneNumberController.text = deliveryAddress!.phoneNumber;
      detailAddressController.text = deliveryAddress!.detailAddress;
      selectedCity = deliveryAddress!.city;
      selectedDistrict = deliveryAddress!.district;
      selectedWard = deliveryAddress!.ward;
    } else if (profileState is ProfileLoaded) {
      nameController.text = profileState.loggedUser.name;
      phoneNumberController.text = profileState.loggedUser.phoneNumber;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Function(bool value)? onSwitchButtonChanged() {
    return deliveryAddress == null || deliveryAddress!.isDefault
        ? null
        : (value) => setState(() => isDefaultAddress = value);
  }

  void onSubmitAddress() {
    if (isPopulated) {
      // Create new delivery address
      var newAddress = DeliveryAddressModel(
        id: deliveryAddress != null
            ? deliveryAddress!.id
            : UniqueKey().toString(),
        receiverName: nameController.text,
        phoneNumber: phoneNumberController.text,
        city: selectedCity,
        district: selectedDistrict,
        ward: selectedWard,
        detailAddress: detailAddressController.text,
        isDefault: isDefaultAddress,
      );
      // Define method submit
      var method = deliveryAddress == null ? ListMethod.ADD : ListMethod.UPDATE;
      // Call delivery address event
      BlocProvider.of<ProfileBloc>(context).add(AddressListChanged(
        deliveryAddress: newAddress,
        method: method,
      ));

      Navigator.pop(context);
    } else {
      UtilDialog.showInformation(
        context,
        content:
            Translate.of(context).translate("you_need_to_complete_all_fields"),
      );
    }
  }

  void onRemoveAddress() {
    BlocProvider.of<ProfileBloc>(context).add(AddressListChanged(
      deliveryAddress: deliveryAddress!,
      method: ListMethod.DELETE,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildInput(),
            _buildGoogleMapOption(),
            _buildSwitchDefaultAddress(),
            _buildDeleteButton(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  _buildInput() {
    return CustomCardWidget(
      child: Column(
        children: [
          // Name input
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: Translate.of(context).translate("name"),
            ),
          ),

          SizedBox(height: SizeConfig.defaultSize),
          // Phone number input
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.text,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: Translate.of(context).translate("phone_number"),
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize),

          AddressPicker(
            addressChanged: (city, district, ward) {
              selectedCity = city;
              selectedDistrict = district;
              selectedWard = ward;
            },
            deliveryAddress: widget.deliveryAddress,
          ),
          SizedBox(height: SizeConfig.defaultSize),

          TextFormField(
            controller: detailAddressController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: Translate.of(context).translate("detail_address"),
            ),
            maxLines: null,
          ),
        ],
      ),
    );
  }

  _buildGoogleMapOption() {
    return CustomCardWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Translate.of(context).translate("use_google_map"),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
          IconButton(
            icon: const Icon(Icons.forward),
            onPressed: () => Navigator.pushNamed(context, AppRouter.MAP),
          )
        ],
      ),
    );
  }

  _buildSwitchDefaultAddress() {
    return CustomCardWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Translate.of(context).translate("put_this_is_default_address"),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
          CupertinoSwitch(
            value: isDefaultAddress,
            onChanged: onSwitchButtonChanged(),
            trackColor: COLOR_CONST.primaryColor,
          ),
        ],
      ),
    );
  }

  _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize * 0.5,
        horizontal: SizeConfig.defaultPadding,
      ),
      child: DefaultButton(
        onPressed: onSubmitAddress,
        child: Text(
          Translate.of(context).translate("confirm"),
          style: FONT_CONST.BOLD_WHITE_18,
        ),
      ),
    );
  }

  _buildDeleteButton() {
    return deliveryAddress != null && !deliveryAddress!.isDefault
        ? Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.defaultSize * 0.5,
              horizontal: SizeConfig.defaultPadding,
            ),
            child: DefaultButton(
              onPressed: onRemoveAddress,
              backgroundColor: COLOR_CONST.deleteButtonColor,
              child: Text(
                Translate.of(context).translate("delete"),
                style: FONT_CONST.BOLD_WHITE_18,
              ),
            ),
          )
        : Container();
  }
}
