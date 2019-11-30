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

import 'package:ardor_calculator/app/ardor/calculator/app_global.dart';
import 'package:ardor_calculator/generated/i18n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Abouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(S.current.abouts_title),
      ),
      body: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: S.current.abouts_info_content,
              style: TextStyle(color: Colors.black54, fontSize: 16)),
          TextSpan(
              text: S.current.abouts_info_version(AppGlobal.instance.version,AppGlobal.instance.singInfoSHA256),
              style: TextStyle(color: Colors.black54, fontSize: 16)),
          TextSpan(
            text: S.current.abouts_info_url,
            style: TextStyle(color: Colors.blue, fontSize: 16),
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                _launchURL(S.current.abouts_info_url);
              },
          ),
          TextSpan(
              text: S.current.abouts_info_github_info,
              style: TextStyle(color: Colors.black54, fontSize: 16)),
          TextSpan(
            text: S.current.abouts_info_github_url,
            style: TextStyle(color: Colors.blue, fontSize: 16),
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                _launchURL(S.current.abouts_info_url);
              },
          )
        ]),
      ),
    );
  }

  _launchURL(apkUrl) async {
    if (await canLaunch(apkUrl)) {
      await launch(apkUrl);
    } else {
      throw 'Could not launch $apkUrl';
    }
  }
}
