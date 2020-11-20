//import 'dart:html';

import 'build_env.dart';
import 'env_constant.dart';

/// 管理不同环境的配置类
/// 属性默认返回"开发环境（Dev）"的值
class Config {
  static BuildEnv _buildEnv;
  static void setBuildEnv(String env) {
    if (env == null || env.isEmpty) {
      Config._buildEnv = BuildEnv.DEV;
    } else {
      if (env.toLowerCase() == EnvConstant.DEV) {
        Config._buildEnv = BuildEnv.DEV;
      } else if (env.toLowerCase() == EnvConstant.TEST) {
        Config._buildEnv = BuildEnv.TEST;
      } else if (env.toLowerCase() == EnvConstant.PRE) {
        Config._buildEnv = BuildEnv.PRE;
      } else if (env.toLowerCase() == EnvConstant.PROD) {
        Config._buildEnv = BuildEnv.PROD;
      }
    }
  }

  static const appId = "app-fsp-teacher";
  static const signTypeRas = "RSA";
  static const signTypeMd5 = "MD5";
  static const clientType = "TEACHER_APP";
  static const ossEndpoint = "https://oss-cn-beijing.aliyuncs.com";

  /// 网关地址（接口调用的前缀）
  static String get apiGateway {
    switch (_buildEnv) {
      case BuildEnv.DEV:
        return "http://192.168.1.52";
      case BuildEnv.TEST:
        return "http://192.168.1.62";
      case BuildEnv.PRE:
        return "http://192.168.1.132";
      case BuildEnv.PROD:
        return "https://api.prod.jiazhangkj.com";
      default:
        return "http://192.168.1.52";
    }
  }

