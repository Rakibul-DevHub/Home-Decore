import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_event.dart';
import 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(const CreateState()) {
    on<CreatePostRequested>(_onPostRequested);
    on<CreateProductRequested>(_onProductRequested);
    on<CreateActionHandled>(_onActionHandled);
  }

  void _onPostRequested(
      CreatePostRequested event,
      Emitter<CreateState> emit,
      ) {
    emit(state.copyWith(lastAction: CreateAction.post));
  }

  void _onProductRequested(
      CreateProductRequested event,
      Emitter<CreateState> emit,
      ) {
    emit(state.copyWith(lastAction: CreateAction.product));
  }

  void _onActionHandled(
      CreateActionHandled event,
      Emitter<CreateState> emit,
      ) {
    emit(state.copyWith(lastAction: CreateAction.none));
  }
}