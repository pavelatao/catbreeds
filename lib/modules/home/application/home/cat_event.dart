part of 'cat_bloc.dart';

abstract class CatEvent extends Equatable {
  const CatEvent();
}

class CatFetchRequested extends CatEvent {
  final String? breedId;
  const CatFetchRequested({this.breedId});

  @override
  List<Object?> get props => [breedId];
}

class CatResetRequested extends CatEvent {
  const CatResetRequested();
  @override
  List<Object?> get props => [];
}
