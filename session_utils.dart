/* 
 * required package : http (https://pub.dev/packages/http)
 * develop version  : http: ^0.13.4
 * 
 * ===== test code =====
 * var uri = Uri.parse("https://okky.kr/");
 * var response = await get(uri);
 * SessionUtils.jseSessionId(response: response);
 */

import 'package:http/http.dart';

class SessionUtils {
  static String? jseSessionId({required Response response}) {
    // 헤더에서 쿠키 들고오기
    var cookies = response.headers["set-cookie"];
    if (cookies == null) return null;

    // 쿠키에서 JSESSIONID 만 들고오기
    var regExp = RegExp(r"JSESSIONID.*?\;");
    var sessionCookie = regExp.firstMatch(cookies)?.group(0);
    if (sessionCookie == null) return null;

    // 필요없는 문자열(JSESSIONID, ;) 지우기
    var session = sessionCookie.replaceAll(RegExp(r"[JSESSIONID=.*;]"), "");

    return session;
  }
}
