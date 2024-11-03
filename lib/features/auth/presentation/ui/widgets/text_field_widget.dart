import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum TextInputValidators {
  required,
  email,
  number,
  arIdNumber,
  arMobile,
  password,
  custom,
}

class TextFieldWidget extends StatefulWidget {
  final String? initialValue;
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputValidators> validators;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value, String? error)? onChange;
  final String? Function(String? value)? customValidator;

  TextFieldWidget({
    super.key,
    this.initialValue,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validators = const [],
    this.customValidator,
    this.inputFormatters,
    this.onChange,
  }) : assert(
          !(validators.contains(TextInputValidators.custom) &&
              customValidator == null),
          'customValidator cannot be null if validators contains TextInputValidators.custom',
        );

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  String? error;

  @override
  initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: _onChange,
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
            controller: controller,
            obscureText:
                widget.validators.contains(TextInputValidators.password),
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              labelText: widget.labelText,
            ),
          ),
          if (error case final error?)
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 4),
              child: Text(
                error,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            )
        ],
      );

  _onChange(String value) {
    if (widget.validators.isEmpty) return;
    error = [
      for (final validator in widget.validators)
        error = switch (validator) {
          TextInputValidators.required =>
            value.isEmpty ? 'Campo requerido' : null,
          TextInputValidators.email => value.isNotEmpty &&
                  !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)
              ? 'Email invalido'
              : null,
          TextInputValidators.number =>
            value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)
                ? 'Invalid number'
                : null,
          TextInputValidators.arIdNumber => !value.isNotEmpty
              ? null
              : value.length != 10
                  ? 'DNI debe tener 8 digitos'
                  : !RegExp(r'^\d{2}\.\d{3}\.\d{3}$').hasMatch(value)
                      ? 'DNI invalido'
                      : null,
          TextInputValidators.arMobile => !value.isNotEmpty
              ? null
              : value.length < 10 || value.length > 13
                  ? 'Celular debe tener entre 10 y 13 digitos'
                  : !RegExp(r'^\d{2,4}\d{6,9}$').hasMatch(value)
                      ? 'Celular invalido'
                      : null,
          TextInputValidators.password => value.isNotEmpty
              ? value.length < 8
                  ? 'Minimo 8 caracteres'

                  // una maxuscula, minuscula y un numero
                  : !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$')
                          .hasMatch(value)
                      ? 'Al menos una mayuscula, minuscula y un numero'
                      : null
              : null,
          TextInputValidators.custom => widget.customValidator?.call(value)
        }
    ].where((e) => e != null).join(', ');

    if (error?.isEmpty ?? false) error = null;

    widget.onChange?.call(value, error);

    setState(() {});
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final formatter = NumberFormat.decimalPattern('es_AR');
    final inputValue =
        double.parse(newValue.text.replaceAll(RegExp(r'[^0-9]'), ''));
    final formattedValue = formatter.format(inputValue);

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
