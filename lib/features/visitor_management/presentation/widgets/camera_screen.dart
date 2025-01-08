import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'dart:io';

class CameraScreen extends StatelessWidget {
  final Function(String) onPhotoTaken;

  const CameraScreen({
    super.key,
    required this.onPhotoTaken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(),
        onMediaTap: (mediaCapture) {
          if (mediaCapture.status == MediaCaptureStatus.success) {
            mediaCapture.captureRequest.when(
              single: (single) {
                if (single.file?.path != null) {
                  onPhotoTaken(single.file!.path);
                  Navigator.pop(context);
                }
              },
              multiple: (_) {}, // We don't handle multiple photos
            );
          }
        },
        theme: AwesomeTheme(
          buttonTheme: AwesomeButtonTheme(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
