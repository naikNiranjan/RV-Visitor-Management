import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PasswordField extends HookWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  
  const PasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    this.errorText,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(false);
    final isFocused = useState(false);
    final focusNode = useFocusNode();

    useEffect(() {
      focusNode.addListener(() {
        isFocused.value = focusNode.hasFocus;
      });
      return null;
    }, [focusNode]);

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: isFocused.value ? IconButton(
          icon: Icon(
            isPasswordVisible.value 
                ? Icons.visibility_off 
                : Icons.visibility,
          ),
          onPressed: () => isPasswordVisible.value = !isPasswordVisible.value,
        ) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        errorText: errorText,
      ),
      obscureText: !isPasswordVisible.value,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
} 