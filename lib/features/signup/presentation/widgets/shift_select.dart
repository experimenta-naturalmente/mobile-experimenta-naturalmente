import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/widgets/alarm_time_picker.dart';

class ShiftSelect extends StatelessWidget {
  const ShiftSelect({super.key});

  TimeOfDay get startTime => const TimeOfDay(hour: 10, minute: 00);
  TimeOfDay get endTime => const TimeOfDay(hour: 20, minute: 00);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                'Selecione o horário de abertura:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            AlarmTimePicker(
              initialTime: startTime,
              onTimeSelected: (selectedTime) {},
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text(
                'Selecione o horário de fechamento:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            AlarmTimePicker(
              initialTime: endTime,
              onTimeSelected: (selectedTime) {},
            ),
          ],
        ),
      ),
    );
  }

  bool isTimeOfDayLater(TimeOfDay t1, TimeOfDay t2) {
    final t1InMinutes = t1.hour * 60 + t1.minute;
    final t2InMinutes = t2.hour * 60 + t2.minute;

    return t1InMinutes >= t2InMinutes;
  }
}
