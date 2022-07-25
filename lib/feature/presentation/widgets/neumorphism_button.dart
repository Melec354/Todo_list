import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../bloc/settings_cubit/settings_cubit.dart';
import '../bloc/view_cubit/view_cubit.dart';

class NeumorphismButton extends StatefulWidget {
  const NeumorphismButton({Key? key}) : super(key: key);

  @override
  State<NeumorphismButton> createState() => _NeumorphismButton();
}

class _NeumorphismButton extends State<NeumorphismButton> {
  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    isPressed = context.watch<ViewCubit>().state;
    final stateTheme = context.watch<SettingsCubit>().state;
    bool isDarkTheme = false;
    if (stateTheme is ThemeChanged) {
      isDarkTheme = stateTheme.isDarkTheme;
    } else if (stateTheme is ThemeRetrieved) {
      isDarkTheme = stateTheme.isDarkTheme;
    }
    Offset distanse = isPressed ? Offset(3, 3) : Offset(14, 14);
    double blur = isPressed ? 5.0 : 30.0;
    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
          context.read<ViewCubit>().changeView(isPressed);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  offset: -distanse,
                  color: isDarkTheme ? const Color(0xFF35393F) : Colors.white,
                  blurRadius: blur,
                  inset: isPressed),
              BoxShadow(
                  offset: distanse,
                  color: isDarkTheme
                      ? const Color(0xFF23262A)
                      : const Color(0xFFA7A9AF),
                  blurRadius: blur,
                  inset: isPressed)
            ]),
        child: SizedBox(
          child: Icon(
            Icons.add,
            size: 50,
            color: isDarkTheme
                ? Colors.white
                : const Color.fromRGBO(87, 87, 103, 1),
          ),
        ),
      ),
    );
  }
}
