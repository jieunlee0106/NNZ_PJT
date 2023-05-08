import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nnz/src/model/register_model.dart';

//회원 관련 프로바이더 ex) login, register, findPassword
class UserProvider extends GetConnect {
  final logger = Logger();
  @override
  final headers = {
    'Content-Type': 'application/json',
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
    final response = await post(
        "https://k8b207.p.ssafy.io/api/user-service/users/login", body,
        headers: headers);
    return response;
  }

  //이메일 및 닉네임 중복확인 코드 중복이므로 type와 value를 가져와 쿼리스트링으로 get 검색
  Future<Response> getValidate({
    required String type,
    required String value,
  }) async {
    final response = await get(
      "https://k8b207.p.ssafy.io/api/user-service/users/check?type=$type&val=$value",
      headers: headers,
    );
    return response;
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
    final response = await post(
      "https://k8b207.p.ssafy.io/api/user-service/users/verify",
      body,
      headers: headers,
    );
    return response;
  }

  //본인인증 확인 api
  Future<Response> postResVerify({
    required String phone,
    required String verifyNum,
  }) async {
    final body = {
      'phone': phone,
      'verifyNum': verifyNum,
    };
    logger.i("$phone $verifyNum");
    final response = await post(
      "https://k8b207.p.ssafy.io/api/user-service/users/verify/check",
      body,
      headers: headers,
    );
    return response;
  }

  //회원가입 api
  Future<Response> postRegister({required RegisterModel user}) async {
    final body = user.toJson();
    // logger.i(body);
    final response = await post(
      "https://k8b207.p.ssafy.io/api/user-service/users/join",
      body,
    );
    return response;
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
    final response = await patch(
        "https://k8b207.p.ssafy.io/api/user-service/users/find-pwd", body,
        headers: headers);
    return response;
  }
}
