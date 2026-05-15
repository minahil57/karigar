class BadRequestModel {
  bool? status;
  String? data;

  BadRequestModel({
    this.status,
    this.data,
  });

  factory BadRequestModel.fromJson(Map<String, dynamic> json) => BadRequestModel(
        status: json['status'],
        data: json['data'],
      );
}
