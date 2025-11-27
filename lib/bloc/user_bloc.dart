import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import '../model/user_model.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService api;

  UserBloc(this.api) : super(UserInitial()) {
    on<FetchUsersEvent>((event, emit) async {
      emit(UserLoading());

      try {
        List<UserModel> data = await api.fetchUsers();
        emit(UserLoaded(data));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
