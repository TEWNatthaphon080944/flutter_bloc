part of 'brand_bloc.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object?> get props => [];
}

class FetchDataEvent extends ApiEvent {}
