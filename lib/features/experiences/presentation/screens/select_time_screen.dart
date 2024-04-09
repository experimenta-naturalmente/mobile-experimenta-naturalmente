import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/alarm_time_picker.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/color_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/color_event.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_time_selection_screen.dart';

class SelectTimeScreen extends StatefulWidget {
  final String text;

  const SelectTimeScreen({super.key, required this.text});

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreen();
}

class _SelectTimeScreen extends State<SelectTimeScreen> {
  String fontName = 'JosefinSans';
  Color startGradient = const Color(0xFF56633C);
  Color finishGradient = const Color(0xFFB0D182);
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 00);
  TimeOfDay endTime = const TimeOfDay(hour: 20, minute: 00);

  bool isTimeOfDayLater(TimeOfDay t1, TimeOfDay t2) {
    final t1InMinutes = t1.hour * 60 + t1.minute;
    final t2InMinutes = t2.hour * 60 + t2.minute;

    return t1InMinutes >= t2InMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const TimeTableScreen(),
              ),
            );
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const GradientText(text: 'Cadastro'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Selecione o horário de abertura:',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF3A502C),
                    ),
                  ),
                ),
                AlarmTimePicker(
                  initialTime: startTime,
                  onTimeSelected: (selectedTime) {
                    setState(() {
                      startTime = selectedTime;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Text(
                    'Selecione o horário de fechamento:',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF3A502C),
                    ),
                  ),
                ),
                AlarmTimePicker(
                  initialTime: endTime,
                  onTimeSelected: (selectedTime) {
                    setState(() {
                      endTime = selectedTime;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200),
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
                        if (isTimeOfDayLater(startTime, endTime)) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Erro'),
                              content: const Text(
                                'O horário de fechamento tem de ser depois do horário de abertura.',
                              ),
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
                          setState(() {
                            context
                                .read<ColorBloc>()
                                .add(ChangeColor(widget.text, finishGradient));
                          });

                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TimeTableScreen(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Confirmar',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
