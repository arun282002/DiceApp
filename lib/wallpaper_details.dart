import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class WallpaperDetails extends StatefulWidget {
  final wallpaper;
  const WallpaperDetails({super.key, this.wallpaper});

  @override
  State<WallpaperDetails> createState() => _WallpaperDetailsState();
}

class _WallpaperDetailsState extends State<WallpaperDetails> {

  Future<void> _saveImage(BuildContext context) async{

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    late String message;

    try{
      final http.Response response=await http.get(Uri.parse(widget.wallpaper));

      final dir = await getTemporaryDirectory();

      var filename = '${dir.path}/image.png';

      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      // await file.writeAsBytes(response.bodyBytes);

      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
      else
        {
          message="Save failed";
        }
    }catch (e) {
      message = 'An error occurred while saving the image';
    }



    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }

  }

  SetWallpaper() async{
    String path = widget.wallpaper;
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.wallpaper);
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);

    if(result==true)
      {
        print("set");
      }
    else
      {
        print("false");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Text("Wallpaper"),
        actions: [
          IconButton(onPressed: () {
            _saveImage(context);
          }, icon: Icon(Icons.download))
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height-190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.wallpaper,
                    ),fit: BoxFit.cover
                  )
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                 width: MediaQuery.of(context).size.width-20,
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                      ),
                    ],
                    color: Color(0xff966303),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Set as wallpaper",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

