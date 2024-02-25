import 'package:fuiopia/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

/// MyOrders loading
class MyOrdersLoading extends OrderState {}

/// MyOrders was loaded
class MyOrdersLoaded extends OrderState {
  final List<OrderModel> deliveringOrders;
  final List<OrderModel> deliveredOrders;

  const MyOrdersLoaded({
    required this.deliveringOrders,
    required this.deliveredOrders,
  });

  @override
  List<Object> get props => [deliveringOrders, deliveredOrders];
}

/// MyOrders wasn't loaded
class MyOrdersLoadFailure extends OrderState {
  final String error;

  const MyOrdersLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
