// import 'package:flutter/services.dart';
// import 'package:onnxruntime/onnxruntime.dart';

// class OnnxModelHelper {
//   OrtSession? session;
//   late List<String> labels;

//   Future<void> initModel() async {
//     OrtEnv.instance.init();

//     final modelFile = await rootBundle.load('assets/train146.onnx');
//     final bytes = modelFile.buffer.asUint8List();

//     final sessionOptions = OrtSessionOptions();
//     session = OrtSession.fromBuffer(bytes, sessionOptions);

//     final labelStr = await rootBundle.loadString('assets/labels.txt');
//     labels = labelStr.split('\n');
//   }

//   Future<Map<String, dynamic>> runInference(
//       Map<String, OrtValue> inputs) async {
//     if (session == null) throw Exception('Model not initialized');

//     final runOptions = OrtRunOptions();
//     final outputs = await session!.runAsync(runOptions, inputs);
//     return processOutput(outputs!);
//   }

//   Map<String, dynamic> processOutput(List<dynamic> outputs,
//       {double threshold = 0.7}) {
//     try {
//       final output = outputs[0];
//       List<Map<String, dynamic>> validPredictions = [];

//       for (int i = 0; i < output.length; i++) {
//         if (output[i] >= threshold) {
//           validPredictions.add({
//             'className': labels[i],
//             'probability': output[i],
//           });
//         }
//       }

//       validPredictions.sort((a, b) =>
//           (b['probability'] as double).compareTo(a['probability'] as double));

//       return {
//         'predictions': validPredictions,
//         'hasValidPrediction': validPredictions.isNotEmpty,
//       };
//     } catch (e) {
//       print('Output processing error: $e');
//       return {
//         'predictions': [],
//         'hasValidPrediction': false,
//       };
//     }
//   }

//   void dispose() {
//     session?.release();
//     OrtEnv.instance.release();
//   }
// }
