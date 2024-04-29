import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';

class ShiftSelect extends StatefulWidget {
  final ValueNotifier<bool> checkboxNotifier;

  const ShiftSelect({super.key, required this.checkboxNotifier});

  @override
  _ShiftSelectState createState() => _ShiftSelectState();
}

class _ShiftSelectState extends State<ShiftSelect> {
  List<TimeRange> timeRanges = [
    TimeRange(
      startTime: const TimeOfDay(hour: 8, minute: 0),
      endTime: const TimeOfDay(hour: 20, minute: 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.checkboxNotifier.value = false;
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            'Lista de horários:',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const RangeMaintainingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...timeRanges.map(
                  (TimeRange timeRange) => ListTile(
                    title: Text(
                      '${timeRange.startTime.format(context)} - ${timeRange.endTime.format(context)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          timeRanges.remove(timeRange);
                        });
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Adicionar intervalo'),
                  onPressed: () async {
                    final newTimeRange = await showTimeRangePicker(
                      context: context,
                      fromText: 'De',
                      toText: 'Até',
                      strokeColor: Colors.green,
                      handlerColor: Colors.green[800],
                      selectedColor: Colors.green[900],
                      backgroundColor: Colors.green[200],
                      
                    );
                    if (newTimeRange != null) {
                      setState(() {
                        timeRanges.add(newTimeRange as TimeRange);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SubmitButton(
            text: 'Avançar',
            onPressed: () => {
              widget.checkboxNotifier.value = true,
              Navigator.of(context).pop(),
            },
          ),
        ),
      ],
    );
  }
}
