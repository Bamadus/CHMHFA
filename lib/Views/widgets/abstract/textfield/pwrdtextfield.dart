
import 'package:flutter/material.dart';

class Password extends StatefulWidget{
  final ValueChanged? onChanged;
  final TextEditingController? controller;
  bool obscureText;
  final bool enabled;
  bool isPasswordobscure;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? maxlength;
  final Function? onTap;
  final String? hintText;

  Password({
    super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.validator,
    this.onChanged,
    required this.enabled,
    required this.hintText,
    this.obscureText = true,
    this.isPasswordobscure = false,
    this.maxLines = 1,
    this.maxlength = 8,
    this.onTap,
});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password>{

  bool _uppercase = false;
  bool _lowercase = false;
  bool _spcharacter = false;
  bool _numb = false;
  bool _length = false;

  void _validatepsswrd(String psswrd){
    setState((){
      _uppercase = psswrd.contains(RegExp(r'[A-Z]'));
      _lowercase = psswrd.contains(RegExp(r'[a-z]'));
      _spcharacter = psswrd.contains(RegExp(r'[~!@#$%^&*(),.?":{}|<>]'));
      _numb = psswrd.contains(RegExp(r'[1234567890]'));
      _length = psswrd.length >= 8;
    });
  }

  Widget _psswrdRequirement(bool psswrd, String text) {
    return Row(
      children: [
        Icon(
          psswrd ? Icons.check_circle : Icons.cancel,
          color: psswrd ? Color.fromARGB(255, 113, 153, 233) : const Color.fromARGB(255, 10, 10, 10),
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }



  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          maxLength: 8,
          // this code below is to hide the label of the max length
          buildCounter: (
              BuildContext context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) => null,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
                width: 1,
                color: Color(0xff33415c),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
                width: 1,
                color: Color.fromARGB(255, 15, 43, 99),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Color(0xff33415c),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  !widget.obscureText ?
                  widget.obscureText = true
                      : widget.obscureText = false;
                });
              },
              icon:widget.obscureText
                  ? const Icon(Icons.visibility_off_outlined,)
                  : const Icon(Icons.visibility,),
          ),
        ),
          onChanged: _validatepsswrd,
          obscureText: widget.obscureText,
          validator: widget.validator,
        ),
        SizedBox(height: 8,),
        _psswrdRequirement(_length, "Password must be at least 8 characters"),
        _psswrdRequirement(_uppercase, "At least 1 Uppercase"),
        _psswrdRequirement(_lowercase, "At least 1 lowercase"),
        _psswrdRequirement(_spcharacter, "Add a special characters"),
        _psswrdRequirement(_numb, "At least one Number"),
        SizedBox(height: 25,),
      ],
    );
  }
}