  /// RSA私钥
  // TODO 如何确保在app中的安全存储？；
  // TODO 生产私钥如何在构建时传入？——替换文件
  static String get privateKey {
    switch (_buildEnv) {
      case BuildEnv.DEV:
        return "-----BEGIN PRIVATE KEY-----" + "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALtjLUTMGJsn7+tP83+3U/ItCj4p1VHHBpOlILwpuMPHTlgGJn4j+hwvf+tZ9n8KuUF3RfLr2EkBBZ/YHQs5hXH3yxQhrZ0BNi8JgziPE9FywWap7sXOEhHrG4hAjhv74sODcB79N7oDTsS6wmkgZUr4G9Ty7imQ1rgxi2MoKwHBAgMBAAECgYBGw4w718tPBITw2w98YpH7+ZBNq2SYbk2IgipbhHH21RQ73463wgRYkoN/MEkK7tTI6S7sLq5N22nxVB6bt4wxuP08oUAE1d5/Yx910jY16RBB/2osnQRDJKowko3vzKamZSJCazqgW60FlJ80NV7n9l6YotN1lTgtCDvBkNYSxQJBAOlcck/p4Ct/pvuTryndYQN/qCafcrgzd2HMnKPYn8MwgACtc9/AO73EZInGPpJNXWqlxtiG5RnkuQN+Q2xn7dMCQQDNkPeggB52FKXEEmK+aEjzA9s1zTV9XG9Z/feH6ZqwOaoNN2nsT/P1+2Z+k5TPvqWOeBUZ/73vkUTSIK0I4RGbAkEA0UXKbcf69IdhpDLo3s5c9dpBXYGYS4A8C0SHJJhbjZus7u6d/4ZRDPlWgAd8jY87uyw3im5Ofk4TbQKKTGlXaQJATjJRIErcS4q7LATabxf4eAkFgEfZiyB4c0E6wgbJAzRMTc7AilY3tWC2snutZgFdtP5U+JjiRZl7Fnu7lt8W9QJBAJ4G+ipHxAk+twjGNrFScuqKeCFJ7I7MDsXSy6iR2noMoSlpbkoXN/Wm7aXRYkjst6I47q01yMzDeLv6lqTdOuo=" + "-----END PRIVATE KEY-----";
      case BuildEnv.TEST:
        return "-----BEGIN PRIVATE KEY-----" + "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALtjLUTMGJsn7+tP83+3U/ItCj4p1VHHBpOlILwpuMPHTlgGJn4j+hwvf+tZ9n8KuUF3RfLr2EkBBZ/YHQs5hXH3yxQhrZ0BNi8JgziPE9FywWap7sXOEhHrG4hAjhv74sODcB79N7oDTsS6wmkgZUr4G9Ty7imQ1rgxi2MoKwHBAgMBAAECgYBGw4w718tPBITw2w98YpH7+ZBNq2SYbk2IgipbhHH21RQ73463wgRYkoN/MEkK7tTI6S7sLq5N22nxVB6bt4wxuP08oUAE1d5/Yx910jY16RBB/2osnQRDJKowko3vzKamZSJCazqgW60FlJ80NV7n9l6YotN1lTgtCDvBkNYSxQJBAOlcck/p4Ct/pvuTryndYQN/qCafcrgzd2HMnKPYn8MwgACtc9/AO73EZInGPpJNXWqlxtiG5RnkuQN+Q2xn7dMCQQDNkPeggB52FKXEEmK+aEjzA9s1zTV9XG9Z/feH6ZqwOaoNN2nsT/P1+2Z+k5TPvqWOeBUZ/73vkUTSIK0I4RGbAkEA0UXKbcf69IdhpDLo3s5c9dpBXYGYS4A8C0SHJJhbjZus7u6d/4ZRDPlWgAd8jY87uyw3im5Ofk4TbQKKTGlXaQJATjJRIErcS4q7LATabxf4eAkFgEfZiyB4c0E6wgbJAzRMTc7AilY3tWC2snutZgFdtP5U+JjiRZl7Fnu7lt8W9QJBAJ4G+ipHxAk+twjGNrFScuqKeCFJ7I7MDsXSy6iR2noMoSlpbkoXN/Wm7aXRYkjst6I47q01yMzDeLv6lqTdOuo=" + "-----END PRIVATE KEY-----";
      case BuildEnv.PRE:
        return "-----BEGIN PRIVATE KEY-----" + "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALtjLUTMGJsn7+tP83+3U/ItCj4p1VHHBpOlILwpuMPHTlgGJn4j+hwvf+tZ9n8KuUF3RfLr2EkBBZ/YHQs5hXH3yxQhrZ0BNi8JgziPE9FywWap7sXOEhHrG4hAjhv74sODcB79N7oDTsS6wmkgZUr4G9Ty7imQ1rgxi2MoKwHBAgMBAAECgYBGw4w718tPBITw2w98YpH7+ZBNq2SYbk2IgipbhHH21RQ73463wgRYkoN/MEkK7tTI6S7sLq5N22nxVB6bt4wxuP08oUAE1d5/Yx910jY16RBB/2osnQRDJKowko3vzKamZSJCazqgW60FlJ80NV7n9l6YotN1lTgtCDvBkNYSxQJBAOlcck/p4Ct/pvuTryndYQN/qCafcrgzd2HMnKPYn8MwgACtc9/AO73EZInGPpJNXWqlxtiG5RnkuQN+Q2xn7dMCQQDNkPeggB52FKXEEmK+aEjzA9s1zTV9XG9Z/feH6ZqwOaoNN2nsT/P1+2Z+k5TPvqWOeBUZ/73vkUTSIK0I4RGbAkEA0UXKbcf69IdhpDLo3s5c9dpBXYGYS4A8C0SHJJhbjZus7u6d/4ZRDPlWgAd8jY87uyw3im5Ofk4TbQKKTGlXaQJATjJRIErcS4q7LATabxf4eAkFgEfZiyB4c0E6wgbJAzRMTc7AilY3tWC2snutZgFdtP5U+JjiRZl7Fnu7lt8W9QJBAJ4G+ipHxAk+twjGNrFScuqKeCFJ7I7MDsXSy6iR2noMoSlpbkoXN/Wm7aXRYkjst6I47q01yMzDeLv6lqTdOuo=" + "-----END PRIVATE KEY-----";
      case BuildEnv.PROD:
        return "-----BEGIN PRIVATE KEY-----" + "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAL5VrfoovkU7W/G6IzzUixuVCCnKXB9+TQX/pEto+UTdPlQG/+zqhVnbtrngDx3/KggolV0SRRzVftElkPbq0XX99sdSTPNUQenELJ2vuz4Nk5Iih2N18gmUhD3Gl8AG3yS2NOTwE6iYAhX1OT9fk6AsZsF6QWZBomMFUfgZIwanAgMBAAECgYBdcxG9Xh21PiSxdVNxvWUjQLPGWO2MJOXKSS6wO7UPQ5UjimBDQQ4CBWccsc6aSrqnUM2s6Zh3RLdEFq6rHLWD37wZcPQP4+6/I1D/C+300vQCgmGAvTqoNlFINCW8SyBYc+QdUke+NI5tQLRzUFV1cqaLosbELYmYE4TyOZQuSQJBAPkJRiaUvKmsNdRMBm2GWRZ8CpoPVE4jX4sP7+yEqS0aEFZ0epEQBypJf4zNBZ5BPkxS4C0VUyj+y5Yq+6zfvZUCQQDDqDDIctq8IXD+qptG6JkvYcNb6lJ9PE9pEMU+eMNq0YSlqhTTPiaoQ6DD+5GPKTxUgXayUEJByAJamATUBYxLAkBxF/cVmkI7Q4uGh6f7oSFgBqDB6eg9O+8tteUdIfm6E7YLrQXkTsUSPSKBjLHadoKWIqTPlHmZimxmG8sDbPApAkEAjayY/lxkVLumVVF2NGcynOOekUzgRDzKh5qUKMNLRWrHMSoyADBNz6OAosjjwpUqUUqZh06kW3uXcMAJJvmJdwJABVNRjiT6S2roB+cajhCOmZ18xthPpuvh74E85+I28P1BiH2Lk7F+Kupa9NnJgLYLrb7kmB5wBA6yye9Ir+vHnA==" + "-----END PRIVATE KEY-----";
      default:
        return "-----BEGIN PRIVATE KEY-----" + "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALtjLUTMGJsn7+tP83+3U/ItCj4p1VHHBpOlILwpuMPHTlgGJn4j+hwvf+tZ9n8KuUF3RfLr2EkBBZ/YHQs5hXH3yxQhrZ0BNi8JgziPE9FywWap7sXOEhHrG4hAjhv74sODcB79N7oDTsS6wmkgZUr4G9Ty7imQ1rgxi2MoKwHBAgMBAAECgYBGw4w718tPBITw2w98YpH7+ZBNq2SYbk2IgipbhHH21RQ73463wgRYkoN/MEkK7tTI6S7sLq5N22nxVB6bt4wxuP08oUAE1d5/Yx910jY16RBB/2osnQRDJKowko3vzKamZSJCazqgW60FlJ80NV7n9l6YotN1lTgtCDvBkNYSxQJBAOlcck/p4Ct/pvuTryndYQN/qCafcrgzd2HMnKPYn8MwgACtc9/AO73EZInGPpJNXWqlxtiG5RnkuQN+Q2xn7dMCQQDNkPeggB52FKXEEmK+aEjzA9s1zTV9XG9Z/feH6ZqwOaoNN2nsT/P1+2Z+k5TPvqWOeBUZ/73vkUTSIK0I4RGbAkEA0UXKbcf69IdhpDLo3s5c9dpBXYGYS4A8C0SHJJhbjZus7u6d/4ZRDPlWgAd8jY87uyw3im5Ofk4TbQKKTGlXaQJATjJRIErcS4q7LATabxf4eAkFgEfZiyB4c0E6wgbJAzRMTc7AilY3tWC2snutZgFdtP5U+JjiRZl7Fnu7lt8W9QJBAJ4G+ipHxAk+twjGNrFScuqKeCFJ7I7MDsXSy6iR2noMoSlpbkoXN/Wm7aXRYkjst6I47q01yMzDeLv6lqTdOuo=" + "-----END PRIVATE KEY-----";
    }
  }

