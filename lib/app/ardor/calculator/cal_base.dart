// Copyright 2019-present the ardor.App authors. All Rights Reserved.
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

import 'package:ardor_calculator/library/callback.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class CalBase extends StatefulWidget {

  StringCallback passwordInputCallback;

  int _onClickTimes = 0;
  int _lastClickTime = 0;

  CalBase(this.passwordInputCallback);

  String getName();

  IconData getIcon();

  void reset();

  //点击触发跳转。
  void onClickToTreasure(String p) {
    int newLastClickTime = new DateTime.now().millisecondsSinceEpoch;
    if (newLastClickTime - _lastClickTime < 500) {
      //有效连续点击
      if (++_onClickTimes >= 3) {
        //连续点击3次，则出发跳转
        if (passwordInputCallback != null) {
          passwordInputCallback(p);
        }
        _onClickTimes = 0;
      }
    } else {
      _onClickTimes = 0;
    }
    _lastClickTime = newLastClickTime;
  }
}