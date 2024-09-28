import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';

enum Presets {
  preset1,
  preset2,
  preset3,
  preset4,
  preset5,
  preset6,
}

class PresetWidget extends StatelessWidget {
  const PresetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainBloc, MainState, Presets>(
      selector: (state) {
        return state.presets;
      },
      builder: (context, presets) {
        return DropdownButton(
            value: presets,
            items: Presets.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList(),
            onChanged: (e) {
              if (e != null) {
                BlocProvider.of<MainBloc>(context)
                    .add(ChangePreset(presets: e));
              }
            });
      },
    );
  }
}
