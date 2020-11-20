import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class AsrBaseInfo {
  static SharedPreferences sharedPreferences;

  static Map userInfo = {};

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String result = sharedPreferences.get("userInfo");
    if (result != null) {
      userInfo = jsonDecode(result);
    }
  }

  //用户信息
  static void setUserInfo() {
    sharedPreferences.setString("userInfo", jsonEncode(userInfo));
  }

  static void clearUserInfo() {
    sharedPreferences.remove('userInfo');
    userInfo = {};
  }

  //版本名称 例如1.0.0
  static String getVersionName() {
    return sharedPreferences.get('versionName') ?? '0.0.0';
  }

  static void setVersionName(String versionName) {
    sharedPreferences.setString('versionName', versionName);
  }

  //具体版本号 例如200710
  static String getVersionCode() {
    return sharedPreferences.get('versionCode');
  }

  static void setVersionCode(String versionCode) {
    sharedPreferences.setString('versionCode', versionCode);
  }

  //是否同意隐私协议
  static bool getPrivacyPermission() {
    return sharedPreferences.get('privacyPermission');
  }

  static void setPrivacyPermission(bool privacyPermission) {
    sharedPreferences.setBool('privacyPermission', privacyPermission);
  }

  //是否加入班级
  static bool getIsClass() {
    return userInfo['isClass'];
  }

  static void setIsClass(bool isClass) {
    //sharedPreferences.setBool('isClass', isClass);
    userInfo['isClass'] = isClass;
    setUserInfo();
  }

  //教师角色:1-普通，2-班主任，3-校长，4-校长+教师
  static int getUserRole() {
    //return sharedPreferences.get('userRole');
    return userInfo['userRole'];
  }

  static void setUserRole(int userRole) {
    //sharedPreferences.setInt('userRole', userRole);
    userInfo['userRole'] = userRole;
    setUserInfo();
  }

  //获取用户角色 用户角色:1-普通教师，2-班主任，3-校长，4-校长+教师(接口返回)，2-教师身份，6-校长身份(创课身份)
  static int getMakeCourseUserRole() {
    //return sharedPreferences.get('userRole');
    return userInfo['makeCourseUserRole'];
  }

  static void setMakeCourseUserRole(int userRole) {
    //sharedPreferences.setInt('userRole', userRole);
    userInfo['makeCourseUserRole'] = userRole;
    setUserInfo();
  }

  //年级id
  static String getLevelCode() {
    //return sharedPreferences.get('levelCode');
    return userInfo['levelCode'];
  }

  static void setLevelCode(String levelCode) {
    userInfo['levelCode'] = levelCode;
    setUserInfo();
  }

  //学校信息
  static String getSchoolList() {
    return userInfo['schoolList'];
    //return sharedPreferences.get('schoolList');
  }

  static void setSchoolList(String schoolList) {
    userInfo['schoolList'] = schoolList;
    setUserInfo();
    //sharedPreferences.setString('schoolList', schoolList);
  }

  //校长学校列表
  static String getPrincipalSchoolList() {
    return userInfo['principalSchoolList'];
    //return sharedPreferences.get('schoolList');
  }

  static void setPrincipalSchoolList(String principalSchoolList) {
    userInfo['principalSchoolList'] = principalSchoolList;
    setUserInfo();
    //sharedPreferences.setString('schoolList', schoolList);
  }

  //校长学校信息
  static String getPrincipalSchoolInfo() {
    return userInfo['principalSchoolInfo'];
    //return sharedPreferences.get('schoolList');
  }

  static void setPrincipalSchoolInfo(String principalSchoolInfo) {
    userInfo['principalSchoolInfo'] = principalSchoolInfo;
    setUserInfo();
    //sharedPreferences.setString('schoolList', schoolList);
  }

  //用户id
  static int getUserId() {
    return userInfo['userId'];
    //return sharedPreferences.get('userId');
  }

  static void setUserId(int userId) {
    userInfo['userId'] = userId;
    setUserInfo();
    //sharedPreferences.setInt('userId', userId);
  }

  //用户名称
  static String getName() {
    return userInfo['name'];
    //return sharedPreferences.get('name');
  }

  static void setName(String name) {
    userInfo['name'] = name;
    setUserInfo();
    //sharedPreferences.setString('name', name);
  }

  //用户手机号
  static String getPhone() {
    return userInfo['phone'];
    //return sharedPreferences.get('phone');
  }

  static void setPhone(String phone) {
    userInfo['phone'] = phone;
    setUserInfo();
    //sharedPreferences.setString('phone', phone);
  }

  //用户token
  static String getToken() {
    return userInfo['token'];
    //return sharedPreferences.get('token');
  }

  static void setToken(String token) {
    userInfo['token'] = token;
    setUserInfo();
    //sharedPreferences.setString('token', token);
  }

  //用户rongToken
  static String getRongToken() {
    return userInfo['rongToken'];
    //return sharedPreferences.get('rongToken');
  }

  static void setRongToken(String rongToken) {
    userInfo['rongToken'] = rongToken;
    setUserInfo();
    //sharedPreferences.setString('rongToken', rongToken);
  }

  //用户密码
  static String getPassword() {
    return userInfo['password'];
    //return sharedPreferences.get('password');
  }

  static void setPassword(String password) {
    userInfo['password'] = password;
    setUserInfo();
    //sharedPreferences.setString('password', password);
  }

  //用户头像
  static String getHeadImgUrl() {
    return userInfo['headImgUrl'];
    //return sharedPreferences.get('schoolId');
  }

  static void setUserHeadImgUrl(String headImgUrl) {
    userInfo['headImgUrl'] = headImgUrl;
    setUserInfo();
    //sharedPreferences.setString('password', password);
  }

  //班级id
  static String getClassId() {
    return userInfo['classId'];
    //return sharedPreferences.get('classId');
  }

  static void setClassId(String classId) {
    userInfo['classId'] = classId;
    setUserInfo();
    //sharedPreferences.setString('classId', classId);
  }

  //班级名称
  static String getClassName() {
    return userInfo['className'];
    //return sharedPreferences.get('className');
  }

  static void setClassName(String className) {
    userInfo['className'] = className;
    setUserInfo();
    //sharedPreferences.setString('className', className);
  }

  //教师身份（班主任、任课老师）userType
  static String getClassRole() {
    return userInfo['classRole'];
    //return sharedPreferences.get('classRole');
  }

  // 0班主任 1教师
  static void setClassRole(String classRole) {
    userInfo['classRole'] = classRole;
    setUserInfo();
    //sharedPreferences.setString('classRole', classRole);
  }

  //学校id
  static String getSchoolId() {
    return userInfo['schoolId'];
    //return sharedPreferences.get('schoolId');
  }

  static void setSchoolId(String schoolId) {
    userInfo['schoolId'] = schoolId;
    setUserInfo();
    //sharedPreferences.setString('schoolId', schoolId);
  }

  //用户角色id
  static String getRoleId() {
    return userInfo['roleId'];
    //return sharedPreferences.get('schoolId');
  }

  static void setRoleId(String roleId) {
    userInfo['roleId'] = roleId;
    setUserInfo();
    //sharedPreferences.setString('schoolId', schoolId);
  }

  //学校名称
  static String getSchoolName() {
    return userInfo['schoolName'];
    //return sharedPreferences.get('schoolId');
  }

  static void setSchoolName(String schoolName) {
    userInfo['schoolName'] = schoolName;
    setUserInfo();
    //sharedPreferences.setString('schoolId', schoolId);
  }

  //角色名称
  static String getRoleName() {
    return userInfo['roleName'];
    //return sharedPreferences.get('schoolId');
  }

  static void setRoleName(String roleName) {
    userInfo['roleName'] = roleName;
    setUserInfo();
    //sharedPreferences.setString('schoolId', schoolId);
  }

  //课程推送信息
  static void setPushCourseMsg(String pushCourseMsg) {
    userInfo['pushCourseMsg'] = pushCourseMsg;
    setUserInfo();
    //sharedPreferences.setString('pushCourseMsg', pushCourseMsg);
  }

  static String getPushCourseMsg() {
    return userInfo['pushCourseMsg'];
    //return sharedPreferences.get('pushCourseMsg');
  }

  //驾校协调引导页存值
  static String getGuidefamily() {
    return sharedPreferences.get('getGuidefamily');
  }

  static void setGuidefamily(String getGuidefamily) {
    sharedPreferences.setString('getGuidefamily', getGuidefamily);
  }

  //驾校协调引导页存值 校长
  static String getGuideSchool() {
    return sharedPreferences.get('getGuideSchool');
  }

  static void setGuideSchool(String getGuideSchool) {
    sharedPreferences.setString('getGuideSchool', getGuideSchool);
  }

