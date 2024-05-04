import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/widgets/shift_select.dart';

class SignUpPageWorkingHours extends StatelessWidget {
  final SignUpPageWorkingHoursState state;

  const SignUpPageWorkingHours({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Funcionamento',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.only(bottom: 3),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 6.0,
                  child: ListView(
                    children: [
                      _buildWeekdayCheckbox(
                        'Segunda-feira',
                        WeekDay.monday,
                        context,
                      ),
                      _buildWeekdayCheckbox(
                        'Terça-feira',
                        WeekDay.tuesday,
                        context,
                      ),
                      _buildWeekdayCheckbox(
                        'Quarta-feira',
                        WeekDay.wednesday,
                        context,
                      ),
                      _buildWeekdayCheckbox(
                        'Quinta-feira',
                        WeekDay.thursday,
                        context,
                      ),
                      _buildWeekdayCheckbox(
                        'Sexta-feira',
                        WeekDay.friday,
                        context,
                      ),
                      _buildWeekdayCheckbox(
                        'Sábado',
                        WeekDay.saturday,
                        context,
                      ),
                      _buildWeekdayCheckbox(
                        'Domingo',
                        WeekDay.sunday,
                        context,
                      ),
                      _buildWeekdayCheckbox(
                        'Feriados',
                        WeekDay.holiday,
                        context,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekdayCheckbox(
    String text,
    WeekDay weekday,
    BuildContext context,
  ) {
    final workingHours = state.workingHours;
    final checked = workingHours[weekday]?.isNotEmpty ?? false;
    return CheckboxListTile(
      title: Text(text),
      value: checked,
      onChanged: (bool? newValue) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                child: ShiftSelect(
                  day: weekday,
                  workingHours: workingHours[weekday],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.done),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
