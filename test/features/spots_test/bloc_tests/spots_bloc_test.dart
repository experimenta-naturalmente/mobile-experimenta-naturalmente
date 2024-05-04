import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_bloc.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_event.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_state.dart';

class MockExperienceRepository extends Mock implements IExperienceRepository {}

void main() {
  group('SpotsBloc', () {
    late SpotsBloc spotsBloc;
    late MockExperienceRepository mockExperienceRepository;

    setUp(() {
      mockExperienceRepository = MockExperienceRepository();
      spotsBloc = SpotsBloc(experienceRepository: mockExperienceRepository);
    });

    test('initial state is SpotsFilterInitial', () {
      expect(spotsBloc.state, equals(SpotsFilterInitial()));
    });

    // Test props of SpotsEvent.
    test('LoadSpotsCategories get props should return empty list', () {
      final event = LoadSpotsCategories();
      expect(event.props, []);
    });

    // Test props of SpotsState.
    test('SpotsFilterInitial get props should return empty list', () {
      final state = SpotsFilterInitial();
      expect(state.props, []);
    });

    test('SpotsCategoriesLoading get props should return empty list', () {
      final state = SpotsCategoriesLoading();
      expect(state.props, []);
    });

    test('SpotsError get props should return list with error message', () {
      const state = SpotsError('error message');
      expect(state.props, ['error message']);
    });

    // Close the bloc after each test
    tearDown(() {
      spotsBloc.close();
    });
  });
}
