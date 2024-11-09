import 'package:task_manager/features/home/data/response/todos_response.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';

extension TodosMapper on TodosResponse? {
  TodosModel toDomain() {
    return TodosModel(
      total: this?.total ?? 0,
      limit: this?.limit ?? 0,
      skip: this?.skip ?? 0,
      todos: this?.todos != null
          ? this!.todos!.map((e) => e.toDomain()).toList()
          : [],
    );
  }
}

extension TodoDataMapper on TodoDataResponse? {
  TodoDataModel toDomain() {
    return TodoDataModel(
      completed: this?.completed ?? false,
      id: this?.id ?? 0,
      todo: this?.todo ?? "",
      userId: this?.userId ?? 0,
    );
  }
}
