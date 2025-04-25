import 'package:fleet_wise/services/auth_service.dart';
import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'name_update_state.dart';

class NameUpdateCubit extends Cubit<NameUpdateState> {
  AuthService authService = AuthService();
  SecureStorageService secureStorageService = SecureStorageService();
  NameUpdateCubit() : super(NameUpdateInitial());

  //! Function to update name
  void updateName(String name) async {
    emit(NameUpdateLoading()); // Emit loading state

    try {
      // Fetch access token from secure storage
      String? accessToken = await secureStorageService.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        emit(NameUpdateError('Access token not found. Please verify again.'));
        return;
      }

      authService.updateName(name, accessToken);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);

      emit(NameUpdateSuccess(name));
    } catch (e) {
      emit(NameUpdateError(e.toString()));
    }
  }
}
