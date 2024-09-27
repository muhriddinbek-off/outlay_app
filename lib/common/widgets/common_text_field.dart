import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.errorText,
    this.onChanged,
    this.keyboardType,
    this.inputFormatter,
    this.enabled,
    this.suffix,
    this.mask,
    this.maxLength,
    this.enabledBorderColor,
    this.background,
    this.suffixPressed,
    this.moneyInput = false,
    this.upperCaseInput = false,
    this.autofocus = false,
    this.padding,
    this.initialValue,
    this.textInputAction,
    this.textInputFormatter,
    this.onTap,
    this.minLines,
    this.maxLines = 1,
    this.onFocusChange
  });

  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final bool? enabled;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final Color?enabledBorderColor;
  final Color? background;
  final String? mask;
  final int? maxLength;
  final VoidCallback? suffixPressed;
  final bool moneyInput;
  final bool upperCaseInput;
  final bool autofocus;
  final EdgeInsets? padding;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final int? minLines;
  final void Function(bool)?onFocusChange;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool passwordVisible = true;
  late MaskTextInputFormatter maskFormatter;

  @override
  void initState() {
    passwordVisible = widget.obscureText;
    super.initState();
    maskFormatter = MaskTextInputFormatter(
      mask: widget.mask,
      filter: {"#": RegExp(r'\d')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  void dispose() {
    maskFormatter.clear();
    widget.controller?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange:widget.onFocusChange,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        initialValue: widget.initialValue,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        controller: widget.controller,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        obscureText: passwordVisible,
        cursorColor: Colors.black,
        onChanged: widget.onChanged == null
            ? null
            : (phone) {
          final number = widget.moneyInput
              ? phone.replaceAll(' ', '')
              : maskFormatter.unmaskText(phone);
          widget.onChanged!(number);
        },
        inputFormatters: widget.inputFormatter ??
            [
              widget.moneyInput ? PriceInputFormatter() : maskFormatter,
            ],
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(

          filled: true,
          fillColor: widget.background ?? const Color(0xffFAFAFA),
          hintText: widget.hint,
          errorText: widget.errorText,
          contentPadding: widget.padding ??
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
          prefixIcon: widget.prefixIcon == null
              ? null
              : Align(
            widthFactor: 1,
            alignment: Alignment.center,
            child: widget.prefixIcon,
          ),
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xffC8C8C8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.enabledBorderColor ?? Colors.white,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF246BFD),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              passwordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () {
              setState(() => passwordVisible = !passwordVisible);
            },
          )
              : widget.suffix != null
              ? IconButton(
            icon: widget.suffix!,
            onPressed: widget.suffixPressed,
          )
              : null,
        ),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    String newText = newValue.text;

    newText = newText.replaceAll(RegExp(r'\D'), '');

    String formattedText = '';
    int len = newText.length;
    for (int i = len - 1; i >= 0; i--) {
      formattedText = newText[i] + formattedText;
      if ((len - i) % 3 == 0 && i != 0) {
        formattedText = ' $formattedText';
      }
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  final int? maxLength;

  UpperCaseTextFormatter({this.maxLength});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    if (maxLength != null && newValue.text.length > maxLength!) {
      return oldValue;
    }
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}