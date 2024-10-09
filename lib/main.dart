import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Calculadora(),
      ),
    ),
  );
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController _controlaX = TextEditingController();
  final TextEditingController _controlaY = TextEditingController();
  int resultado = 0;

  @override
  void initState() {
    super.initState();
    carrega();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _controlaX,
                  keyboardType: TextInputType.number, // Digitação de números
                  decoration: const InputDecoration(
                    labelText: 'Valor de X',
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _controlaY,
                  keyboardType: TextInputType.number, // Digitação de números
                  decoration: const InputDecoration(
                    labelText: 'Valor de Y',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: soma,
            child: const Text('Soma'),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Resultado: $resultado',
            style: const TextStyle(
              fontSize: 32,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: salva, child: const Text('Salva')),
              ElevatedButton(onPressed: limpa, child: const Text('Limpa')),
            ],
          ),
        ],
      ),
    );
  }

  void soma() {
    int _x = int.parse(_controlaX.text);
    int _y = int.parse(_controlaY.text);

    setState(() {
      resultado = _x + _y;
    });
  }

  void salva() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('resultado', resultado); // Salva o resultado
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resultado salvo com sucesso!')),
    );
  }

  void limpa() {
    setState(() {
      _controlaX.clear();
      _controlaY.clear();
      resultado = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Valores e resultado limpos!')),
    );
  }

  void carrega() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      resultado = prefs.getInt('resultado') ??
          0; // Carrega o resultado salvo, ou 0 se não houver
    });
  }
}
