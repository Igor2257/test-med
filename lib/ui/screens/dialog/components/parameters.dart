import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';
import 'package:untitled1/bloc/scan_document_bloc/scan_document_bloc.dart';
import 'package:untitled1/ui/screens/dialog/components/parameter.dart';
enum ParametersEnum {
  parameters1,
  parameters2,
  parameters3,
  parameters4,
}

class Parameters extends StatelessWidget {
  const Parameters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocSelector<ScanDocumentBloc, ScanDocumentState, double>(
          selector: (state) {
            return state.parameterValue1;
          },
          builder: (context, parameterValue1) {
            return Parameter(
              parametersEnum: ParametersEnum.parameters1,
              value: parameterValue1,
            );
          },
        ),
        BlocSelector<ScanDocumentBloc, ScanDocumentState, double>(
          selector: (state) {
            return state.parameterValue2;
          },
          builder: (context, parameterValue2) {
            return Parameter(
              parametersEnum: ParametersEnum.parameters2,
              value: parameterValue2,
            );
          },
        ),
        BlocSelector<ScanDocumentBloc, ScanDocumentState, double>(
          selector: (state) {
            return state.parameterValue3;
          },
          builder: (context, parameterValue3) {
            return Parameter(
              parametersEnum: ParametersEnum.parameters3,
              value: parameterValue3,
            );
          },
        ),
        BlocSelector<ScanDocumentBloc, ScanDocumentState, double>(
          selector: (state) {
            return state.parameterValue4;
          },
          builder: (context, parameterValue4) {
            return Parameter(
              parametersEnum: ParametersEnum.parameters4,
              value: parameterValue4,
            );
          },
        ),
      ],
    );
  }
}
