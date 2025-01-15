import 'package:email_validator/email_validator.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormWidget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? descriptionLabel;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  final void Function()? tapAction;
  final TextFieldType type;
  final bool disableLabel;
  final bool? isInitPhoneCode;
  final String? initialPhoneCode;
  final TextFieldBorderType borderType;
  final TextInputType? keyboardType;
  final bool isDisableForm;
  final String unitMeasurement;
  final bool isObscureText;
  final Widget? suffixIcon;

  const TextFormWidget(
      {super.key,
        required this.labelText,
        required this.hintText,
        required this.controller,
        required this.onChanged,
        required this.type,
        this.inputFormatters,
        this.validator,
        this.descriptionLabel,
        this.tapAction,
        this.disableLabel = false,
        this.isInitPhoneCode,
        this.borderType = TextFieldBorderType.outlined,
        this.keyboardType,
        this.isDisableForm = false,
        this.isObscureText = false,
        this.unitMeasurement = '',
        this.initialPhoneCode,
        this.suffixIcon});

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  void initState() {
    if (widget.type == TextFieldType.phone &&
        (widget.isInitPhoneCode == true || widget.initialPhoneCode != null)) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LeftAlignedColumn(
      children: [
        if (!widget.disableLabel)
          TextWidget.jakartaSansSemiBold(widget.labelText, size: 14, color: ColorWidget.primaryColor).bottomPadded(6),
        widget.descriptionLabel != null
            ? TextWidget.jakartaSansRegular(widget.descriptionLabel ?? '', size: 10)
            .bottomPadded(12)
            : const SizedBox().bottomPadded(6),
        TextFormField(
          readOnly: widget.type == TextFieldType.date ||
              widget.type == TextFieldType.options ||
              widget.type == TextFieldType.time ||
              widget.isDisableForm
              ? true
              : false,
          onTap: widget.tapAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.words,
          onChanged: widget.onChanged,
          controller: widget.controller,
          maxLength: widget.type == TextFieldType.ktp ? 16 : null,
          validator: widget.validator ??
                  (value) {
                switch (widget.type) {
                  case TextFieldType.email:
                    if (!EmailValidator.validate(value ?? '')) {
                      return "Email tidak valid!";
                    } else {
                      return null;
                    }
                  default:
                    return null;
                }
              },
          inputFormatters: widget.inputFormatters,
          obscureText: widget.isObscureText,
          keyboardType: widget.keyboardType ??
              (widget.type == TextFieldType.phone ||
                  widget.type == TextFieldType.number ||
                  widget.type == TextFieldType.ktp
                  ? TextInputType.number
                  : (widget.type == TextFieldType.multiline)
                  ? TextInputType.multiline
                  : TextInputType.text),
          maxLines: (widget.type == TextFieldType.multiline)
              ? 5
              : (widget.isObscureText)
              ? 1
              : null,
          decoration: InputDecoration(
            border: _border(),
            filled: widget.borderType == TextFieldBorderType.filled,
            fillColor: widget.borderType == TextFieldBorderType.filled
                ? Colors.grey.withOpacity(0.1)
                : null,
            contentPadding: widget.borderType == TextFieldBorderType.filled
                ? const EdgeInsets.fromLTRB(20, 14, 20, 14)
                : const EdgeInsets.all(14),
            focusColor: ColorWidget.secondaryColor,
            focusedBorder: _border(),
            isDense: true,
            disabledBorder: _border(),
            hintText: widget.hintText,
            errorStyle: GoogleFonts.manrope(
                fontSize: 12,
                color: ColorWidget.redColor,
                fontWeight: FontWeight.w400),
            prefixIcon: null,
            suffixIcon: widget.type == TextFieldType.date
                ? const Icon(Icons.calendar_month_outlined)
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }

  InputBorder _border() {
    switch (widget.borderType) {
      case TextFieldBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(width: 0, color: ColorWidget.secondaryColor),
        );
      default:
        return const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: ColorWidget.secondaryColor),
        );
    }
  }
}
