// import 'dart:async';
// import 'package:fuiopia/data/models/models.dart';
// import 'package:fuiopia/data/repository/repository.dart';
// import 'package:fuiopia/presentation/screens/categories/bloc/bloc.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
//   ProductRepository _productRepository = AppRepository.productRepository;
//   late CategoryModel _category;
//   // Criteria filters
//   String _currKeyword = "";
//   ProductSortOption _currSortOption = ProductSortOption();

//   CategoriesBloc() : super(DisplayListProducts.loading());

//   /// Debounce search query changed event
//   @override
//   Stream<Transition<CategoriesEvent, CategoriesState>> transformEvents(
//       Stream<CategoriesEvent> events, transitionFn) {
//     var debounceStream = events
//         .where((event) => event is SearchQueryChanged)
//         .debounceTime(Duration(milliseconds: 300));
//     var nonDebounceStream =
//         events.where((event) => event is! SearchQueryChanged);
//     return super.transformEvents(
//       nonDebounceStream.mergeWith([debounceStream]),
//       transitionFn,
//     );
//   }

//   int sortSoldQuantityDescending(Product a, Product b) =>
//       b.soldQuantity.compareTo(a.soldQuantity);
//   int sortSoldQuantityAscending(Product a, Product b) =>
//       a.soldQuantity.compareTo(b.soldQuantity);
//   int sortPriceDescending(Product a, Product b) => b.price.compareTo(a.price);
//   int sortPriceAscending(Product a, Product b) => a.price.compareTo(b.price);

//   @override
//   Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
//     if (event is OpenScreen) {
//       yield UpdateToolbarState(showSearchField: false);
//       yield* _mapOpenScreenToState(event.category);
//     } else if (event is SearchQueryChanged) {
//       yield* _mapSearchQueryChangedToState(event.keyword);
//     } else if (event is SortOptionsChanged) {
//       yield* _mapSortOptionsChangedToState(event.productSortOption);
//     } else if (event is ClickIconSort) {
//       yield OpenSortOption(isOpen: true, currSortOption: _currSortOption);
//     } else if (event is CloseSortOption) {
//       yield OpenSortOption(isOpen: false, currSortOption: _currSortOption);
//     } else if (event is ClickIconSearch) {
//       yield UpdateToolbarState(showSearchField: true);
//     } else if (event is ClickCloseSearch) {
//       yield UpdateToolbarState(showSearchField: false);
//       yield* _mapSearchQueryChangedToState("");
//     }
//   }

//   /// Open screen event => state
//   Stream<CategoriesState> _mapOpenScreenToState(CategoryModel category) async* {
//     try {
//       _category = category;
//       yield DisplayListProducts.data(await fetchProducts());
//     } catch (e) {
//       yield DisplayListProducts.error(e.toString());
//     }
//   }

//   /// Search query changed => state
//   Stream<CategoriesState> _mapSearchQueryChangedToState(String keyword) async* {
//     yield DisplayListProducts.loading();
//     try {
//       _currKeyword = keyword;
//       yield DisplayListProducts.data(await fetchProducts());
//     } catch (e) {
//       yield DisplayListProducts.error(e.toString());
//     }
//   }

//   /// Sort option changed => state
//   Stream<CategoriesState> _mapSortOptionsChangedToState(
//       ProductSortOption productSortOption) async* {
//     _currSortOption = productSortOption;

//     yield UpdateToolbarState(showSearchField: false);

//     yield* _mapSearchQueryChangedToState("");
//   }

//   /// This should be done at server side
//   Future<PriceSegment> fetchProducts() async {
//     // Get products by category
//     List<Product> productsByCategoryModel =
//         await _productRepository.fetchProductsByCategory(_category.id);
//     // Filter products by current keyword
//     bool query(Product p) =>
//         _currKeyword.isEmpty ||
//         p.name.toLowerCase().contains(_currKeyword.toLowerCase());
//     productsByCategoryModel = productsByCategoryModel.where(query).toList();

//     // Sort
//     productsByCategoryModel.sort(_mapOptionToSortMethod());

//     // Products are classified according to price segments
//     List<Product> productsInLowRange = [];
//     List<Product> productsInMidRange = [];
//     List<Product> productsInHighRange = [];

