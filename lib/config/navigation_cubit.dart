import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(currentPage: AppPage.home));

  void navigateTo({required AppPage appPage, Experience? experience}) {
    emit(
      NavigationState(
        currentPage: appPage,
        selectedExperience: experience,
        previousPage: state.currentPage,
      ),
    );
  }
}

class NavigationState {
  final AppPage currentPage;
  final AppPage? previousPage;
  final Experience? selectedExperience;

  NavigationState({
    required this.currentPage,
    this.selectedExperience,
    this.previousPage,
  });
}
