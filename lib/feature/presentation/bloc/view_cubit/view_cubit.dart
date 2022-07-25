import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_state.dart';

class ViewCubit extends Cubit<bool> {
  ViewCubit() : super(false);

  void changeView(bool isAvailableForm) {
    emit(isAvailableForm);
  }
}
