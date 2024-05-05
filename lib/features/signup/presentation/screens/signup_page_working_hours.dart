import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/widgets/shift_select.dart';

class SignUpPageWorkingHours extends StatelessWidget {
  const SignUpPageWorkingHours({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    final checkboxNotifier =
        (signUpBloc.state as SignUpPageWorkingHoursState).checkboxNotifier;

    const segundaFeira = SignUpPageWorkingHoursState.segundaFeira;
    const tercaFeira = SignUpPageWorkingHoursState.tercaFeira;
    const quartaFeira = SignUpPageWorkingHoursState.quartaFeira;
    const quintaFeira = SignUpPageWorkingHoursState.quintaFeira;
    const sextaFeira = SignUpPageWorkingHoursState.sextaFeira;
    const sabado = SignUpPageWorkingHoursState.sabado;
    const domingo = SignUpPageWorkingHoursState.domingo;
    const feriados = SignUpPageWorkingHoursState.feriados;

    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Funcionamento',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.only(bottom: 3),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxNotifier[segundaFeira]!,
                      builder: (context, value, child) {
                        return CheckboxListTile(
                          title: const Text(segundaFeira),
                          value: checkboxNotifier[segundaFeira]!.value,
                          onChanged: (bool? newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    width: 300,
                                    height: 600,
                                    child: ShiftSelect(
                                      checkboxNotifier:
                                          checkboxNotifier[segundaFeira]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxNotifier[tercaFeira]!,
                      builder: (context, value, child) {
                        return CheckboxListTile(
                          title: const Text(tercaFeira),
                          value: checkboxNotifier[tercaFeira]!.value,
                          onChanged: (bool? newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    width: 300,
                                    height: 600,
                                    child: ShiftSelect(
                                      checkboxNotifier:
                                          checkboxNotifier[tercaFeira]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxNotifier[quartaFeira]!,
                      builder: (context, value, child) {
                        return CheckboxListTile(
                          title: const Text(quartaFeira),
                          value: checkboxNotifier[quartaFeira]!.value,
                          onChanged: (bool? newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    width: 300,
                                    height: 600,
                                    child: ShiftSelect(
                                      checkboxNotifier:
                                          checkboxNotifier[quartaFeira]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxNotifier[quintaFeira]!,
                      builder: (context, value, child) {
                        return CheckboxListTile(
                          title: const Text(quintaFeira),
                          value: checkboxNotifier[quintaFeira]!.value,
                          onChanged: (bool? newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    width: 300,
                                    height: 600,
                                    child: ShiftSelect(
                                      checkboxNotifier:
                                          checkboxNotifier[quintaFeira]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxNotifier[sextaFeira]!,
                      builder: (context, value, child) {
                        return CheckboxListTile(
                          title: const Text(sextaFeira),
                          value: checkboxNotifier[sextaFeira]!.value,
                          onChanged: (bool? newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    width: 300,
                                    height: 600,
                                    child: ShiftSelect(
                                      checkboxNotifier:
                                          checkboxNotifier[sextaFeira]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxNotifier[sabado]!,
                      builder: (context, value, child) {
                        return CheckboxListTile(
                          title: const Text(sabado),
                          value: checkboxNotifier[sabado]!.value,
                          onChanged: (bool? newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    width: 300,
                                    height: 600,
                                    child: ShiftSelect(
                                      checkboxNotifier:
                                          checkboxNotifier[sabado]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxNotifier[domingo]!,
                      builder: (context, value, child) {
                        return CheckboxListTile(
                          title: const Text(domingo),
                          value: checkboxNotifier[domingo]!.value,
                          onChanged: (bool? newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    width: 300,
                                    height: 600,
                                    child: ShiftSelect(
                                      checkboxNotifier:
                                          checkboxNotifier[domingo]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxNotifier[feriados]!,
                      builder: (context, value, child) {
                        return CheckboxListTile(
                          title: const Text(feriados),
                          value: checkboxNotifier[feriados]!.value,
                          onChanged: (bool? newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    width: 300,
                                    height: 600,
                                    child: ShiftSelect(
                                      checkboxNotifier:
                                          checkboxNotifier[feriados]!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
