import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/core/themes/app_colors.dart';

showToast({
  required String title,
  bool isGreen = false,
}) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    webPosition: 'right',
    backgroundColor: isGreen ? AppColors.primary : AppColors.red,
    textColor: AppColors.white,
    fontSize: 16.0,
  );
}
