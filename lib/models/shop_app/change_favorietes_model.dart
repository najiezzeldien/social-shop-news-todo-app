class ChangeFavorietesModel {
  bool status;
  String message;
  ChangeFavorietesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
