import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/week_time_component.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/color_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_tag_selection_screen.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreen();
}

class _TimeTableScreen extends State<TimeTableScreen> {
  String fontName = 'JosefinSans';
  Color startGradient = const Color(0xFF56633C);
  Color finishGradient = const Color(0xFFB0D182);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const GradientText(
                text: 'Cadastro',
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 160),
                child: Column(
                  children: [
                    // Subtítulo da tela
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Funcionamento:', // Texto antes dos itens
                        style: TextStyle(
                          fontFamily: fontName,
                          fontStyle: FontStyle.normal,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF3A502C),
                        ),
                      ),
                    ),
                    // Container com a lista de dias da semana
                    Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(maxWidth: 325),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.only(bottom: 3),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: const [
                          WeekTimeComponent(
                            text: 'Segunda-feira',
                          ),
                          WeekTimeComponent(
                            text: 'Terça-feira',
                          ),
                          WeekTimeComponent(
                            text: 'Quarta-feira',
                          ),
                          WeekTimeComponent(
                            text: 'Quinta-feira',
                          ),
                          WeekTimeComponent(
                            text: 'Sexta-feira',
                          ),
                          WeekTimeComponent(
                            text: 'Sábado',
                          ),
                          WeekTimeComponent(
                            text: 'Domingo',
                          ),
                          WeekTimeComponent(
                            text: 'Feriados',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 350,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(startGradient),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        final colorBloc = context.read<ColorBloc>();
                        final colorState = colorBloc.state;
                        final hasSelectedDay =
                            colorState.colorStatus.values.any(
                          (color) =>
                              color.value == const Color(0xFFB0D182).value,
                        );

                        if (!hasSelectedDay) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Erro'),
                              content: const Text('Selecione ao menos um dia.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TagSelectionScreen(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Avançar',
                        style: TextStyle(
                          fontFamily: fontName,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
