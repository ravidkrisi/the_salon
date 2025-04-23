// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:the_salon/features/barbers/domain/repos/barbers_repo.dart';
import 'package:the_salon/features/barbers/presentation/bloc/barbers_evnet.dart';
import 'package:the_salon/features/barbers/presentation/bloc/barbers_state.dart';

class BarbersBloc extends Bloc<BarbersEvnet, BarbersState> {
  final BarbersRepo repo;
  BarbersBloc({required this.repo}) : super(BarbersInit()) {
    on<BabrbersLoadBarbers>(_onLoadBarbers);
  }

  Future<void> _onLoadBarbers(
    BabrbersLoadBarbers event,
    Emitter<BarbersState> emit,
  ) async {
    try {
      emit(BarbersLoading());

      // fetch barbers
      final barbers = await repo.getAllBarbers();

      emit(BarbersLoaded(barbers: barbers));
    } catch (e) {
      emit(BarbersErrors(message: e.toString()));
    }
  }
}