  ///融云的appKey
  static String get rongCloudKey {
    switch (_buildEnv) {
      case BuildEnv.DEV:
        return "sfci50a7s387i";
      case BuildEnv.TEST:
        return "pvxdm17jpo7dr";
      case BuildEnv.PRE:
        return "vnroth0kvb9wo";
      case BuildEnv.PROD:
        return "8brlm7uf8iul3";
      default:
        return "sfci50a7s387i";
    }
  }

  static Map get ossInitInfo {
    String endpoint = 'oss-cn-beijing.aliyuncs.com';
    String aesKey = '1234567812345678';
    String iv = 'test123456789012';
    String bucket = 'jzkj-dev';
    switch (_buildEnv) {
      case BuildEnv.DEV:
        bucket = 'jzkj-dev';
        break;
      case BuildEnv.TEST:
        bucket = 'jzkj-testing';
        break;
      case BuildEnv.PRE:
        bucket = 'jzkj-pre';
        break;
      case BuildEnv.PROD:
        bucket = 'jzkj-prod';
        break;
    }
    return {
      //String stsServer = "http://192.168.1.41:8080/sts/token";
      'endpoint':endpoint,
      'aesKey':aesKey,
      'iv':iv,
      'bucket':bucket
    };

  }

  //oss的cdn路径
  static String get ossCdnUrl {
    switch (_buildEnv) {
      case BuildEnv.DEV:
        return "http://cdn.dev.jiazhangkj.com";
      case BuildEnv.TEST:
        return "https://cdn.test.jiazhangkj.com";
      case BuildEnv.PRE:
        return "https://cdn.pre.jiazhangkj.com";
      case BuildEnv.PROD:
        return "https://cdn.jiazhangkj.com";
      default:
        return "http://cdn.dev.jiazhangkj.com";
    }
  }
      //调查问卷的路径
  static String get qiestionsUrl {
    switch (_buildEnv) {
      case BuildEnv.DEV:
        return "http://192.168.1.51:10004/#/";
      case BuildEnv.TEST:
        return "http://192.168.1.61:10004/#/";
      case BuildEnv.PRE:
        return "http://192.168.1.134:9004/#/";
      case BuildEnv.PROD:
        return "https://outer.jiazhangkj.com/#/";
      default:
        return "http://192.168.1.51:10004/#/";
    }
  }
}
