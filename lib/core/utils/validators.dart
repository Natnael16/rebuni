import 'package:intl_phone_field/phone_number.dart';

String? validatePhoneNumber(PhoneNumber? value) {
  if (value == null) {
    return 'Phone number is required';
  }

  // Remove any non-digit characters
  final cleanedNumber = value.number.replaceAll(RegExp(r'\D'), '');

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

String? validateTitle(String? value) {
  if (value == null || value.isEmpty || value.length < 5) {
    return 'Title must be at least 5 characters';
  }

  return null; // Return null if the input is valid
}

String? validateDescription(String? value) {
  if (value == null || value.isEmpty || value.length < 10) {
    return 'Description must be at least 10 characters';
  }

  return null; // Return null if the input is valid
}

String? validateCategory(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select at least one category';
  }

  return null; // Return null if the input is valid
}
