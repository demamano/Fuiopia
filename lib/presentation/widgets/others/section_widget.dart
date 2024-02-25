import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';

/// A section
class SectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Function()? handleOnSeeAll;

  const SectionWidget({
    required this.title,
    required this.children,
    this.handleOnSeeAll,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultPadding),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section title
          SectionTitle(
            title: title,
            handleOnSeeAll: handleOnSeeAll,
          ),
          SizedBox(height: SizeConfig.defaultSize),

          /// Section content
          Container(
            child: children.isEmpty
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Section title
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.handleOnSeeAll,
  }) : super(key: key);

  final String title;
  final Function()? handleOnSeeAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
          // See more button
          InkWell(
            onTap: handleOnSeeAll,
            child: Text(
              Translate.of(context).translate("see_all"),
              style: FONT_CONST.BOLD_PRIMARY_16,
            ),
          )
        ],
      ),
    );
  }
}
