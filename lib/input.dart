import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final bool campoSenha;
  final TextInputAction textInputAction;
  final String dica;
  CustomInput(
      {this.dica,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.campoSenha});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = campoSenha ?? false;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: dica ?? "Dica",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            )),
      ),
    );
  }
}
