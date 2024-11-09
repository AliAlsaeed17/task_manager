import 'package:task_manager/core/utils/app_strings.dart';

class Validation {
  static String? emptyValid(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFiledIsRequired;
    }
    return null;
  }
}
