import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/widgets/shift_select.dart';

class SignUpPageWorkingHours extends StatefulWidget {
  final SignUpPageWorkingHoursState state;

  const SignUpPageWorkingHours({
    super.key,
    required this.state,
  });

  @override
  _SignUpPageWorkingHoursState createState() => _SignUpPageWorkingHoursState();
}

class _SignUpPageWorkingHoursState extends State<SignUpPageWorkingHours> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Funcionamento',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              padding: const EdgeInsets.only(bottom: 3),
              child: SizedBox(
                height: screenHeight * 0.5,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildWeekdayCheckbox(
                        _weekdayName(index),
                        _weekdayEnum(index),
                        context,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Theme.of(context).dividerColor);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _weekdayName(int index) {
    switch (index) {
      case 0:
        return 'Segunda-feira';
      case 1:
        return 'Terça-feira';
      case 2:
        return 'Quarta-feira';
      case 3:
        return 'Quinta-feira';
      case 4:
        return 'Sexta-feira';
      case 5:
        return 'Sábado';
      case 6:
        return 'Domingo';
      case 7:
        return 'Feriados';
      default:
        return '';
    }
  }

  WeekDay _weekdayEnum(int index) {
    switch (index) {
      case 0:
        return WeekDay.monday;
      case 1:
        return WeekDay.tuesday;
      case 2:
        return WeekDay.wednesday;
      case 3:
        return WeekDay.thursday;
      case 4:
        return WeekDay.friday;
      case 5:
        return WeekDay.saturday;
      case 6:
        return WeekDay.sunday;
      case 7:
        return WeekDay.holiday;
      default:
        return WeekDay.monday;
    }
  }

  Widget _buildWeekdayCheckbox(
    String text,
    WeekDay weekday,
    BuildContext context,
  ) {
    final workingHours = widget.state.workingHours;
    final checked = workingHours[weekday]?.isNotEmpty ?? false;
    return CheckboxListTile(
      title: Text(text, style: Theme.of(context).textTheme.bodyLarge),
      value: checked,
      onChanged: (bool? newValue) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Selecione o horário de funcionamento'),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
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
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
