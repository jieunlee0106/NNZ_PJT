import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/model/register_model.dart';

//회원 관련 프로바이더 ex) login, register, findPassword
class UserProvider extends GetConnect {
  final logger = Logger();

  @override
  void onInit() async {
    //load env file
    await dotenv.load();

    //Set baseUrl from .env file
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.defaultContentType = '';
    httpClient.timeout = const Duration(microseconds: 5000);
    super.onInit();
  }

  //로그인 api 통신
  Future<Response> postLogin({
    required String email,
    required String password,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = {
      'email': email,
      'pwd': password,
    };
    final response = await post(
      "https://k8b207.p.ssafy.io/api/user-service/users/login",
      body,
    );
    return response;
  }

  //이메일 및 닉네임 중복확인 코드 중복이므로 type와 value를 가져와 쿼리스트링으로 get 검색
  Future<Response> getValidate({
    required String type,
    required String value,
  }) async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
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
    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await post(
      "https://k8b207.p.ssafy.io/api/user-service/users/join/verify",
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
    final headers = {
      'Content-Type': 'application/json',
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
    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await patch(
        "https://k8b207.p.ssafy.io/api/user-service/users/find-pwd", body,
        headers: headers);
    return response;
  }

  Future<Response> patchUser({
    required File image,
    required String oldPwd,
    required String newPwd,
    required String confirmNewPwd,
    required String nickname,
  }) async {
    final formData = FormData({
      "data": jsonEncode({
        "nickname": base64Encode(utf8.encode(nickname)),
        "oldPwd": oldPwd,
        "newPwd": newPwd,
        "confirmNewPwd": confirmNewPwd,
      }),
      "file": MultipartFile(
        image.path,
        filename: "profile.png",
      ),
    });
    logger.i(formData.fields);
    logger.i(formData.files);
    final token = Get.find<BottomNavController>().accessToken;
    final boundary = formData.boundary;
    final response = await patch(
      "https://k8b207.p.ssafy.io/api/user-service/users",
      formData,
      headers: {
        'Content-Type': 'multipart/form-data; boundary=$boundary',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}
