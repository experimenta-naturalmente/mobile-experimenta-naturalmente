import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';

class SignUpPageDateRange extends StatelessWidget {
  const SignUpPageDateRange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Data do Evento',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SfDateRangePicker(
              monthFormat: 'MMMM',
              headerStyle: const DateRangePickerHeaderStyle(
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: Colors.transparent,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final dateRange = args.value as PickerDateRange? ??
                      PickerDateRange(DateTime.now(), DateTime.now());
                  final startDate = dateRange.startDate;
                  if (startDate != null) {
                    context.read<SignUpBloc>().registration.eventStart =
                        startDate;
                  }
                  final endDate = dateRange.endDate;
                  if (endDate != null) {
                    context.read<SignUpBloc>().registration.eventEnd = endDate;
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
