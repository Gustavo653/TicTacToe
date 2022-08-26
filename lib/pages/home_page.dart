import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String turn = 'O';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'O score: $oScore',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Turn: $turn',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'X score: $xScore',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                shrinkWrap: false,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () => _tapped(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          displayElement[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 80,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<void> _checkWinner() async {
    if (displayElement[0] == displayElement[1] &&
        displayElement[1] == displayElement[2]) {
      await _showDialog(
          'Vencedor', 'O vencedor do jogo foi: ${displayElement[0]}', 'Voltar');
      if (displayElement[0] == 'O') {
        oScore++;
      } else {
        xScore++;
      }
    }
  }

  Future<void> _tapped(int i) async {
    if (displayElement[i].isEmpty) {
      setState(() async {
        displayElement[i] = turn;
        await _checkWinner();
        turn = turn == 'O' ? 'X' : 'O';
      });
    } else {
      await _showDialog(
          'Ação inválida', 'Esta posição já está preenchida!', 'Voltar');
    }
  }

  Future<Widget> _showDialog(
    String title,
    String content,
    String button,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(button),
              ),
            ],
          );
        });
  }
}
