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

import 'package:ardor_calculator/app/ardor/calculator/treasure/store/store_manager.dart';
import 'package:ardor_calculator/app/ardor/calculator/treasure/store/user_data_store.dart';
import 'package:flutter/material.dart';

abstract class CalBase extends StatelessWidget {

  String getName();

  IconData getIcon();

  Future<bool> startTreasure(context,String password) async{
    StoreManager.secretKey = password;
    UserDataStore value = await StoreManager.getUserData();
    if (value != null) {
      Navigator.pushNamed(context, '/group');
      return true;
    } else {
      return false;
    }
  }
}