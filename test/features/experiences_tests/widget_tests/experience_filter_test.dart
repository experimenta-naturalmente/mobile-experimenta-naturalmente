import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/screens/experience_screen.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/view_models/experience_list_item.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_list_item_widget.dart';

class MockExperienceBloc extends MockBloc<ExperienceEvent, ExperienceState>
    implements ExperienceBloc {}

void main() {
  late MockExperienceBloc mockExperienceBloc;
  const ExperienceCategory mockCategory1 =
      ExperienceCategory(id: 1, name: 'Category 1');
  const ExperienceCategory mockCategory2 =
      ExperienceCategory(id: 2, name: 'Category 2');
  const ExperienceListItem mockExperienceListItem = ExperienceListItem(
    id: 1,
    name: 'Experience 1',
    description: 'Description 1',
    imageUrl: '',
    category: mockCategory1,
    timeDetails: [],
    socialNetworks: [],
    tags: {},
  );
  setUp(() {
    mockExperienceBloc = MockExperienceBloc();
  });

  void setupMockBloc(ExperienceState state) {
    whenListen(
      mockExperienceBloc,
      Stream.fromIterable([state]),
      initialState: state,
    );
  }

  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<ExperienceBloc>(
        create: (context) => mockExperienceBloc,
        child: Scaffold(
          body: child,
        ),
      ),
    );
  }

  testWidgets(
      'should display LoadingIndicator when experience categories are loading',
      (WidgetTester tester) async {
    setupMockBloc(ExperienceCategoriesLoading());
    await tester.pumpWidget(createTestableWidget(const ExperiencesScreen()));

    expect(find.byType(LoadingIndicator), findsOneWidget);
  });

  testWidgets(
      'should display LoadingIndicator when experiences are loading, correct category is selected',
      (WidgetTester tester) async {
    setupMockBloc(
      ExperienceListLoading(
        mockCategory2,
        {mockCategory1, mockCategory2},
      ),
    );
    await tester.pumpWidget(createTestableWidget(const ExperiencesScreen()));

    final finderSelectedCategory =
        find.widgetWithText(ChoiceChip, mockCategory2.name);
    final ChoiceChip selectedChip = tester.widget(finderSelectedCategory);

    expect(find.byType(LoadingIndicator), findsOneWidget);

    expect(finderSelectedCategory, findsOneWidget);
    expect(selectedChip.selected, isTrue);
  });

  testWidgets('should display ErrorHandler when state is ExperienceError',
      (WidgetTester tester) async {
    setupMockBloc(
      ExperienceListLoading(
        mockCategory2,
        {mockCategory1, mockCategory2},
      ),
    );
    setupMockBloc(const ExperienceError('Test Error'));
    await tester.pumpWidget(createTestableWidget(const ExperiencesScreen()));
    expect(find.byType(ErrorHandler), findsOneWidget);
  });

  testWidgets(
      'should display list of experiences when state is ExperienceListLoadSuccess',
      (WidgetTester tester) async {
    setupMockBloc(
      ExperienceListLoadSuccess(
        {mockExperienceListItem},
        mockCategory1,
        {mockCategory1, mockCategory2},
      ),
    );
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        createTestableWidget(const ExperiencesScreen()),
      ),
    );
    expect(
      find.byType(ExperienceListItemWidget),
      findsNWidgets(1),
    );
  });
}
