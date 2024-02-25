import 'package:fuiopia/configs/config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/screens/message/bloc/bloc.dart';
import 'package:fuiopia/presentation/screens/message/widgets/chat_input_field.dart';
import 'package:fuiopia/presentation/screens/message/widgets/list_messages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc()..add(LoadMessages()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: const SafeArea(
          child: Column(
            children: [
              Expanded(child: ListMessages()),
              ChatInputField(),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          const CircleAvatar(backgroundImage: AssetImage(IMAGE_CONST.DEFAULT_AVATAR)),
          SizedBox(width: SizeConfig.defaultPadding),
          Text(
            "Peachy",
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () async {
            await _makePhoneCall("0967438901");
          },
        ),
        SizedBox(width: SizeConfig.defaultPadding / 2),
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    if (await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
