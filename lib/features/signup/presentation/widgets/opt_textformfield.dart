import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OtpBoxFields extends StatefulWidget {
  final void Function(String) onCompleted;

  const OtpBoxFields({super.key, required this.onCompleted});

  @override
  State<OtpBoxFields> createState() => _OtpBoxFieldsState();
}

class _OtpBoxFieldsState extends State<OtpBoxFields> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    String otp = _controllers.map((c) => c.text).join();
    if (otp.length == 6) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 60,
          height: 54,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: TextStyle(color: AppColors.grey, fontSize: 18),
            obscureText: true,
            obscuringCharacter: '*',
            cursorColor: AppColors.lightGrey,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterText: '',
              filled: true,

              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => _onChanged(value, index),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