//我的引导
  static String getGuideUser() {
    return sharedPreferences.get('getGuideUser');
  }

  static void setGuideUser(String getGuideUser) {
    sharedPreferences.setString('getGuideUser', getGuideUser);
  }

//创客引导
  static String getGuideCreate() {
    return sharedPreferences.get('getGuideCreate');
  }

  static void setGuideCreate(String getGuideCreate) {
    sharedPreferences.setString('getGuideCreate', getGuideCreate);
  }

  //消息引导页存值
  static String getGuideNews() {
    return sharedPreferences.get('getGuideNews');
  }

  static void setGuideNews(String getGuideNews) {
    sharedPreferences.setString('getGuideNews', getGuideNews);
  }

  //引导页是否展示
  static void setIsGuide(bool isGuide) {
    sharedPreferences.setBool('isGuide', isGuide);
  }

  static bool getIsGuide() {
    return sharedPreferences.get('isGuide');
  }

  //班级家委会提示是否展示
  static void setClassJWH(String getClassJWH) {
    sharedPreferences.setString('getClassJWH', getClassJWH);
  }

  static String getClassJWH() {
    return sharedPreferences.get('getClassJWH');
  }

  //校级家委会提示是否展示
  static void setSchoolJWH(String schoolJWH) {
    sharedPreferences.setString('schoolJWH', schoolJWH);
  }

  static String getSchoolJWH() {
    return sharedPreferences.get('schoolJWH');
  }
}
