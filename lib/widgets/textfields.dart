part of 'widgets.dart';

TextFormField passwordField({
  String? labelText,
  bool? obscureText,
  Function(String)? validator,
  TextEditingController? controller,
  required BuildContext context,
}) {
  return TextFormField(
    decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Password',
        prefixIcon: const Icon(Icons.password),
        suffixIcon: InkWell(
            onTap: () {
              context.read<AuthBloc>().add(AuthCallEvent(isObsecure: true));
            },
            child: Icon(obscureText == null || false
                ? Icons.visibility
                : Icons.visibility_off))),
    autocorrect: true,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: obscureText ?? true,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      } else if (value.length < 6) {
        return 'Password must be at least 6 characters';
      } else if (value.length > 15) {
        return 'Password must be less than 15 characters';
      }
      return null;
    },
  );
}

TextFormField commonTextField(
    {String? labelText,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    Function(String)? validator,
    TextEditingController? controller}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(prefixIcon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    controller: controller,
    autocorrect: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      validator!(value!);
      return null;
    },
  );
}
