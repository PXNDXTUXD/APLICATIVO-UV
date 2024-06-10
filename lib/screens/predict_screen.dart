import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_youtube/data/tflite_helper.dart';
import 'package:weather_app_youtube/screens/info_screen.dart';
import 'package:weather_app_youtube/widgets/CustomButton.dart';
import 'package:weather_app_youtube/widgets/LegendCard.dart';
import 'package:weather_app_youtube/widgets/RadiationRecomendation.dart';

class PredictScreen extends StatefulWidget {
  PredictScreen({super.key});

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  TextEditingController _dateController = TextEditingController();

  TextEditingController _timeController = TextEditingController();

  final FocusNode _focusNodeDate = FocusNode();

  final FocusNode _focusNodeTime = FocusNode();

  bool isLoading = false;

  DateTime? _selectedDate;
  double? prediction;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _predict() async {
    if (_dateController.text.isEmpty || _timeController.text.isEmpty) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Los valores no pueden estar vacíos'),
          duration: Duration(milliseconds: 1000),
        ),
      );
    } else {
      List<String> dateParts = _dateController.text.split('/');
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      TimeOfDay time = TimeOfDay(
        hour: int.parse(_timeController.text.split(":")[0]),
        minute: int.parse(_timeController.text.split(":")[1]),
      );

      int hour = time.hour;
      int minute = time.minute;

      // Datos para la predicción
      List<double> input = [
        year.toDouble(),
        month.toDouble(),
        day.toDouble(),
        hour.toDouble(),
        minute.toDouble(),
      ];

      prediction = await TFLiteHelper.predict(input,hour.toDouble());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          title: Text(
            'Radiación Solar',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(40, kToolbarHeight * 1.4, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepPurple),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF673AB7)),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 300,
                    width: 600,
                    decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Datos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            enableInteractiveSelection: false,
                            controller: _dateController,
                            keyboardType: TextInputType.number,
                            focusNode: _focusNodeDate,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Completa la fecha',
                              hintStyle: TextStyle(color: Colors.white70),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            style: TextStyle(color: Colors.white),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            enableInteractiveSelection: false,
                            controller: _timeController,
                            keyboardType: TextInputType.number,
                            focusNode: _focusNodeTime,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Completa la hora',
                              hintStyle: TextStyle(color: Colors.white70),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            style: TextStyle(color: Colors.white),
                            onTap: () {
                              _selectTime(context);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          onPressed: () async {
                            isLoading = true;
                            FocusScope.of(context).unfocus();
                            await _predict();
                          },
                          text: 'Calcular pronóstico de radiación',
                        ),
                        isLoading
                            ? CircularProgressIndicator()
                            : SizedBox(
                                child: prediction == null
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24),
                                        child: Center(
                                            child: Text(
                                          'Ingresa valores para calcular',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(top: 20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.white12,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    prediction!
                                                        .toStringAsFixed(2),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 54),
                                                  ),
                                                  SizedBox(width: 20),
                                                  Text(
                                                    'Indice UV',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'Recomendaciones',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            RadiationRecommendation(
                                              prediction: prediction!,
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                        LegendCard(),
                        SizedBox(height: 20),
                        CustomButton(
                          text: '¿Qué es radiación solar?',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = now;
    final DateTime lastDate = DateTime(2025);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (DateTime date) {
        // Devuelve false si la fecha es anterior a hoy o posterior a 2025
        _focusNodeDate.unfocus();
        return date.isAfter(now.subtract(Duration(days: 1))) &&
            date.isBefore(lastDate.add(Duration(days: 1)));
      },
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    _focusNodeTime.unfocus();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final formattedTime =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      _timeController.text = formattedTime;
    }
  }
}
