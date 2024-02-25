import 'package:fuiopia/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class RelatedProductsEvent extends Equatable {
  const RelatedProductsEvent();
}

/// When user clicks to a specific product => load related products
class LoadRelatedProducts extends RelatedProductsEvent {
  final Product product;

  const LoadRelatedProducts(this.product);

  @override
  List<Object> get props => [product];
}

class OnSeeAll extends RelatedProductsEvent {
  final String categoryId;

  const OnSeeAll(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
