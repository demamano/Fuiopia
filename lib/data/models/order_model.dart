import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuiopia/data/models/models.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String id;
  final String uid;
  final List<OrderModelItem> items;
  final String paymentMethod;
  final DeliveryAddressModel deliveryAddress;
  final int priceToBePaid;
  final int priceOfGoods;
  final int deliveryFee;
  final int coupon;
  final Timestamp createdAt;

  bool get isDelivering {
    var now = Timestamp.now();
    return now.compareTo(receivedDate) < 0;
  }

  Timestamp get receivedDate =>
      Timestamp.fromDate(createdAt.toDate().add(const Duration(days: 3)));

  const OrderModel({
    required this.id,
    required this.uid,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.priceToBePaid,
    required this.priceOfGoods,
    required this.deliveryFee,
    required this.coupon,
    required this.createdAt,
  });

  /// Json data from server turns into model data
  static OrderModel fromMap(Map<String, dynamic> data) {
    return OrderModel(
      id: data["id"],
      uid: data["uid"],
      items: List<OrderModelItem>.from(data["items"]!.map((item) {
        return OrderModelItem.fromMap(item);
      })),
      deliveryAddress: DeliveryAddressModel.fromMap(data["deliveryAddress"]),
      paymentMethod: data["paymentMethod"],
      priceToBePaid: data["priceToBePaid"],
      priceOfGoods: data["priceOfGoods"],
      deliveryFee: data["deliveryFee"],
      coupon: data["coupon"],
      createdAt: data["createdAt"],
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "items": List<dynamic>.from(items.map((item) => item.toMap())),
      "deliveryAddress": deliveryAddress.toMap(),
      "paymentMethod": paymentMethod,
      "priceToBePaid": priceToBePaid,
      "priceOfGoods": priceOfGoods,
      "deliveryFee": deliveryFee,
      "coupon": coupon,
      "createdAt": createdAt,
    };
  }

  /// Clone and update
  OrderModel cloneWith({
    id,
    uid,
    items,
    deliveryAddress,
    paymentMethod,
    priceToBePaid,
    priceOfGoods,
    deliveryFee,
    coupon,
    createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      items: items ?? this.items,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      priceToBePaid: priceToBePaid ?? this.priceToBePaid,
      priceOfGoods: priceOfGoods ?? this.priceOfGoods,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      coupon: coupon ?? this.coupon,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uid,
        items,
        deliveryAddress,
        paymentMethod,
        priceOfGoods,
        deliveryFee,
        coupon,
        createdAt,
      ];
}

class OrderModelItem {
  final String productId;

  final String productName;

  final int productPrice;

  final String productImage;

  final int quantity;

  /// Constructor
  OrderModelItem({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.quantity,
  });

  /// Json data from server turns into model data
  static OrderModelItem fromMap(Map<String, dynamic> data) {
    return OrderModelItem(
      productId: data["productId"] ?? "",
      productImage: data["productImage"] ?? "",
      productName: data["productName"] ?? "",
      productPrice: data["productPrice"] ?? "",
      quantity: data["quantity"] ?? 0,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "productName": productName,
      "productImage": productImage,
      "productPrice": productPrice,
      "quantity": quantity,
    };
  }

  /// Json data from server turns into model data
  static OrderModelItem fromCartItemModel(CartItemModel cartItem) {
    return OrderModelItem(
      productId: cartItem.productId,
      quantity: cartItem.quantity,
      productImage: cartItem.productInfo!.images[0],
      productName: cartItem.productInfo!.name,
      productPrice: cartItem.productInfo!.price,
    );
  }
}
