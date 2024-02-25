import 'package:fuiopia/data/models/models.dart';
import 'package:fuiopia/configs/router.dart';
import 'package:fuiopia/presentation/screens/detail_product/widgets/related_products/bloc/bloc.dart';
import 'package:fuiopia/presentation/widgets/custom_widgets.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedProducts extends StatelessWidget {
  final Product product;

  const RelatedProducts({Key? key, required this.product}) : super(key: key);

  void _onSeeAll(BuildContext context) {
    BlocProvider.of<RelatedProductsBloc>(context)
        .add(OnSeeAll(product.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RelatedProductsBloc()..add(LoadRelatedProducts(product)),
      child: BlocConsumer<RelatedProductsBloc, RelatedProductsState>(
        listenWhen: (preState, currState) => currState is GoToCategoriesScreen,
        listener: (context, state) {
          if (state is GoToCategoriesScreen) {
            Navigator.pushNamed(
              context,
              AppRouter.CATEGORIES,
              arguments: state.category,
            );
          }
        },
        buildWhen: (preState, currState) => currState is! GoToCategoriesScreen,
        builder: (context, state) {
          if (state is RelatedProductsLoading) {
            return const Loading();
          }
          if (state is RelatedProductsLoadFailure) {
            return const Center(child: Text("Loading Failure"));
          }
          if (state is RelatedProductsLoaded) {
            return SectionWidget(
              title: Translate.of(context).translate('related_products'),
              children: state.relatedProducts
                  .map((p) => ProductCard(product: p))
                  .toList(),
              handleOnSeeAll: () => _onSeeAll(context),
            );
          }
          return const Center(child: Text("Unknown state"));
        },
      ),
    );
  }
}
