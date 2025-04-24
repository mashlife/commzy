class ErrorModel{

  String? status;
  String? message;
  bool? fatal;

  ErrorModel({
    this.status,
    this.message,
    this.fatal,
  });

  factory ErrorModel.fromJson(Map<String,dynamic> json){
    return ErrorModel(
      status: json['status'],
      message: json['message'],
      fatal: json['fatal'],
    );
  }
}