import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/screens/select_time_screen.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/color_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/color_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/color_state.dart';

class WeekTimeComponent extends StatefulWidget {
  final String text;
  const WeekTimeComponent({super.key, required this.text});

  @override
  State<WeekTimeComponent> createState() => _WeekTimeComponentState();
}

class _WeekTimeComponentState extends State<WeekTimeComponent> {
  String fontName = 'JosefinSans';
  Color uncheckedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.5, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: fontName,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10), // Espaçamento entre o texto e os ícones
          GestureDetector(
            onTap: () {
              final colorBloc = context.read<ColorBloc>();
              final currentColor = colorBloc.state.colorStatus[widget.text];

              if (currentColor != null &&
                  currentColor.value == const Color(0xFFB0D182).value) {
                // Se o botão já estiver ativo, desativa
                colorBloc.add(ChangeColor(widget.text, Colors.grey));
              } else {
                // Senão, chama a tela de seleção de horário
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectTimeScreen(text: widget.text),
                  ),
                );
              }
            },
            child: BlocBuilder<ColorBloc, ColorState>(
              builder: (context, state) {
                return Icon(
                  Icons.check_box,
                  color: state.colorStatus[widget.text] ?? uncheckedColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
