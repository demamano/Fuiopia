import 'package:fuiopia/data/models/models.dart';
import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class GridProducts extends StatelessWidget {
  final List<Product> products;

  const GridProducts({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Image.asset(
          IMAGE_CONST.NOT_FOUND,
          width: SizeConfig.defaultSize * 25,
          height: SizeConfig.defaultSize * 25,
        ),
      );
    }
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 15 / 21,
        mainAxisSpacing: SizeConfig.defaultSize,
        crossAxisSpacing: 0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
