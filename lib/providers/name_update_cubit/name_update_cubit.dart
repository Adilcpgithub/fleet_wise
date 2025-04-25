import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'name_update_state.dart';

class NameUpdateCubit extends Cubit<NameUpdateState> {
  NameUpdateCubit() : super(NameUpdateInitial());

  //! Function to update name
  void updateName(String name) async {
    emit(NameUpdateLoading()); // Emit loading state

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);

      emit(NameUpdateSuccess(name));
    } catch (e) {
      emit(NameUpdateError(e.toString()));
    }
  }
}
