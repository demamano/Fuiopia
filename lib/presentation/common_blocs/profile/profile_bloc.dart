// import 'dart:async';

// import 'package:fuiopia/presentation/common_blocs/profile/bloc.dart';
// import 'package:fuiopia/data/models/models.dart';
// import 'package:fuiopia/data/repository/repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   final AuthRepository _authRepository = AppRepository.authRepository;
//   final UserRepository _userRepository = AppRepository.userRepository;
//   final StorageRepository _storageRepository = AppRepository.storageRepository;
//   StreamSubscription? _profileStreamSub;
//   UserModel? _loggedUser;

//   ProfileBloc() : super(ProfileLoading());

//   @override
//   Stream<ProfileState> mapEventToState(event) async* {
//     if (event is LoadProfile) {
//       yield* _mapLoadProfileToState(event);
//     } else if (event is UploadAvatar) {
//       yield* _mapUploadAvatarToState(event);
//     } else if (event is AddressListChanged) {
//       yield* _mapAddressListChangedToState(event);
//     } else if (event is ProfileUpdated) {
//       yield* _mapProfileUpdatedToState(event);
//     }
//   }

//   /// Load Profile event => states
//   Stream<ProfileState> _mapLoadProfileToState(LoadProfile event) async* {
//     try {
//       _profileStreamSub?.cancel();
//       _profileStreamSub = _userRepository
//           .loggedUserStream(_authRepository.loggedFirebaseUser)
//           .listen((updatedUser) => add(ProfileUpdated(updatedUser)));
//     } catch (e) {
//       yield ProfileLoadFailure(e.toString());
//     }
//   }

//   /// Upload Avatar event => states
//   Stream<ProfileState> _mapUploadAvatarToState(UploadAvatar event) async* {
//     try {
//       // Get image url from firebase storage
//       String imageUrl = await _storageRepository.uploadImageFile(
//         "users/profile/${_loggedUser!.id}",
//         event.imageFile,
//       );
//       // Clone logged user with updated avatar
//       var updatedUser = _loggedUser!.cloneWith(avatar: imageUrl);
//       // Update user's avatar
//       await _userRepository.updateUserData(updatedUser);
//     } catch (e) {}
//   }

//   /// Address List Changed event => states
  // Stream<ProfileState> _mapAddressListChangedToState(
  //     AddressListChanged event) async* {
  //   try {
  //     // Get delivery address from event
  //     var deliveryAddress = event.deliveryAddress;
  //     // Get current addresses
  //     var addresses = List<DeliveryAddressModel>.from(_loggedUser!.addresses);
  //     if (deliveryAddress.isDefault) {
  //       addresses =
  //           addresses.map((item) => item.cloneWith(isDefault: false)).toList();
  //     }
  //     // Check method
  //     switch (event.method) {
  //       case ListMethod.ADD:
  //         // If current addresses is empty, so the first delivery address is always default
  //         if (addresses.isEmpty) {
  //           deliveryAddress = deliveryAddress.cloneWith(isDefault: true);
  //         }
  //         addresses.add(deliveryAddress);
  //         break;
  //       case ListMethod.DELETE:
  //         addresses.remove(deliveryAddress);
  //         break;
  //       case ListMethod.UPDATE:
  //         addresses = addresses.map((item) {
  //           return item.id == deliveryAddress.id ? deliveryAddress : item;
  //         }).toList();

  //         break;
  //       default:
  //     }
  //     // Clone logged user with updated addresses
  //     var updatedUser = _loggedUser!.cloneWith(addresses: addresses);
  //     // Update user's addresses
  //     await _userRepository.updateUserData(updatedUser);
  //   } catch (e) {}
  // }

//   /// Profile Updated event => states
//   Stream<ProfileState> _mapProfileUpdatedToState(ProfileUpdated event) async* {
//     try {
//       _loggedUser = event.updatedUser;
//       yield ProfileLoaded(event.updatedUser);
//     } catch (e) {
//       yield ProfileLoadFailure(e.toString());
//     }
//   }

//   @override
//   Future<void> close() {
//     _profileStreamSub?.cancel();
//     _loggedUser = null;
//     return super.close();
//   }
// }

// enum ListMethod { ADD, DELETE, UPDATE }

import 'dart:async';

import 'package:fuiopia/presentation/common_blocs/profile/bloc.dart';
import 'package:fuiopia/data/models/models.dart';
import 'package:fuiopia/data/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository = AppRepository.authRepository;
  final UserRepository _userRepository = AppRepository.userRepository;
  final StorageRepository _storageRepository = AppRepository.storageRepository;
  StreamSubscription? _profileStreamSub;
  UserModel? _loggedUser;

  ProfileBloc() : super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UploadAvatar>(_onUploadAvatar);
    on<AddressListChanged>(_onAddressListChanged);
    on<ProfileUpdated>(_onProfileUpdated);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    try {
      _profileStreamSub?.cancel();
      _profileStreamSub = _userRepository
          .loggedUserStream(_authRepository.loggedFirebaseUser)
          .listen((updatedUser) => add(ProfileUpdated(updatedUser)));
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }

  void _onUploadAvatar(UploadAvatar event, Emitter<ProfileState> emit) async {
    try {
      String imageUrl = await _storageRepository.uploadImageFile(
        "users/profile/${_loggedUser!.id}",
        event.imageFile,
      );
      var updatedUser = _loggedUser!.cloneWith(avatar: imageUrl);
      await _userRepository.updateUserData(updatedUser);
    } catch (e) {
      // Handle exception, possibly emit a failure state
    }
  }

  void _onAddressListChanged(AddressListChanged event, Emitter<ProfileState> emit) async {
    try {
      var deliveryAddress = event.deliveryAddress;
      var addresses = List<DeliveryAddressModel>.from(_loggedUser!.addresses);
      // ... rest of the logic remains the same
      var updatedUser = _loggedUser!.cloneWith(addresses: addresses);
       if (deliveryAddress.isDefault) {
        addresses =
            addresses.map((item) => item.cloneWith(isDefault: false)).toList();
      }
      switch (event.method) {
        case ListMethod.ADD:
          // If current addresses is empty, so the first delivery address is always default
          if (addresses.isEmpty) {
            deliveryAddress = deliveryAddress.cloneWith(isDefault: true);
          }
          addresses.add(deliveryAddress);
          break;
        case ListMethod.DELETE:
          addresses.remove(deliveryAddress);
          break;
        case ListMethod.UPDATE:
          addresses = addresses.map((item) {
            return item.id == deliveryAddress.id ? deliveryAddress : item;
          }).toList();

          break;
        default:
      }
      await _userRepository.updateUserData(updatedUser);
    } catch (e) {
      // Handle exception, possibly emit a failure state
    }
  }

  void _onProfileUpdated(ProfileUpdated event, Emitter<ProfileState> emit) {
    try {
      _loggedUser = event.updatedUser;
      emit(ProfileLoaded(event.updatedUser));
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _profileStreamSub?.cancel();
    _loggedUser = null;
    return super.close();
  }
}
enum ListMethod { ADD, DELETE, UPDATE }
