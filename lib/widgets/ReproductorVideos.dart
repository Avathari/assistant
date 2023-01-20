import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/widgets/FtpAccount.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/LoadingScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ReproductorVideo extends StatefulWidget {
  String? videoSource;
  Widget? returnScreen;
  bool? isAsset;

  ReproductorVideo(
      {super.key,
      this.isAsset = true,
      this.returnScreen,
      this.videoSource = "assets/images/video.mp4"});

  @override
  State<ReproductorVideo> createState() => _ReproductorVideoState();
}

class _ReproductorVideoState extends State<ReproductorVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    if (Directorios.videoTemporalPath == "") {
      initWithAsset();
    } else if (widget.isAsset!) {
      setState(() {
        widget.videoSource = "assets/images/video.mp4";
      });
      initWithAsset();
    } else {
      setState(() {
        widget.videoSource = Directorios.videoTemporalPath;
      });
      initWithFile();
    }

    //setLandscape();
    super.initState();
  }

  @override
  void dispose() {
    Directorios.videoTemporalPath = "";
    controller.pause();
    controller.dispose();
    // setAllOrientations();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (widget.returnScreen != null) {
                dispose();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => widget.returnScreen!)));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const FtpAccount())));
                dispose();
              }
            },
          ),
          actions: [
            GrandIcon(
              labelButton: 'Buscar video',
              weigth: 10,
              iconData: Icons.video_collection,
              onPress: () async {
                final file = await pickVideo();
                if (file == null) return;
                setState(() {
                  widget.videoSource = file.path;
                });
                initWithFile();
              },
            )
          ]),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          controller.value.isInitialized
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    });
                  },
                  child: Stack(children: [
                    AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller)),
                    Positioned.fill(child: widgetOnPlay())
                  ]),
                )
              : LoadingScreen(
                  error: "No se puede cargar video",
                ),
          Row(
            children: [
              GrandIcon(
                iconData:
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                weigth: 50,
                onPress: () {
                  setState(() {
                    controller.value.isPlaying
                        ? controller.pause()
                        : controller.play();
                  });
                },
              ),
              indicatorVideo(),
              GrandIcon(
                iconData: isMuted ? Icons.volume_mute : Icons.volume_up,
                weigth: 25,
                onPress: () {
                  setState(() {
                    controller.setVolume(isMuted ? 1 : 0);
                  });
                },
              ),
            ],
          ),
          GrandButton(
              labelButton: "Buscar video",
              onPress: () async {
                final file = await pickVideo();
                if (file == null) return;
                setState(() {
                  widget.videoSource = file.path;
                });
                initWithFile();
              }),
        ]),
      ),
    );
  }

  Widget buildVideoPlayer({required Widget child}) {
    final size = controller.value.size;

    return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(width: size.width, height: size.height, child: child));
  }

  Widget indicatorVideo() => Expanded(
        child: VideoProgressIndicator(controller,
            padding: const EdgeInsets.all(5), allowScrubbing: true),
      );

  Widget widgetOnPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 60,
          ),
        );

  Future<File> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    return File(result!.files.first.path!);
  }

  void initWithAsset() {
    controller = VideoPlayerController.asset(widget.videoSource!)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
  }

  void initWithFile() {
    // C:\Users\athar\AppData\Local\Temp\anal intenso.mp4
    controller = VideoPlayerController.file(File(widget.videoSource!))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
  }

  void initWithNetwork() {
    controller = VideoPlayerController.network(widget.videoSource!)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
  }

  // Future setLandscape() async {
  //   await SystemChrome.setEnabledSystemUIMode([]);
  //   await SystemChrome.setPreferredOrientations(
  //       [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  //   //await WakeLock.enable();
  // }

  // Future setAllOrientations() async {
  //   await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  //   //await WakeLock.disable();
  // }
}
