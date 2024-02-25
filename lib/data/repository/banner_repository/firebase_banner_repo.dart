import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuiopia/data/models/models.dart';

import 'package:fuiopia/data/repository/banner_repository/banner_repo.dart';

/// Cart is collection in each user
class FirebaseBannerRepository implements BannerRepository {
  @override
  Future<List<BannerModel>> fetchBanners() async {
    return await FirebaseFirestore.instance
        .collection("banners")
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => BannerModel.fromMap(doc.data()))
            .toList())
        .catchError((err) {});
  }

  ///Singleton factory
  static final FirebaseBannerRepository _instance =
      FirebaseBannerRepository._internal();

  factory FirebaseBannerRepository() {
    return _instance;
  }

  FirebaseBannerRepository._internal();
}
