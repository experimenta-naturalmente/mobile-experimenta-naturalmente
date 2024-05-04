import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turismo_rural_frontend/core/data/repositories/experience_repository.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_bloc.dart';
import 'package:turismo_rural_frontend/features/spots/presentation/widgets/spots_list.dart';

void main() {
  testWidgets('SpotsList builds correctly with data',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SpotsBloc>(
          create: (context) =>
              SpotsBloc(experienceRepository: ExperienceRepository()),
          child: const SpotsList(),
        ),
      ),
    );

    expect(find.text('Serviços'), findsOneWidget);
  });
}
