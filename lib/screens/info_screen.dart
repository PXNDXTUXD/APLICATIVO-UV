import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: Text(
          '¿Qué es la radiación solar?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xffB0D4EF), Color(0xffEAF0FA)])),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 64),
              _buildSectionTitle('Definición'),
              _buildSectionContent(
                  'La radiación solar es la energía emitida por el sol en forma de luz y calor. Es esencial para la vida en la Tierra y tiene múltiples aplicaciones, como en la producción de energía solar.'),
              Divider(),
              _buildSectionTitle('Tipos de Radiación Solar'),
              _buildSectionContent(
                  '• Radiación Ultravioleta (UV): Es una forma de radiación no visible que puede causar daños en la piel y los ojos. Se clasifica en UV-A, UV-B y UV-C, siendo los UV-A y UV-B los que llegan a la superficie terrestre.\n• Radiación Visible: Es la luz que podemos ver y que permite la fotosíntesis en las plantas.\n• Radiación Infrarroja: Es percibida como calor y es responsable de la mayoría del calentamiento que experimentamos del sol.'),
              Image.asset(
                'assets/type_radiation-transformed.png',
                width: double.infinity,
              ),
              Divider(),
              _buildSectionTitle('Impacto en la Salud'),
              _buildSectionContent(
                  '• Piel: La exposición excesiva a la radiación UV puede causar quemaduras solares, envejecimiento prematuro de la piel y aumentar el riesgo de cáncer de piel.\n• Ojos: Puede provocar daños en los ojos, como cataratas y otras lesiones oculares.'),
              Divider(),
              _buildSectionTitle('Beneficios de la Radiación Solar'),
              _buildSectionContent(
                  '• Vitamina D: La exposición moderada a la radiación solar ayuda al cuerpo a producir vitamina D, esencial para la salud ósea.\n• Energía Solar: La radiación solar se utiliza en paneles solares para generar electricidad de manera sostenible.'),
              Divider(),
              _buildSectionTitle('Medidas de Protección'),
              _buildSectionContent(
                  '• Usar Protector Solar: Aplicar protector solar con un alto SPF para proteger la piel.\n• Ropa Protectora: Usar sombreros, gafas de sol y ropa que cubra la piel.\n• Buscar Sombra: Evitar la exposición al sol durante las horas pico (10 AM - 4 PM).'),
              Image.asset(
                'assets/medidas_proteccion.png',
                width: double.infinity,
              ),
              Divider(),
              _buildSectionTitle('Factores que Afectan la Radiación Solar'),
              _buildSectionContent(
                  '• Altitud: La radiación solar es más intensa a mayores altitudes.\n• Latitud: Las regiones cercanas al ecuador reciben más radiación solar.\n• Estaciones del Año: La radiación solar varía según la estación, siendo más fuerte en verano.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16),
    );
  }
}
