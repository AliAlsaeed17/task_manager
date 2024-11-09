import 'package:flutter/material.dart';
import 'package:task_manager/core/themes/app_colors.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.model,
    this.onChanged,
    this.onTapDelete,
    super.key,
  });

  final TodoDataModel model;
  final void Function(bool?)? onChanged;
  final void Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 24),
                ],
              ),
              child: Text(
                model.todo,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onTapDelete,
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.red,
                ),
              ),
              Checkbox(
                value: model.completed,
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
