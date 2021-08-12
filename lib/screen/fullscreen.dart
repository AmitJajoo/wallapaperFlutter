import 'package:file/src/interface/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class FullScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String image_url;
  // ignore: non_constant_identifier_names
  const FullScreen({Key? key, required this.image_url}) : super(key: key);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setWallapaper() async {
    String url = widget.image_url; // Image url

    File cachedimage =
        await DefaultCacheManager().getSingleFile(url); //image file

    int location = WallpaperManagerFlutter.HOME_SCREEN; //Choose screen type

    WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Image.network(widget.image_url),
            )),
            GestureDetector(
              onTap: () {
                setWallapaper();
              },
              child: Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: Text('Set Wallapaper',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
