import 'package:flutter/material.dart';

class text_field{
  
  static Widget plainTextFormField({
    TextEditingController? controller,
    String? hintText,
    String? type,
    TextInputType textInputType = TextInputType.text,
    FormFieldValidator<String>? validator,
    int maxline = 1,
    int? maxlength,
    bool enable = true,
    Function? onTap,
  }){
    return TextFormField(
      controller: controller,
      onChanged: (v){
        controller!.text = v.replaceAll(',', '');
        controller.selection = TextSelection.collapsed(offset: v.length);
      },
      keyboardType: textInputType,
      maxLength: maxlength,
      enabled: enable,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        counterText: "",
      ),
      style: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.cyan,
      ),
      validator: validator,
    );
  }

  static Widget userTextField({
    TextEditingController? controller,
    String? errorText="Invalid input",
    String? labelText,
    TextInputType textInputType = TextInputType.text,
    int maxLines = 1,
    int? maxLength,
    bool enable = true,
    required TextInputType keyboardType,
    required String? Function(dynamic v) validator,
  }){
    return TextField(
      // errorText: errorText,
      controller: controller,
      onChanged: (v){
        controller!.text = v.replaceAll(',', '');
        controller.selection = TextSelection.collapsed(offset: v.length);
      },
      keyboardType: textInputType,
      maxLength: maxLength,
      enabled: enable,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 19,
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: Colors.cyan
          )
          ),
          errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: Colors.red)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xff33415c),
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xff33415c),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                )
            )
        )
      );
      }
  
  static Widget apppassword({
    final TextEditingController? controller,
    final String? hintText = "********",
    final obscureText,
    final ValueChanged? onChanged,
    final int? maxLine,
    final Function? onTap,
    FormFieldValidator<String>? validator,
  }){
    return TextFormField(
      controller: controller,
      obscureText: true,
      maxLines: 1,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color:Color.fromARGB(255, 97, 144, 238)
          )
          ),
          errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: Colors.red)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 109, 40, 40),
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xff33415c),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                )
            )
        )
    );
  }
}

class AppPassword extends StatefulWidget {
  final ValueChanged? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  bool obscureText;
  bool enabled;
  bool isPasswordobscure;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final int? maxlen;
  final int? maxLines;
  final Function? onTap;

  AppPassword(
      {super.key,
        required this.controller,
        required this.hintText,
        this.textInputType = TextInputType.text,
        this.validator,
        this.onChanged,
        required this.enabled,
        this.obscureText = true,
        this.isPasswordobscure = false,
        this.maxlen,
        this.maxLines = 1,
        this.onTap});

  @override
  State<AppPassword> createState() => _AppPasswordState();
}

class _AppPasswordState extends State<AppPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLength: widget.maxlen,
      enabled: widget.enabled,
      // this build context is used to hide the label
      buildCounter: (
              BuildContext context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) => null,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400,),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
                style: BorderStyle.solid, width: 1, color: Color.fromARGB(255, 15, 43, 99))),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            )),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                !widget.obscureText
                    ? widget.obscureText = true
                    : widget.obscureText = false;
              });
            },
            icon: widget.isPasswordobscure
                ? Container(
              width: 2,
            )
                : widget.obscureText
                ? const Icon(Icons.visibility_off_outlined)
                : const Icon(Icons.visibility)),
      ),
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      validator: widget.validator,
    );
  }
}

class UserField extends StatefulWidget {
  final ValueChanged? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final bool enabled;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final Function? onTap;

  const UserField(
      {super.key,
        required this.controller,
        required this.hintText,
        this.textInputType = TextInputType.text,
        this.validator,
        this.onChanged,
        required this.enabled,
        this.maxLines = 1,
        this.onTap});

  @override
  State<UserField> createState() => _UserFieldState();
}

class _UserFieldState extends State<UserField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400,),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
                style: BorderStyle.solid, width: 1, color: Color.fromARGB(255, 15, 43, 99))),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            )),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}