import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:coba/pages/home_screen.dart';
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  late Timer _timer;
  Uint8List? _imageBytes;
  bool _processingFrame = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    _timer = Timer.periodic(Duration(milliseconds: 200), (Timer timer) {
      if (!controller!.value.isStreamingImages && !_processingFrame) {
        processFrame();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    controller?.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      controller = CameraController(cameras[1], ResolutionPreset.medium);
      try {
        await controller!.initialize();
      } catch (e) {
        print('Error initializing camera: $e');
      }
      if (!mounted) return;
      setState(() {});
    } else {
      print('No cameras found');
    }
  }

  Future<void> processFrame() async {
    if (controller == null || !controller!.value.isInitialized) {
      print('Camera is not initialized');
      return;
    }

    _processingFrame = true;

    XFile picture = await controller!.takePicture();
    Uint8List bytes = await picture.readAsBytes();
    String base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse('http://192.168.69.96:5000/video_feed'),
      body: {'frame': base64Image},
    );

    if (response.statusCode == 200) {
      setState(() {
        _imageBytes = base64Decode(jsonDecode(response.body)['frame']);
      });
    } else {
      print('Failed to process frame');
    }

    _processingFrame = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Detection'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FirstScreen()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _imageBytes != null
                ? Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              if (!_processingFrame) {
                setState(() {});
              }
            },
            child: Text('Process Frame'),
          ),
        ],
      ),
    );
  }
}
