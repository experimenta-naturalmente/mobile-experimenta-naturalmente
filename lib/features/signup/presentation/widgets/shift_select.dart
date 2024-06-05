import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';

class ShiftSelect extends StatefulWidget {
  final WeekDay day;
  final List<(TimeOfDay, TimeOfDay)>? workingHours;

  const ShiftSelect({
    super.key,
    required this.day,
    this.workingHours,
  });

  @override
  _ShiftSelectState createState() => _ShiftSelectState();
}

class _ShiftSelectState extends State<ShiftSelect> {
  late List<TimeRange> timeRanges;

  @override
  void initState() {
    super.initState();
    if (widget.workingHours != null) {
      timeRanges = widget.workingHours!
          .map(
            (e) => TimeRange(
              startTime: e.$1,
              endTime: e.$2,
            ),
          )
          .toList();
    } else {
      timeRanges = [
        TimeRange(
          startTime: const TimeOfDay(hour: 8, minute: 0),
          endTime: const TimeOfDay(hour: 20, minute: 0),
        ),
      ];
      context.read<SignUpBloc>().add(
            SignUpChangeWorkingHours(
              day: widget.day,
              workingHours:
                  timeRanges.map((e) => (e.startTime, e.endTime)).toList(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            'Horário de funcionamento',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            child: const Text('Adicionar intervalo'),
            onPressed: () async {
              final newTimeRange = await showTimeRangePicker(
                interval: const Duration(minutes: 30),
                context: context,
                fromText: 'De',
                toText: 'Até',
                strokeColor: Theme.of(context).colorScheme.primary,
                handlerColor: Theme.of(context).colorScheme.primary,
                selectedColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              );
              if (newTimeRange != null) {
                setState(() {
                  timeRanges.add(newTimeRange as TimeRange);
                  final listTimeDay =
                      timeRanges.map((e) => (e.startTime, e.endTime)).toList();
                  context.read<SignUpBloc>().add(
                        SignUpChangeWorkingHours(
                          day: widget.day,
                          workingHours: listTimeDay,
                        ),
                      );
                });
              }
            },
          ),
        ),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.35,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: timeRanges.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${timeRanges[index].startTime.format(context)} - ${timeRanges[index].endTime.format(context)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          timeRanges.removeAt(index);
                        });
                        final listTimeDay = timeRanges
                            .map((e) => (e.startTime, e.endTime))
                            .toList();
                        context.read<SignUpBloc>().add(
                              SignUpChangeWorkingHours(
                                day: widget.day,
                                workingHours: listTimeDay,
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
