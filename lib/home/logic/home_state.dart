import 'package:task/model/home_header_model.dart';
import 'package:task/model/salon_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Salon>? salons;
  HomeHeaderModel? header;
  final bool? hasReachedMax;
  HomeSuccess({
    this.header,
    this.salons,
    this.hasReachedMax,
  });

  HomeSuccess copyWith({
    List<Salon>? salons,
    bool? hasReachedMax,
  }) {
    return HomeSuccess(
      salons: salons ?? this.salons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  List<Object?> get props => [salons, hasReachedMax];

  @override
  String toString() =>
      'salons: ${salons?.length}, hasReachedMax: $hasReachedMax ';
}

class AuthenticationError extends HomeState {}

class Error extends HomeState {}
