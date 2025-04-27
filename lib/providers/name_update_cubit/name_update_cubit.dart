import 'dart:developer';

import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'name_update_state.dart';

class NameUpdateCubit extends Cubit<NameUpdateState> {
  NameUpdateCubit() : super(NameUpdateInitial());

  //! Function to update name
  void updateName(String name) async {
    emit(NameUpdateLoading()); // Emit loading state

    try {
      LocalStorageService localStorageService = LocalStorageService();
      if (name.isNotEmpty) {
        await localStorageService.saveUserName(name);
        emit(NameUpdateSuccess(name));
      } else {
        log('not name');
        emit(NameUpdateError('No name'));
      }
    } catch (e) {
      emit(NameUpdateError(e.toString()));
    }
  }
}
