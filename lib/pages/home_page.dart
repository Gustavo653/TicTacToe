import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color backgroundColor = Colors.white;
  Color themeColor = Colors.black;
  List<String> displayElement = [];
  int oScore = 0;
  int xScore = 0;
  String turn = 'O';

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    displayElement.removeRange(0, displayElement.length);
    displayElement.addAll(['', '', '', '', '', '', '', '', '']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'TicTacToe',
          style: TextStyle(
            color: themeColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              resetGame();
              oScore = 0;
              xScore = 0;
              setState(() {});
            },
            icon: Icon(
              Icons.restart_alt,
              color: themeColor,
            ),
          ),
          IconButton(
            onPressed: () {
              if (backgroundColor == Colors.white) {
                backgroundColor = Colors.black;
                themeColor = Colors.white;
              } else {
                backgroundColor = Colors.white;
                themeColor = Colors.black;
              }
              setState(() {});
            },
            icon: Icon(
              backgroundColor == Colors.white
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: themeColor,
            ),
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'O score: $oScore',
                    style: TextStyle(fontSize: 20, color: themeColor),
                  ),
                  Text(
                    'Turn: $turn',
                    style: TextStyle(fontSize: 20, color: themeColor),
                  ),
                  Text(
                    'X score: $xScore',
                    style: TextStyle(fontSize: 20, color: themeColor),
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
                          border: Border.all(
                            color: themeColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            displayElement[index],
                            style: TextStyle(
                              color: themeColor,
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
      ),
    );
  }

  Future<void> _checkGameStatus() async {
    bool isWinner = false;
    if (displayElement.where((element) => element == '').isEmpty) {
      await _showDialog('Tie', 'There is no winner!', 'Close');
      resetGame();
    }
    if (displayElement[0] == displayElement[1] &&
        displayElement[1] == displayElement[2] &&
        displayElement[0] != '') {
      isWinner = true;
    } else if (displayElement[3] == displayElement[4] &&
        displayElement[4] == displayElement[5] &&
        displayElement[3] != '') {
      isWinner = true;
    } else if (displayElement[6] == displayElement[7] &&
        displayElement[7] == displayElement[8] &&
        displayElement[6] != '') {
      isWinner = true;
    } else if (displayElement[0] == displayElement[3] &&
        displayElement[3] == displayElement[6] &&
        displayElement[0] != '') {
      isWinner = true;
    } else if (displayElement[1] == displayElement[4] &&
        displayElement[4] == displayElement[7] &&
        displayElement[1] != '') {
      isWinner = true;
    } else if (displayElement[2] == displayElement[5] &&
        displayElement[5] == displayElement[8] &&
        displayElement[2] != '') {
      isWinner = true;
    }
    if (isWinner) {
      await _showDialog('Winner',
          'The winner of the game was: ${turn == 'O' ? 'X' : 'O'}', 'Close');
      setState(() {
        if (displayElement[0] == 'O') {
          oScore++;
        } else {
          xScore++;
        }
        resetGame();
      });
    }
  }

  Future<void> _tapped(int i) async {
    if (displayElement[i].isEmpty) {
      setState(() {
        displayElement[i] = turn;
        turn = turn == 'O' ? 'X' : 'O';
      });
    } else {
      await _showDialog(
          'Invalid movement', 'This position has already been filled!', 'Close');
    }
    await _checkGameStatus();
  }

  Future<void> _showDialog(
    String? title,
    String? content,
    String? button,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            title: Text(
              title ?? '',
              style: TextStyle(
                color: themeColor,
              ),
            ),
            content: Text(
              content ?? '',
              style: TextStyle(
                color: themeColor,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  button ?? '',
                  style: TextStyle(
                    color: themeColor,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
