import 'package:equatable/equatable.dart';

/// Basic map event.
abstract class BaseMapEvent extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constructor.
  const BaseMapEvent();
}


/// map get current location event.
class MapGetLocationEvent extends BaseMapEvent {}
