
import 'package:flutter/material.dart';
import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/constants/font_constant.dart';
import 'package:fuiopia/data/models/category_model.dart';
import 'package:fuiopia/presentation/widgets/others/shimmer_image.dart';
import 'package:fuiopia/utils/translate.dart';



class CategoryModelCard extends StatelessWidget {
  const CategoryModelCard({
    Key? key,
    required this.category,
    this.onPressed,
  }) : super(key: key);

  final CategoryModel category;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          ShimmerImage(
            borderRadius: BorderRadius.circular(5),
            imageUrl: category.imageUrl,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: SizeConfig.defaultSize,
            left: SizeConfig.defaultSize * 2,
            child: Text(
              Translate.of(context).translate(category.name),
              style: FONT_CONST.BOLD_WHITE_20,
            ),
          ),
        ],
      ),
    );
  }
}
