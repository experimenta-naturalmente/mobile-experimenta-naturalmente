import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

class NavigationCubit<T> extends Cubit<NavigationState<T>> {
  NavigationCubit() : super(NavigationState<T>(currentPage: AppPage.home));

  void navigateTo({required AppPage appPage, T? item}) {
    emit(
      NavigationState<T>(
        currentPage: appPage,
        selectedItem: item,
        previousPage: state.currentPage,
      ),
    );
  }
}

class NavigationState<T> {
  final AppPage currentPage;
  final AppPage? previousPage;
  final T? selectedItem;

  NavigationState({
    required this.currentPage,
    this.selectedItem,
    this.previousPage,
  });
}
