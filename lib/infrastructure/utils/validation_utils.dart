class ValidationUtils {
  String? mobileNumberValidation(String? number) {
    if (number == null || number.isEmpty) {
      return "Enter mobile number";
    }
    return null;
  }
}