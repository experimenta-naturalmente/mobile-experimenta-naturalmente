import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_list_item.dart';

class MockExperienceRepository extends Mock implements IExperienceRepository {}

void main() {
  late MockExperienceRepository mockExperienceRepository;
  late ExperienceBloc experienceBloc;
  const ExperienceCategory mockCategory1 =
      ExperienceCategory(id: 1, name: 'Category 1');
  const ExperienceCategory mockCategory2 =
      ExperienceCategory(id: 2, name: 'Category 2');
  const ExperienceListItem mockExperienceListItem = ExperienceListItem(
    id: 1,
    name: 'Experience 1',
    description: 'Description 1',
    imageUrl: 'https://picsum.photos/300/400?random=1',
  );
  const ExperienceListItem mockExperienceListItem2 = ExperienceListItem(
    id: 2,
    name: 'Experience 2',
    description: 'Description 2',
    imageUrl: 'https://picsum.photos/300/400?random=1',
  );

  setUp(() {
    mockExperienceRepository = MockExperienceRepository();
    registerFallbackValue(const ExperienceCategory(id: 1, name: 'Category 1'));

    when(() => mockExperienceRepository.fetchExperienceCategories()).thenAnswer(
      (_) async => {mockCategory1, mockCategory2},
    );

    when(
      () =>
          mockExperienceRepository.fetchExperiencesfromCategory(mockCategory1),
    ).thenAnswer(
      (_) async => {mockExperienceListItem},
    );

    when(
      () =>
          mockExperienceRepository.fetchExperiencesfromCategory(mockCategory2),
    ).thenAnswer(
      (_) async => {mockExperienceListItem2},
    );
  });

  tearDown(() {
    experienceBloc.close();
  });

  blocTest<ExperienceBloc, ExperienceState>(
    'emits [ExperienceCategoriesLoading, ExperienceListLoadSuccess] when LoadExperienceCategories is added',
    build: () => experienceBloc =
        ExperienceBloc(experienceRepository: mockExperienceRepository),
    act: (bloc) => bloc.add(LoadExperienceCategories()),
    expect: () => [
      ExperienceCategoriesLoading(),
      ExperienceListLoading(
        mockCategory1,
        {mockCategory1, mockCategory2},
      ),
      ExperienceListLoadSuccess(
        {mockExperienceListItem},
        mockCategory1,
        {mockCategory1, mockCategory2},
      ),
    ],
  );
  blocTest<ExperienceBloc, ExperienceState>(
    'emits [ExperienceListLoading, ExperienceListLoadSuccess] on ExperienceCategoryChanged',
    build: () => experienceBloc =
        ExperienceBloc(experienceRepository: mockExperienceRepository),
    act: (bloc) => bloc.add(
      ExperienceCategoryChanged(
        mockCategory2,
        {
          mockCategory1,
          mockCategory2,
        },
      ),
    ),
    expect: () => [
      ExperienceListLoading(
        mockCategory2,
        {mockCategory1, mockCategory2},
      ),
      ExperienceListLoadSuccess(
        {mockExperienceListItem2},
        mockCategory2,
        {mockCategory1, mockCategory2},
      ),
    ],
  );
}
