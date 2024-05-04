import 'package:equatable/equatable.dart';

abstract class SpotsEvent extends Equatable {
  const SpotsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSpotsCategories extends SpotsEvent {}

class FetchExperiences extends SpotsEvent {}