//     productsByCategoryModel.forEach((product) {
//       if (product.price <= PriceSegment.LOW_SEGMENT) {
//         productsInLowRange.add(product);
//       } else if (product.price > PriceSegment.LOW_SEGMENT &&
//           product.price <= PriceSegment.HIGH_SEGMENT) {
//         productsInMidRange.add(product);
//       } else {
//         productsInHighRange.add(product);
//       }
//     });

//     return PriceSegment(
//       productsInLowRange: productsInLowRange,
//       productsInMidRange: productsInMidRange,
//       productsInHighRange: productsInHighRange,
//     );
//   }

//   /// Map sort options
//   int Function(Product, Product) _mapOptionToSortMethod() {
//     if (_currSortOption.productSortBy == PRODUCT_SORT_BY.SOLD_QUANTITY &&
//         _currSortOption.productSortOrderModel ==
//             PRODUCT_SORT_ORDER.DESCENDING) {
//       return sortSoldQuantityDescending;
//     }
//     if (_currSortOption.productSortBy == PRODUCT_SORT_BY.SOLD_QUANTITY &&
//         _currSortOption.productSortOrderModel == PRODUCT_SORT_ORDER.ASCENDING) {
//       return sortSoldQuantityAscending;
//     }
//     if (_currSortOption.productSortBy == PRODUCT_SORT_BY.PRICE &&
//         _currSortOption.productSortOrderModel ==
//             PRODUCT_SORT_ORDER.DESCENDING) {
//       return sortPriceDescending;
//     }
//     if (_currSortOption.productSortBy == PRODUCT_SORT_BY.PRICE &&
//         _currSortOption.productSortOrderModel == PRODUCT_SORT_ORDER.ASCENDING) {
//       return sortPriceAscending;
//     }
//     return sortSoldQuantityDescending;
//   }

//   @override
//   Future<void> close() {
//     return super.close();
//   }
// }

