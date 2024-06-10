import 'dart:ffi';
import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteHelper {
  static late Interpreter _interpreter;

  static Future<void> loadModel() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/radiation_uv_model.tflite');
      _interpreter.allocateTensors();
      print("Modelo cargado exitosamente");
    } catch (e) {
      print("Error al cargar el modelo: $e");
    }
  }

  static double predict(List<double> input, double hour) {
    if (hour <= 18 && hour >= 7) {
      var inputBuffer = Float32List.fromList(input);
      var outputBuffer = Float32List(1);
      _interpreter.run(
          inputBuffer.buffer, outputBuffer.buffer); // Se ejecuta la inferencia

      return 2.4 * outputBuffer[0]; // Se devuelve el resultado de la inferencia
    } else {
      return 0.0;
    }
  }

  static void close() {
    _interpreter.close();
  }
}
