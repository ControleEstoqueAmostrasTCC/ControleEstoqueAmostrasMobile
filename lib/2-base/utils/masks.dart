import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final date = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp('[0-9]')},
);
