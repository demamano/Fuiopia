import 'package:fuiopia/configs/router.dart';
import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/widgets/custom_widgets.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePersistentHeader extends SliverPersistentHeaderDelegate {
  final double _mainHeaderHeight = SizeConfig.defaultSize * 4;
  final double _searchFieldHeight = SizeConfig.defaultSize * 5;
  final double _insetVertical = SizeConfig.defaultSize * 1.5;
  final double _insetHorizontal = SizeConfig.defaultSize * 1.5;
  // _mainHeaderHeight + 2*_insetVertical
  final double _minHeaderExtent = SizeConfig.defaultSize * 8;
  // _mainHeaderHeight + _searchFieldHeight + 2*_insetVertical + whiteSpace
  final double _maxHeaderExtent =
      SizeConfig.defaultSize * 13 + SizeConfig.defaultSize / 2;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final offsetPercent = shrinkOffset / _maxHeaderExtent;
    var rangeSearchFieldWidth = (1 - offsetPercent).clamp(0.8, 1);
    return AnimatedContainer(
      duration: mAnimationDuration,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: COLOR_CONST.cardShadowColor.withOpacity(0.2),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: _insetVertical,
            left: _insetHorizontal,
            right: _insetHorizontal,
            height: _mainHeaderHeight,
            child: Row(
              children: [
                AnimatedOpacity(
                  opacity: offsetPercent > 0.1 ? 0 : 1,
                  duration: const Duration(microseconds: 500),
                  child: Text(
                    "Wabe",
                    style: FONT_CONST.BOLD_PRIMARY_26,
                  ),
                ),
                const Spacer(),
                const Row(
                  children: [
                    CartButton(),
                    SizedBox(width: 15),
                    MessageButton(),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: _insetVertical,
            left: 0,
            height: _searchFieldHeight,
            width: size.width * rangeSearchFieldWidth,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: _insetHorizontal),
              child: SearchFieldWidget(
                readOnly: true,
                onTap: () => Navigator.pushNamed(context, AppRouter.SEARCH),
                hintText: Translate.of(context)
                    .translate('what_would_you_search_today'),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
