class LoginModel {
    LoginModel({
        required this.success,
        required this.token,
        required this.message,
    });

    final dynamic success;
    final String? token;
    final String? message;

    factory LoginModel.fromJson(Map<String, dynamic> json){ 
        return LoginModel(
            success: json["success"],
            token: json["token"],
            message: json["message"],
        );
    }

}

class LoginErrorModel {
    LoginErrorModel({
        required this.success,
        required this.errors,
    });

    final String? success;
    final LoginErrors? errors;

    factory LoginErrorModel.fromJson(Map<String, dynamic> json){ 
        return LoginErrorModel(
            success: json["success"]?.toString(),
            errors: json["errors"] == null ? null : LoginErrors.fromJson(json["errors"]),
        );
    }

}

class LoginErrors {
     LoginErrors({
        required this.email,
    });

    final List<String> email;

    factory  LoginErrors.fromJson(Map<String, dynamic> json){ 
        return  LoginErrors(
            email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
        );
    }

}
