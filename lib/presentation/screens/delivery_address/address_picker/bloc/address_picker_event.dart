import 'package:equatable/equatable.dart';

abstract class AddressPickerEvent extends Equatable {
  const AddressPickerEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends AddressPickerEvent {
  final String? cityId;
  final String? districtId;

  const InitialEvent({this.cityId, this.districtId});
}

class LoadDistricts extends AddressPickerEvent {
  final String cityId;

  const LoadDistricts(this.cityId);

  @override
  List<Object> get props => [cityId];
}

class LoadWards extends AddressPickerEvent {
  final String districtId;

  const LoadWards(this.districtId);

  @override
  List<Object> get props => [districtId];
}
