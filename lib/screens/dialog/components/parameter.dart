import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';
import 'package:untitled1/screens/dialog/components/parameters.dart';

class Parameter extends StatelessWidget {
  const Parameter(
      {super.key, required this.parametersEnum, required this.value});

  final ParametersEnum parametersEnum;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(parametersEnum.name),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Slider(
              value: value,
              max: 255,
              min: 0,
              divisions: 255,
              onChanged: (value) {
                BlocProvider.of<MainBloc>(context).add(ChangeParameterValue(
                    parametersEnum: parametersEnum, value: value));
              }),
        ),
      ],
    );
  }
}
