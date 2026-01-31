class BaseResponseModel<T> {
  final T data;
  final String? message;
  final int? code;

  BaseResponseModel({required this.data, this.message, this.code});

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return BaseResponseModel<T>(
      data: fromJsonT(json['data']),
      message: json['message'],
      code: json['code'],
    );
  }
}
