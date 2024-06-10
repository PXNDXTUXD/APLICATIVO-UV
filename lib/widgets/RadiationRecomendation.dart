import 'package:flutter/material.dart';

class RadiationRecommendation extends StatelessWidget {
  final double prediction;

  RadiationRecommendation({required this.prediction});

  Widget _getRecommendationWidget(double prediction) {
    if (prediction <= 2) {
      return Text(
        'No es necesaria la protección solar.',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.justify,
      );
    } else if (prediction <= 5) {
      return Text(
        'Para actividades al aire libre, se pueden necesitar precauciones mínimas.',
        style: TextStyle(color: Colors.yellowAccent),
        textAlign: TextAlign.justify,
      );
    } else if (prediction <= 8) {
      return Text(
        'Para pocas actividades al aire libre y en ratos cortos, se recomienda el uso de protector solar',
        style: TextStyle(color: Colors.yellow),
        textAlign: TextAlign.justify,
      );
    } else if (prediction <= 11) {
      return Text(
        'Se recomienda poca exposición al sol. Utilizar protector solar y prendas que cubran la zona superior del cuerpo.',
        style: TextStyle(color: Colors.orangeAccent),
        textAlign: TextAlign.justify,
      );
    } else if (prediction <= 14) {
      return Text(
        'No se recomienda la exposición al sol. Utilizar protector solar, prendas y lentes de sol. Cubrirse con sombrillas o en lugares que tengan sombra.',
        style: TextStyle(color: Colors.orange),
        textAlign: TextAlign.justify,
      );
    } else {
      return Text(
        'Se recomienda no salir ni exponerse al sol. Utilizar máxima protección solar, prendas y sombrillas, lentes de sol. Se considera perjudicial la exposición al sol.',
        style: TextStyle(color: Colors.redAccent),
        textAlign: TextAlign.justify,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _getRecommendationWidget(prediction),
    );
  }
}
