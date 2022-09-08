part of 'listview_possition_bloc.dart';

abstract class ListviewPossitionState extends Equatable {
  const ListviewPossitionState();

  @override
  List<Object> get props => [];
}

class ListviewPossitionInitial extends ListviewPossitionState {}

class ListViewAtTopState extends ListviewPossitionState {}

class ListViewAtBottomState extends ListviewPossitionState {}

class ListViewAtLoadingState extends ListviewPossitionState {}
