import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';
import 'package:untitled1/bloc/scan_document_bloc/scan_document_bloc.dart';
import 'package:untitled1/ui/screens/dialog/components/parameters.dart';

class Parameter extends StatelessWidget {
  const Parameter(
      {super.key, required this.parametersEnum, required this.value});

  final ParametersEnum parametersEnum;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(parametersEnum.name),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Slider(
              value: value,
              max: 255,
              min: 0,
              divisions: 255,
              onChanged: (value) {
                BlocProvider.of<ScanDocumentBloc>(context).add(ChangeParameterValue(
                    parametersEnum: parametersEnum, value: value));
              }),
        ),
      ],
    );
  }
}
