// Copyright 2019-present the Ardor.App authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import 'dart:io';

import 'package:ardor_calculator/app/ardor/calculator/treasure/bean/config.dart';
import 'package:ardor_calculator/app/ardor/calculator/treasure/store/store_manager.dart';
import 'package:ardor_calculator/app/ardor/store/safe_file_store.dart';
import 'package:ardor_calculator/library/appinfo.dart';
import 'package:ardor_calculator/library/applog.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';

class AppGlobal {

  static AppGlobal _instance = AppGlobal();

  String treasuresKey;
  //是否显示私有隐藏数据。
  static bool isPrivateShow = false;

  static AppGlobal get instance => _instance;

  Locale _locale;

  int calculatorIndex = 0;

  String _appName;

  String get appName => _appName;
  String _packageName;
  String _version;
  String _buildNumber;
  String _singInfoMD5;
  String _singInfoSHA1;
  String _singInfoSHA256;
  AppGlobal();

  Future<void> init() async{
    String key = await initDeviceInfo();
    AppLog.i("AppGlobal", "init : $key");
    SafeFileStore.setStoreKey(key);
    await initConfig();
    AppLog.i("AppGlobal", "_locale : $_locale");

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      _appName = packageInfo.appName;
      _packageName = packageInfo.packageName;
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });

    AppInfo.singInfo("MD5").then((String value){
      _singInfoMD5 = value;
    });

    AppInfo.singInfo("SHA1").then((String value){
      _singInfoSHA1 = value;
    });

    AppInfo.singInfo("SHA256").then((String value){
      _singInfoSHA256 = value;
    });
  }

  Future<String> initDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if(Platform.isIOS){
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    }else if(Platform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      androidDeviceInfo.version;
      return "${androidDeviceInfo.androidId}${androidDeviceInfo.device}${androidDeviceInfo.model}";
    }
    return "AppGlobal";
  }

  Future<void> initConfig() async {
    Config config = await StoreManager.getConfig();
    if (config.localeLanguageCode != null && config.localeLanguageCode.isNotEmpty) {
      if (config.localeCountryCode != null && config.localeCountryCode.isNotEmpty) {
        _locale = Locale(config.localeLanguageCode,config.localeCountryCode);
      } else {
        _locale = Locale(config.localeLanguageCode,"");
      }
    } else {
      _locale = Locale("zh","CN");
    }

    calculatorIndex = config.calculatorIndex;
  }

  Locale getLocale(BuildContext context) {
    //获取当前设备语言
    return _locale;
  }

  String get packageName => _packageName;

  String get version => _version;

  String get buildNumber => _buildNumber;

  String get singInfoMD5 => _singInfoMD5;

  String get singInfoSHA1 => _singInfoSHA1;

  String get singInfoSHA256 => _singInfoSHA256;

}