import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/model/register_model.dart';

//회원 관련 프로바이더 ex) login, register, findPassword
class UserProvider extends GetConnect {
  final logger = Logger();
  final storage = const FlutterSecureStorage();
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
    required String deviceToken,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = {
      'email': email,
      'pwd': password,
      'deviceToken': deviceToken,
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

  //회원가입 본인인증 요청 api
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

  //비밀번호 찾기 인증번호 요청
  Future<Response> postReqFindVerify({
    required String phone,
  }) async {
    final body = {
      'phone': phone,
    };
    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await post(
      "https://k8b207.p.ssafy.io/api/user-service/users/find-pwd/verify",
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

  //타 프로필 정보 조회
  Future<Response> getOtherProfile({required int userId}) async {
    final headers = {'Content-Type': 'application/json'};
    final response = await get(
        "https://k8b207.p.ssafy.io/api/user-service/users/$userId",
        headers: headers);
    return response;
  }

  //팔로우 및 언팔로우
  Future<Response> followService({required int userId}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMSIsImlzcyI6Im5ueiIsImlhdCI6MTY4NDI1MDQ0MSwiYXV0aFByb3ZpZGVyIjoiTk5aIiwicm9sZSI6IkFETUlOIiwiaWQiOjExLCJlbWFpbCI6IndsZ2hrczk2MEBuYXZlci5jb20iLCJleHAiOjE2ODU1NDY0NDF9.BmGS9PsahfLry18hx_HfEI6KFPsZyfBIKD-UsL2UAodD2ejZD3P8ARkAC-cQqb5S2Lad50poAPaSi3xhjK3-fA'
    };
    final response = await post(
        "https://k8b207.p.ssafy.io/api/user-service/users/follow/$userId", null,
        headers: headers);
    return response;
  }

  //유저 탈퇴
  Future<Response> deleteUserService() async {
    final token = await storage.read(key: 'accessToken');
    final headers = {'Authorization': 'Bearer $token'};

    final response = await delete(
        'https://k8b207.p.ssafy.io/api/user-service/users/exit',
        headers: headers);

    return response;
  }

  //토근 재발급 코드
  Future<Response> refreshToken(
      {required String accessToken, required String refreshToken}) async {
    const body = null;
    final response = await post(
        "https://k8b207.p.ssafy.io/api/user-service/users/reissue", body,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Cookie': 'refreshToken= $refreshToken'
        });
    return response;
  }
}
