import 'package:turismo_rural_frontend/core/data/interfaces/i_route_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';
import 'package:turismo_rural_frontend/core/data/models/route_item.dart';

class RouteRepository implements IRouteRepository {
  @override
  Future<TouristicRoute?> fetchRouteDetails(int routeId) async {
    // Simulando rota fictícia
    return TouristicRoute(
      routeId: routeId,
      name: 'Rota do Sol',
      description: 'Uma rota relaxante pelo campo',
      experienceList: [
        RouteItem(
          routeId: 2,
          experienceId: 1,
          title: 'Passeio de Barco',
          description: 'Passeio tranquilo pelo rio',
          order: 1,
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlSClr46EU-WJuFrcqqvyWr_oG3Ki5zstvQQ&s',
        ),
        RouteItem(
          routeId: 2,
          experienceId: 2,
          title: 'Caminhada na Mata',
          description: 'Caminhada ecológica na floresta',
          order: 2,
          image:
              'https://www.maripelomundo.com.br/wp-content/uploads/2021/04/viagem-em-grupo-gramado-canion-1.jpg',
        ),
      ],
    );
  }

  @override
  Future<Set<TouristicRoute>> fetchRoutes() async {
    // Simulando várias rotas
    return {
      TouristicRoute(
        routeId: 1,
        name: 'Rota das Montanhas',
        description: 'Escalada e aventura nas montanhas',
        experienceList: [
          RouteItem(
            routeId: 3,
            experienceId: 3,
            title: 'Escalada',
            description: 'Escalada em rocha',
            order: 3,
            image:
                'https://www.maripelomundo.com.br/wp-content/uploads/2021/08/SFP-Sao-Francisco-de-Paula-canion-aparados-da-serra-foto-site-turismo-rs-gov-br-870x578.jpg',
          ),
          RouteItem(
            routeId: 4,
            experienceId: 4,
            title: 'Trekking',
            description: 'Caminhada de alta dificuldade',
            order: 4,
            image:
                'https://www.passagenspromo.com.br/blog/wp-content/uploads/2021/09/Sao-Francisco-de-Paula-RS.jpg',
          ),
        ],
      ),
      TouristicRoute(
        routeId: 2,
        name: 'Rota do Lago',
        description: 'Passeio de barco e atividades aquáticas',
        experienceList: [
          RouteItem(
            routeId: 5,
            experienceId: 5,
            title: 'Pesca',
            description: 'Pesca no lago',
            order: 5,
            image:
                'https://s2.glbimg.com/RVgdmixaEN_wGb6DcqqtgkIvTC8=/620x465/s.glbimg.com/jo/g1/f/original/2014/01/17/passo_lha.jpg',
          ),
          RouteItem(
            routeId: 6,
            experienceId: 6,
            title: 'Natação',
            description: 'Nado livre nas águas do lago',
            order: 6,
            image:
                'https://www.passagenspromo.com.br/blog/wp-content/uploads/2021/09/Sao-Francisco-de-Paula-RS-lago-sao-bernardo.jpg',
          ),
        ],
      ),
    };
  }
}
