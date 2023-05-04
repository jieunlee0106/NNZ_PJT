import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nnz/src/model/register_model.dart';

//회원 관련 프로바이더 ex) login, register, findPassword
class UserProvider extends GetConnect {
  final logger = Logger();
  final headers = {
    'Content-Type': 'application',
  };

  @override
  void onInit() async {
    //load env file
    await dotenv.load();
    //Set baseUrl from .env file
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(microseconds: 5000);
    super.onInit();
  }

  //로그인 api 통신
  Future<Response> postLogin({
    required String email,
    required String password,
  }) async {
    final body = {
      'email': email,
      'pwd': password,
    };
    final response = await post("/users/login", body, headers: headers);
    return response;
    // try {
    //   final response = await post("/users/login", body, headers: headers);
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }
  }

  //이메일 및 닉네임 중복확인 코드 중복이므로 type와 value를 가져와 쿼리스트링으로 get 검색
  Future<Response> getValidate({
    required String type,
    required String value,
  }) async {
    final response = await get("/users/check?type=$type&val=$value");
    return response;
    // try {
    //   final response = await get("/users/check?$type&$value", headers: headers);
    //   //응답코드가 200이면 닉네임이나 이메일 사용가능
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   }
    //   //응답코드가 409이면 닉네임이나 이메일이 중복이 되었다는 의미...
    //   else if (response.statusCode == 409) {
    //     return response.body;
    //   }
    //   //위의 두 에러가 아닌 나머지 코드이면 erorrMessage를 준다.
    //   else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }
  }

  //테스트 이메일 중복확인 api
  void testApi({required String type, required String text}) {
    logger.i("$type : $text");
  }

  //본인인증 요청 api
  Future<Response> postReqVerify({
    required String phone,
  }) async {
    final body = {
      'phone': phone,
    };
    final response =
        await post("/user-service/users/verify", body, headers: headers);
    return response;
    // try {
    //   final response = await post("/users/verify", body, headers: headers);
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }
  }

  //본인인증 확인 api
  Future<Response> postResVerify({
    required String phone,
    required String verifyNum,
  }) async {
    final body = {
      'phone': phone,
      'verify': verifyNum,
    };
    final response =
        await post("/user-service/users/verify/check", body, headers: headers);
    return response;
    // try {
    //   final response = await post("/users/verify", body, headers: headers);
    //   if (response.statusCode == 200) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }
  }

  //회원가입 api
  Future<Response> postRegister({required RegisterModel user}) async {
    final body = user.toJson();
    // logger.i(body);
    final response =
        await post("/user-service/users/join", body, headers: headers);
    return response;
    // try {
    //   final response = await post("/users/join", body, headers: headers);
    //   if (response.statusCode == 201) {
    //     return response.body;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }
  }

  //비밀번호 변경 api
  Future<Response> patchPwd(
      {required String phone,
      required String pwd,
      required String confirmPwd}) async {
    final body = {
      "phone": phone,
      "pwd": pwd,
      "confirmPwd": confirmPwd,
    };
    final response = await patch("/users/find-pwd", body, headers: headers);
    return response;
    // try {
    //   final response = await patch("/users/find-pwd", body);
    //   if (response.statusCode == 204) {
    //     return response;
    //   } else {
    //     final errorMessage = "(${response.statusCode}): ${response.body}";
    //     logger.e(errorMessage);
    //     throw Exception(errorMessage);
    //   }
    // } catch (e) {
    //   final errorMessage = "$e";
    //   logger.e(errorMessage);
    //   throw Exception(errorMessage);
    // }
  }
}
