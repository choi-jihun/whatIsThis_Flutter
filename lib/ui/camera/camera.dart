// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:camerawesome/camerawesome_plugin.dart';
// import 'package:onnxruntime/onnxruntime.dart';
// import 'package:whatisthis/utils/onnx_helper.dart';

// class Camera extends StatefulWidget {
//   const Camera({super.key});

//   @override
//   State<Camera> createState() => _CameraState();
// }

// class _CameraState extends State<Camera> {
//   late OnnxModelHelper modelHelper;
//   bool isProcessingImage = false;

//   @override
//   void initState() {
//     super.initState();
//     modelHelper = OnnxModelHelper();
//     modelHelper.initModel();
//   }

//   @override
//   void dispose() {
//     modelHelper.dispose();
//     super.dispose();
//   }

//   Future<Map<String, OrtValue>> preprocessImage(AnalysisImage image) async {
//     try {
//       const int batchSize = 1;
//       const int inputSize = 640;
//       const int channels = 3;

//       final bytes = image.when(
//         nv21: (nv21Image) {
//           final yuvBytes = nv21Image.bytes;
//           final rgbBytes = Uint8List(inputSize * inputSize * 3);
//           final int frameSize = inputSize * inputSize;

//           for (int y = 0; y < inputSize; y++) {
//             for (int x = 0; x < inputSize; x++) {
//               final int yIndex = y * inputSize + x;
//               final int uvIndex = frameSize + (y >> 1) * inputSize + (x & ~1);

//               int yValue = yuvBytes[yIndex] & 0xFF;
//               final int v = (yuvBytes[uvIndex] & 0xFF) - 128;
//               final int u = (yuvBytes[uvIndex + 1] & 0xFF) - 128;

//               int r = (yValue + 1.370705 * v).round().clamp(0, 255);
//               int g =
//                   (yValue - 0.337633 * u - 0.698001 * v).round().clamp(0, 255);
//               int b = (yValue + 1.732446 * u).round().clamp(0, 255);

//               final int rgbIndex = yIndex * 3;
//               rgbBytes[rgbIndex] = r;
//               rgbBytes[rgbIndex + 1] = g;
//               rgbBytes[rgbIndex + 2] = b;
//             }
//           }
//           return rgbBytes;
//         },
//         bgra8888: (bgraImage) {
//           final bgraBytes = bgraImage.bytes;
//           final rgbBytes = Uint8List(inputSize * inputSize * 3);

//           for (int i = 0; i < inputSize * inputSize; i++) {
//             final int bgraIndex = i * 4;
//             final int rgbIndex = i * 3;
//             rgbBytes[rgbIndex] = bgraBytes[bgraIndex + 2];
//             rgbBytes[rgbIndex + 1] = bgraBytes[bgraIndex + 1];
//             rgbBytes[rgbIndex + 2] = bgraBytes[bgraIndex];
//           }
//           return rgbBytes;
//         },
//       );

//       if (bytes == null) {
//         throw Exception('Failed to get image bytes');
//       }

//       final buffer = Float32List(batchSize * channels * inputSize * inputSize);

//       for (var i = 0; i < inputSize * inputSize; i++) {
//         final srcIdx = i * 3;
//         buffer[i] = bytes[srcIdx] / 255.0;
//         buffer[i + inputSize * inputSize] = bytes[srcIdx + 1] / 255.0;
//         buffer[i + 2 * inputSize * inputSize] = bytes[srcIdx + 2] / 255.0;
//       }

//       final shape = [batchSize, channels, inputSize, inputSize];
//       final tensor = OrtValueTensor.createTensorWithDataList(buffer, shape);

//       return {'input': tensor};
//     } catch (e) {
//       print('Image preprocessing error: $e');
//       rethrow;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: CameraAwesomeBuilder.awesome(
//           saveConfig: SaveConfig.photo(),
//           onImageForAnalysis: (AnalysisImage image) async {
//             if (isProcessingImage) return;

//             isProcessingImage = true;
//             try {
//               final input = await preprocessImage(image);
//               final results = await modelHelper.runInference(input);

//               if (results['hasValidPrediction']) {
//                 print('Predictions: ${results['predictions']}');
//               }
//             } catch (e) {
//               print('Analysis error: $e');
//             } finally {
//               isProcessingImage = false;
//             }
//           },
//           imageAnalysisConfig: AnalysisConfig(
//             androidOptions: AndroidAnalysisOptions.nv21(width: 640),
//             maxFramesPerSecond: 30,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photo(),
          imageAnalysisConfig: AnalysisConfig(
            androidOptions: AndroidAnalysisOptions.nv21(width: 640),
            maxFramesPerSecond: 30,
          ),
        ),
      ),
    );
  }
}
