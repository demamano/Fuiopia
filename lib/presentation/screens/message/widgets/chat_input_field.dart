import 'dart:io';

import 'package:fuiopia/configs/config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/screens/message/bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController messageController = TextEditingController();
  List<XFile> images = <XFile>[];
  String error = 'No Error Dectected';

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (images.isNotEmpty) {
      BlocProvider.of<MessageBloc>(context).add(SendImageMessage(
        images: images,
        text: messageController.text,
      ));
    } else if (messageController.text.isNotEmpty) {
      BlocProvider.of<MessageBloc>(context).add(SendTextMessage(
        text: messageController.text,
      ));
    }
    // Clear input
    setState(() {
      messageController.clear();
      images = [];
    });
  }

  void selectImage() async {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? resultList = [];

  try {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      resultList.add(pickedFile);
    }
  } catch (e) {
    error = e.toString();
  }

  if (!mounted) return;

  setState(() {
    images = resultList; // Assuming 'images' is updated to store XFile instead of Asset
    error = error;
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultPadding,
        vertical: SizeConfig.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: COLOR_CONST.cardShadowColor.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultPadding,
              ),
              decoration: BoxDecoration(
                color: COLOR_CONST.primaryColor.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (images.isNotEmpty) _buildImages(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          textInputAction: TextInputAction.send,
                          onEditingComplete: sendMessage,
                          decoration: const InputDecoration(
                            hintText: "Type message",
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: selectImage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: SizeConfig.defaultPadding),
          IconButton(
            icon: const Icon(Icons.send, color: COLOR_CONST.primaryColor),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }

  _buildImages() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(images.length, (index) {
          XFile asset = images[index];
          return Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.defaultSize,
              right: SizeConfig.defaultSize,
            ),
            child: Stack(
              children: [
                Image.file(File(asset.path), width: 100, height: 100),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        images.removeAt(index);
                      });
                    },
                    child: const Icon(Icons.close, color: COLOR_CONST.borderColor),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
