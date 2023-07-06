String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }

  // Remove any non-digit characters
  final cleanedNumber = value.replaceAll(RegExp(r'\D'), '');

  if (cleanedNumber.length < 10) {
    return 'Invalid phone number';
  }

  return null; // Return null if the phone number is valid
}

String? validateFullName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  }

  return null; // Return null if the input is valid
}
