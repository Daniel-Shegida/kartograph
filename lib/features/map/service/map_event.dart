import 'package:equatable/equatable.dart';

/// Basic map event.
abstract class BaseMapEvent extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constructor.
  const BaseMapEvent();
}


/// map load event.
class MapLoadEvent extends BaseMapEvent {}
