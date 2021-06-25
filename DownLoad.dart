import "package:flutter/material.dart";
import "dart:io";
import "package:permission_handler/permission_handler.dart";
import "package:path_provider/path_provider.dart";
import 'package:dio/dio.dart';


class DownLoadPage extends StatefulWidget {

  final void Function() downloadNotifier;

  const DownLoadPage({Key key, this.downloadNotifier}): super(key: key);

  @override
  _DownLoadPageState createState() => _DownLoadPageState();

}

class _DownLoadPageState extends State<DownLoadPage> {
  bool loading = false;
  double progress = 0;

  void initState() {
    super.initState();
    downloadFile();
  }

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/RPSApp";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + "/$fileName");
        var dio = Dio();
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
              setState(() {
                progress = value1 / value2;
              });
            });
      /*  if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }*/
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    // saveVideo will download and save file to Device and will return a boolean
    // for if the file is successfully or not
    bool downloaded = await saveVideo(
        "https://audio.coran-islam.com/telecharger_fichier.php?ids=1&idv=1&arabe=1",
        "test.mp3");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }

    setState(() {
      loading = false;
      widget.downloadNotifier();
    });
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Stack(
              children: <Widget>[
              // Stroked text as border.
              Text(
                'Downloading',
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.blue[700],
                ),
              ),
              // Solid text as fill.
              Text(
                'Downloading',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              ],
            ),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: progress,
            )
            )],
          )
        );
  }
}