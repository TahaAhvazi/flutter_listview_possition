import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'listview_possition_event.dart';
part 'listview_possition_state.dart';

class ListviewPossitionBloc
    extends Bloc<ListviewPossitionEvent, ListviewPossitionState> {
  ListviewPossitionBloc() : super(ListviewPossitionInitial()) {
    on<OnListViewPossitionDetectedEvent>((event, emit) {
      emit(ListViewAtLoadingState());
      print(state);
      if (event.isTop) {
        emit(ListViewAtTopState());
        print(state);
      } else {
        print("At Bottom");
        emit(ListViewAtBottomState());
        print(state);
      }
    });
  }
}
