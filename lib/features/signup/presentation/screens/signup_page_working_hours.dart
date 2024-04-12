import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/widgets/week_time_component.dart';

class SignUpPageWorkingHours extends StatelessWidget {
  const SignUpPageWorkingHours({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // substituir isso por surface color, container color ou coisa do tipo, em colorScheme.
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.only(bottom: 3),
                // ListView é componente pra carregar lista dinâmica lazily e com scroll.
                // Essa lista nao tem necessidade de nenhum dos dois. Substituir por Column
                child: const Column(
                  children: [
                    // "WeekTimeComponent" não precisa existir. Ver: https://m3.material.io/components/checkbox/overview
                    //  tudo é só uma checkbox com um texto, nao justifica uma widget pra isso
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
      ),
    );
  }
}
