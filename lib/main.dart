import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    setState(() {
      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Acima do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade grau II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade grau III (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: resetFields,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) return 'Insira seu peso';
                    return null;
                  }),
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) return 'Insira sua altura';
                    return null;
                  }),
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 26),
                ElevatedButton(
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      calculate();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
