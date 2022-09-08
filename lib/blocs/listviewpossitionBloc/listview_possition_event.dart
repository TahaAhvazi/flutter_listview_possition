part of 'listview_possition_bloc.dart';

abstract class ListviewPossitionEvent extends Equatable {
  const ListviewPossitionEvent();

  @override
  List<Object> get props => [];
}

class OnListViewPossitionDetectedEvent extends ListviewPossitionEvent {
  final bool isTop;

  OnListViewPossitionDetectedEvent(this.isTop);
  @override
  // TODO: implement props
  List<Object> get props => [isTop];
}
