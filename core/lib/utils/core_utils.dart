import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../log_helper.dart';

class CoreUtils {
  static void showImagePicker(context, String cameraText, String galleryText, String selectedLanguage, Function(FileImage) fileImageCallback) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(galleryText),
                    onTap: () {
                      CoreUtils.popScreen(context);
                      _getImage(ImageSource.gallery, (file) => fileImageCallback(FileImage(file)));
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(cameraText),
                  onTap: () {
                    CoreUtils.popScreen(context);
                    _getImage(ImageSource.camera, (file) => fileImageCallback(FileImage(file)));
                  },
                ),
              ],
            ),
          );
        });
  }

  static _getImage(ImageSource imageSource, Function(File) fileCallback) =>
      ImagePicker().pickImage(source: imageSource).then((value) => fileCallback(File(value!.path)));

  static showError(String errorMessage) {
    showToast(errorMessage);
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static closeKeyboardForcefully() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static popScreen(BuildContext context) {
    try {
      Navigator.pop(context);
    } catch (e, s) {
      LogHelper.logException(e, s);
    }
  }

  static String? getBase64String(File file) {
    try {
      List<int> fileBytes = file.readAsBytesSync();
      return base64Encode(fileBytes);
    } catch (e, s) {
      LogHelper.logException(e, s);
      return null;
    }
  }

  static String getStringBeforeCharacter(String s, String c) {
    return s.substring(0, s.indexOf(c));
  }

  static String getEllipsedString(String toBeTruncated, int truncateAt) {
    String ellipsis = "..."; //define your variable truncation ellipsis here
    String truncated = "";

    if (toBeTruncated.length > truncateAt) {
      truncated = toBeTruncated.substring(0, truncateAt - ellipsis.length) + ellipsis;
    } else {
      truncated = toBeTruncated;
    }
    return truncated;
  }

  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }
    return false;
  }

  static String extractNumber(String number) {
    String num = number.replaceAll(RegExp(r'[^0-9+]'), '');
    return num;
  }

  static bool equalIgnoreCase(String s1, String s2) {
    return s1.toLowerCase() == s2.toLowerCase();
  }

  static void openKeyboard(BuildContext context, FocusNode inputNode) {
    FocusScope.of(context).requestFocus(inputNode);
  }

  static int getCurrentTimeStamp() => DateTime.now().millisecondsSinceEpoch;
}
