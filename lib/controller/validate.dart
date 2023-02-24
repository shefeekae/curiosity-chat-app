import 'package:email_validator/email_validator.dart';

class Validate {
  //Email validation
  static validateEmail(value) {
    if (value != null && !EmailValidator.validate(value)) {
      return "Enter a valid email";
    }
  }

  //Password Validation
  static validatePassword(value) {
    if (value.length < 6) {
      return "Password should contain atleast 6 characters";
    }
  }

  //Name validation
  static validateName(value) {
    if (value.isEmpty) {
      return "This field cannot be empty";
    }
  }
}
