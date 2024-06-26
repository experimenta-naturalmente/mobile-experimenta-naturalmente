import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/screens/login.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/screens/experience_screen.dart';
import 'package:turismo_rural_frontend/features/home/presentation/screens/home.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_bloc.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_event.dart';
import 'package:turismo_rural_frontend/features/routes/presentation/screens/route_screen.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_handler.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<AppPage> tabs = [
    AppPage.home,
    AppPage.experiences,
    AppPage.routes,
    AppPage.login,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          await navigatorReturn(context);
        }
      },
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _getAppBar(context, state.currentPage),
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                context
                    .read<NavigationCubit>()
                    .navigateTo(appPage: tabs[index]);
              },
              selectedIndex: getTabIndex(state.currentPage),
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.hotel_class),
                  icon: Icon(Icons.hotel_class_outlined),
                  label: 'Experiências',
                ),
                NavigationDestination(
                  selectedIcon: Icon(FontAwesome5.map_marked),
                  icon: Icon(FontAwesome5.map_marked_alt),
                  label: 'Rotas',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.person),
                  icon: Icon(Icons.person_outline),
                  label: 'Perfil',
                ),
              ],
            ),
            body: _getPage(state.currentPage, context),
          );
        },
      ),
    );
  }

  int getTabIndex(AppPage page) {
    if (page == AppPage.register) {
      return tabs.indexOf(AppPage.login);
    }
    return tabs.indexOf(page);
  }

  Widget _getPage(AppPage currentPage, BuildContext context) {
    switch (currentPage) {
      case AppPage.home:
        return const HomeScreen();
      case AppPage.experiences:
        final item = context.read<NavigationCubit>().state.selectedItem;
        if (item != null) {
          if (item is Experience) {
            context.read<ExperienceBloc>().add(ExperienceSelected(item));
          } else if (item is int) {
            context.read<ExperienceBloc>().add(LoadExperienceDetails(item));
          }
        } else {
          context.read<ExperienceBloc>().add(LoadExperienceCategories());
        }
        return const ExperiencesScreen();
      case AppPage.login:
        return const LoginScreen();
      case AppPage.register:
        return const SignUpHandler();
      case AppPage.routes:
        final item = context.read<NavigationCubit>().state.selectedItem;
        if (item != null && item is TouristicRoute) {
          context.read<RouteBloc>().add(RouteSelected(item));
        } else {
          context.read<RouteBloc>().add(LoadRouteList());
        }
        return const RouteScreen();
      default:
        return Container();
    }
  }

  Future<bool> navigatorReturn(BuildContext context) async {
    final currPage = context.read<NavigationCubit>().state.currentPage;
    final prevItem = context.read<NavigationCubit>().state.previousItem;
    if (currPage == AppPage.home) {
      return true;
    } else if (currPage == AppPage.register) {
      final bool onInitial =
          context.read<SignUpBloc>().state is SignUpPageInitialState;
      if (onInitial) {
        context.read<NavigationCubit>().navigateTo(appPage: AppPage.home);
      } else {
        context.read<SignUpBloc>().add(const SignUpChangePage(previous: true));
      }
      return false;
    }
    if (currPage == AppPage.experiences) {
      final selectedExperience =
          context.read<NavigationCubit>().state.selectedItem;
      final previousPage = context.read<NavigationCubit>().state.previousPage;
      if (selectedExperience != null && previousPage != null) {
        context
            .read<NavigationCubit>()
            .navigateTo(appPage: previousPage, item: prevItem);
        return false;
      }
    }
    if (currPage == AppPage.routes) {
      final selectedRoute = context.read<NavigationCubit>().state.selectedItem;
      final previousPage = context.read<NavigationCubit>().state.previousPage;
      if (selectedRoute != null && previousPage != null) {
        context
            .read<NavigationCubit>()
            .navigateTo(appPage: previousPage, item: prevItem);
        return false;
      }
    }
    context.read<NavigationCubit>().navigateTo(appPage: AppPage.home);
    return false;
  }

  PreferredSizeWidget? _getAppBar(BuildContext context, AppPage currPage) {
    if (currPage == AppPage.home) {
      return null;
    }
    return AppBar(
      centerTitle: true,
      title: GradientText(
        text: _getAppBarTitle(currPage),
      ),
      leading: currPage == AppPage.home
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigatorReturn(context);
              },
            ),
    );
  }

  String _getAppBarTitle(AppPage currPage) {
    switch (currPage) {
      case AppPage.home:
        return 'Home';
      case AppPage.experiences:
        return 'Experiências';
      case AppPage.maps:
        return 'Mapa';
      case AppPage.login:
        return 'Perfil';
      case AppPage.register:
        return 'Cadastro';
      case AppPage.routes:
        return 'Rotas';
      default:
        return '';
    }
  }
}