import 'package:fuiopia/data/models/models.dart';
import 'package:fuiopia/data/repository/repository.dart';
import 'package:fuiopia/presentation/screens/categories/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductRepository _productRepository = AppRepository.productRepository;
  late CategoryModel _category;

  // Criteria filters
  String _currKeyword = "";
  ProductSortOption _currSortOption = ProductSortOption();

  CategoriesBloc() : super(DisplayListProducts.loading()) {
    on<OpenScreen>(_mapOpenScreenToState);
    on<SearchQueryChanged>(_mapSearchQueryChangedToState);
    on<SortOptionsChanged>(_mapSortOptionsChangedToState);
    on<ClickIconSort>(_onClickIconSort);
    on<CloseSortOption>(_onCloseSortOption);
    on<ClickIconSearch>(_onClickIconSearch);
    on<ClickCloseSearch>(_onClickCloseSearch);
  }
  int sortSoldQuantityDescending(Product a, Product b) =>
      b.soldQuantity.compareTo(a.soldQuantity);
  int sortSoldQuantityAscending(Product a, Product b) =>
      a.soldQuantity.compareTo(b.soldQuantity);
  int sortPriceDescending(Product a, Product b) => b.price.compareTo(a.price);
  int sortPriceAscending(Product a, Product b) => a.price.compareTo(b.price);

  // Handlers for each event
  void _mapOpenScreenToState(
      OpenScreen event, Emitter<CategoriesState> emit) async {
    emit(UpdateToolbarState(showSearchField: false));
    emit(DisplayListProducts.loading());
    try {
      _category = event.category;
      emit(DisplayListProducts.data(await fetchProducts()));
    } catch (e) {
      emit(DisplayListProducts.error(e.toString()));
    }
  }

  void _mapSearchQueryChangedToState(
      SearchQueryChanged event, Emitter<CategoriesState> emit) async {
    emit(DisplayListProducts.loading());
    try {
      _currKeyword = event.keyword;
      emit(DisplayListProducts.data(await fetchProducts()));
    } catch (e) {
      emit(DisplayListProducts.error(e.toString()));
    }
  }

  void _mapSortOptionsChangedToState(
      SortOptionsChanged event, Emitter<CategoriesState> emit) async {
    _currSortOption = event.productSortOption;
    emit(UpdateToolbarState(showSearchField: false));
    _mapSearchQueryChangedToState(SearchQueryChanged(""), emit);
  }

  void _onClickIconSort(ClickIconSort event, Emitter<CategoriesState> emit) {
    emit(OpenSortOption(isOpen: true, currSortOption: _currSortOption));
  }

  void _onCloseSortOption(
      CloseSortOption event, Emitter<CategoriesState> emit) {
    emit(OpenSortOption(isOpen: false, currSortOption: _currSortOption));
  }

  void _onClickIconSearch(
      ClickIconSearch event, Emitter<CategoriesState> emit) {
    emit(UpdateToolbarState(showSearchField: true));
  }

  void _onClickCloseSearch(
      ClickCloseSearch event, Emitter<CategoriesState> emit) {
    emit(UpdateToolbarState(showSearchField: false));
    _mapSearchQueryChangedToState(SearchQueryChanged(""), emit);
  }

  // Rest of the methods like fetchProducts remain unchanged
  Future<PriceSegment> fetchProducts() async {
    // Get products by category
    List<Product> productsByCategoryModel =
        await _productRepository.fetchProductsByCategory(_category.id);
    // Filter products by current keyword
    bool query(Product p) =>
        _currKeyword.isEmpty ||
        p.name.toLowerCase().contains(_currKeyword.toLowerCase());
    productsByCategoryModel = productsByCategoryModel.where(query).toList();

    // Sort
    productsByCategoryModel.sort(_mapOptionToSortMethod());

    // Products are classified according to price segments
    List<Product> productsInLowRange = [];
    List<Product> productsInMidRange = [];
    List<Product> productsInHighRange = [];

    for (var product in productsByCategoryModel) {
      if (product.price <= PriceSegment.LOW_SEGMENT) {
        productsInLowRange.add(product);
      } else if (product.price > PriceSegment.LOW_SEGMENT &&
          product.price <= PriceSegment.HIGH_SEGMENT) {
        productsInMidRange.add(product);
      } else {
        productsInHighRange.add(product);
      }
    }

    return PriceSegment(
      productsInLowRange: productsInLowRange,
      productsInMidRange: productsInMidRange,
      productsInHighRange: productsInHighRange,
    );
  }

  /// Map sort options
  int Function(Product, Product) _mapOptionToSortMethod() {
    if (_currSortOption.productSortBy == PRODUCT_SORT_BY.SOLD_QUANTITY &&
        _currSortOption.productSortOrderModel ==
            PRODUCT_SORT_ORDER.DESCENDING) {
      return sortSoldQuantityDescending;
    }
    if (_currSortOption.productSortBy == PRODUCT_SORT_BY.SOLD_QUANTITY &&
        _currSortOption.productSortOrderModel == PRODUCT_SORT_ORDER.ASCENDING) {
      return sortSoldQuantityAscending;
    }
    if (_currSortOption.productSortBy == PRODUCT_SORT_BY.PRICE &&
        _currSortOption.productSortOrderModel ==
            PRODUCT_SORT_ORDER.DESCENDING) {
      return sortPriceDescending;
    }
    if (_currSortOption.productSortBy == PRODUCT_SORT_BY.PRICE &&
        _currSortOption.productSortOrderModel == PRODUCT_SORT_ORDER.ASCENDING) {
      return sortPriceAscending;
    }
    return sortSoldQuantityDescending;
  }

  @override
  Future<void> close() {
    // Perform any additional cleanup if required
    return super.close();
  }
}

// Products by price segment
class PriceSegment {
  static const LOW_SEGMENT = 1000000;
  static const HIGH_SEGMENT = 4000000;

  final List<Product> productsInLowRange;
  final List<Product> productsInMidRange;
  final List<Product> productsInHighRange;

  PriceSegment({
    required this.productsInLowRange,
    required this.productsInMidRange,
    required this.productsInHighRange,
  });
}

/// Product sort options
class ProductSortOption {
  final PRODUCT_SORT_BY? productSortBy;
  final PRODUCT_SORT_ORDER productSortOrderModel;

  ProductSortOption({
    this.productSortBy,
    this.productSortOrderModel = PRODUCT_SORT_ORDER.DESCENDING,
  });

  ProductSortOption update({productSortBy, productSortOrderModel}) {
    return ProductSortOption(
      productSortBy: productSortBy ?? this.productSortBy,
      productSortOrderModel:
          productSortOrderModel ?? this.productSortOrderModel,
    );
  }

  @override
  String toString() {
    return "ProductSortOption: $productSortBy, $productSortOrderModel";
  }
}

enum PRODUCT_SORT_BY { PRICE, SOLD_QUANTITY }

enum PRODUCT_SORT_ORDER { ASCENDING, DESCENDING }
