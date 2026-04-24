import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int perguntaAtual = 0;
  int pontuacao = 0;
  int? selecionado;

  final List<Map<String, dynamic>> perguntas = [
    {
      "pergunta": "Qual o primeiro computador digital construído?",
      "respostas": [
        "Robotinic",
        "ENIAC",
        "ABACO",
        "Máquina de calcular de Leibniz"
      ],
      "correta": 1
    },
    {
      "pergunta": "Quem é considerado o pai da computação?",
      "respostas": [
        "Alan Turing",
        "Charles Babbage",
        "Bill Gates",
        "Steve Jobs"
      ],
      "correta": 1
    },
    {
      "pergunta": "Qual foi a primeira linguagem de programação de alto nível?",
      "respostas": [
        "Assembly",
        "COBOL",
        "Fortran",
        "C"
      ],
      "correta": 2
    }
  ];

  void responder() {
    if (selecionado == perguntas[perguntaAtual]["correta"]) {
      pontuacao++;
    }

    setState(() {
      perguntaAtual++;
      selecionado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (perguntaAtual >= perguntas.length) {
      return Scaffold(
        backgroundColor: const Color(0xFFEAE7D6),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Você acertou $pontuacao de ${perguntas.length}",
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    perguntaAtual = 0;
                    pontuacao = 0;
                  });
                },
                child: const Text("Reiniciar"),
              )
            ],
          ),
        ),
      );
    }

    var pergunta = perguntas[perguntaAtual];

    return Scaffold(
      backgroundColor: const Color(0xFFEAE7D6),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1EEDB),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF3B3F1F),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: const Text(
                  "História da computação",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 15),

              Text("Questão nº ${perguntaAtual + 1}"),
              const SizedBox(height: 10),

              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/6/6a/Charles_Babbage_-_1860.jpg",
                ),
              ),

              const SizedBox(height: 10),

              Text(
                pergunta["pergunta"],
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              ...List.generate(pergunta["respostas"].length, (index) {
                return RadioListTile(
                  value: index,
                  groupValue: selecionado,
                  onChanged: (v) {
                    setState(() {
                      selecionado = v as int;
                    });
                  },
                  title: Text(pergunta["respostas"][index]),
                );
              }),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: selecionado == null ? null : responder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDCD7B5),
                ),
                child: const Text(
                  "Responder",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}