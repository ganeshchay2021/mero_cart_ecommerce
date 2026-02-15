class RegisterModel {
    RegisterModel({
        required this.success,
        required this.token,
        required this.message,
    });

    final String? success;
    final String? token;
    final String? message;

    factory RegisterModel.fromJson(Map<String, dynamic> json){ 
        return RegisterModel(
            success: json["success"]?.toString(),
            token: json["token"],
            message: json["message"],
        );
    }

}


class RegisterErrorModel {
    RegisterErrorModel({
        required this.success,
        required this.errors,
    });

    final String? success;
    final Errors? errors;

    factory RegisterErrorModel.fromJson(Map<String, dynamic> json){ 
        return RegisterErrorModel(
            success: json["success"]?.toString(),
            errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        );
    }

}
class Errors {
  List<String>? name;
  List<String>? email;
  List<String>? password;

  Errors({this.name, this.email, this.password});

  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(
      name: json["name"] != null ? List<String>.from(json["name"]) : null,
      email: json["email"] != null ? List<String>.from(json["email"]) : null,
      password: json["password"] != null ? List<String>.from(json["password"]) : null,
    );
  }
}