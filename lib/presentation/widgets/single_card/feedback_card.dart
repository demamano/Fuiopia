
import 'package:flutter/material.dart';
import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/constants/font_constant.dart';
import 'package:fuiopia/constants/image_constant.dart';
import 'package:fuiopia/data/models/feedback_model.dart';
import 'package:fuiopia/data/models/user_model.dart';
import 'package:fuiopia/data/repository/app_repository.dart';
import 'package:fuiopia/presentation/widgets/others/custom_card_widget.dart';
import 'package:fuiopia/presentation/widgets/others/loading.dart';
import 'package:fuiopia/presentation/widgets/others/rating_bar.dart';
import 'package:fuiopia/utils/formatter.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key? key,
    required this.feedBack,
  }) : super(key: key);

  final FeedBackModel feedBack;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10,
        children: [
          _buildUserInfo(context),
          _buildFeedbackContent(),
          _buildCreatedDate()
        ],
      ),
    );
  }

  _buildUserInfo(BuildContext context) {
    return FutureBuilder(
      future: AppRepository.userRepository.getUserById(feedBack.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var user = snapshot.data as UserModel;
          return Row(
            children: [
              CircleAvatar(
                backgroundImage: (user.avatar.isNotEmpty
                        ? NetworkImage(user.avatar)
                        : const AssetImage(IMAGE_CONST.DEFAULT_AVATAR))
                    as ImageProvider<Object>?,
              ),
              const SizedBox(width: 5),
              // User email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.email, style: FONT_CONST.REGULAR_DEFAULT_20),
                  const SizedBox(height: 5),
                  RatingBar(
                    readOnly: true,
                    initialRating: feedBack.rating.toDouble(),
                    itemSize: SizeConfig.defaultSize * 2.4,
                  ),
                ],
              ),
            ],
          );
        }
        return const Center(child: Loading());
      },
    );
  }

  _buildFeedbackContent() {
    return Text(
      feedBack.content,
      style: FONT_CONST.BOLD_DEFAULT_20,
    );
  }

  _buildCreatedDate() {
    return Text(
      UtilFormatter.formatTimeStamp(feedBack.timestamp),
      style: FONT_CONST.REGULAR_DEFAULT_16,
    );
  }
}
