// import 'package:fuiopia/data/models/models.dart';
// import 'package:fuiopia/data/repository/repository.dart';
// import 'package:fuiopia/presentation/screens/home_page/bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final BannerRepository _bannerRepository = AppRepository.bannerRepository;
//   final ProductRepository _productRepository = AppRepository.productRepository;

//   HomeBloc() : super(HomeLoading());

//   @override
//   Stream<HomeState> mapEventToState(HomeEvent event) async* {
//     if (event is LoadHome) {
//       yield* _mapLoadHomeToState();
//     } else if (event is RefreshHome) {
//       yield HomeLoading();
//       yield* _mapLoadHomeToState();
//     }
//   }

//   Stream<HomeState> _mapLoadHomeToState() async* {
//     try {
//       HomeResponse homeResponse = HomeResponse(
//         banners: await _bannerRepository.fetchBanners(),
//         categories: await _productRepository.getCategories(),
//         popularProducts: await _productRepository.fetchPopularProducts(),
//         discountProducts: await _productRepository.fetchDiscountProducts(),
//       );
//       yield HomeLoaded(homeResponse: homeResponse);
//     } catch (e) {
//       yield HomeLoadFailure(e.toString());
//     }
//   }
// }

// class HomeResponse {
//   final List<BannerModel> banners;
//   final List<CategoryModel> categories;
//   final List<Product> popularProducts;
//   final List<Product> discountProducts;

//   HomeResponse({
//     required this.banners,
//     required this.popularProducts,
//     required this.categories,
//     required this.discountProducts,
//   });
// }

import 'package:fuiopia/data/models/models.dart';
import 'package:fuiopia/data/repository/repository.dart';
import 'package:fuiopia/presentation/screens/home_page/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository = AppRepository.bannerRepository;
  final ProductRepository _productRepository = AppRepository.productRepository;

  HomeBloc() : super(HomeLoading()) {
    on<LoadHome>(_onLoadHome);
    on<RefreshHome>(_onRefreshHome);
  }

  Future<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    try {
      HomeResponse homeResponse = HomeResponse(
        banners: await _bannerRepository.fetchBanners(),
        categories: await _productRepository.getCategories(),
        popularProducts: await _productRepository.fetchPopularProducts(),
        discountProducts: await _productRepository.fetchDiscountProducts(),
      );
      emit(HomeLoaded(homeResponse: homeResponse));
    } catch (e) {
      emit(HomeLoadFailure(e.toString()));
    }
  }

  Future<void> _onRefreshHome(RefreshHome event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await _onLoadHome(event as LoadHome, emit);
  }
}

class HomeResponse {
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<Product> popularProducts;
  final List<Product> discountProducts;

  HomeResponse({
    required this.banners,
    required this.popularProducts,
    required this.categories,
    required this.discountProducts,
  });
}
