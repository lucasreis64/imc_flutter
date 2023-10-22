import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class IMC {
  double peso;
  double altura;

  IMC(this.peso, this.altura);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<IMC> listaDeIMCs = [];
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  String resultadoIMC = '';

  void calcularIMC() {
    final peso = double.tryParse(pesoController.text);
    final altura = double.tryParse(alturaController.text);

    if (peso != null && altura != null) {
      final imc = IMC(peso, altura);
      listaDeIMCs.add(imc);
      pesoController.clear();
      alturaController.clear();
      final imcCalculado = imc.peso / (imc.altura * imc.altura);
      setState(() {
        resultadoIMC = 'Seu IMC é: $imcCalculado';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
        ),
        body: Column(
          children: [
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
            ),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Altura (m)'),
            ),
            ElevatedButton(
              onPressed: calcularIMC,
              child: Text('Calcular IMC'),
            ),
            Text(
              resultadoIMC,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaDeIMCs.length,
                itemBuilder: (context, index) {
                  final imc = listaDeIMCs[index];
                  final resultadoIMC = imc.peso / (imc.altura * imc.altura);
                  return ListTile(
                    title:
                        Text('Peso: ${imc.peso} kg, Altura: ${imc.altura} m'),
                    subtitle: Text('IMC: $resultadoIMC'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
