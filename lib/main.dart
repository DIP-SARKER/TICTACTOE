import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Root widget
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Arial', // Set custom font globally
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> board = List.filled(9, '');
  String turn = "✕";
  String prevturn = "✕";
  String name1 = "Player 1";
  String name2 = "Player 2";
  int score1 = 0, score2 = 0;

  void _draw(int index) {
    setState(() {
      if (board[index] == '') {
        if (turn == '✕') {
          board[index] = '✕';
          turn = '◯';
        } else {
          board[index] = '◯';
          turn = '✕';
        }
        String winner = checkWin();
        if (winner == 'Draw') {
          showWinnerDialog("It's a Draw");
        } else if (winner == name1 || winner == name2) {
          showWinnerDialog("$winner wins!");
        }
      }
    });
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      if (prevturn == '✕') {
        turn = '◯';
        prevturn = '◯';
      } else {
        turn = '✕';
        prevturn = '✕';
      }
    });
  }

  String checkWin() {
    if ((board[0] == "◯" && board[1] == "◯" && board[2] == "◯") ||
        (board[3] == "◯" && board[4] == "◯" && board[5] == "◯") ||
        (board[6] == "◯" && board[7] == "◯" && board[8] == "◯") ||
        (board[0] == "◯" && board[3] == "◯" && board[6] == "◯") ||
        (board[1] == "◯" && board[4] == "◯" && board[7] == "◯") ||
        (board[2] == "◯" && board[5] == "◯" && board[8] == "◯") ||
        (board[0] == "◯" && board[4] == "◯" && board[8] == "◯") ||
        (board[2] == "◯" && board[4] == "◯" && board[6] == "◯")) {
      score2++;
      return name2;
    } else if ((board[0] == "✕" && board[1] == "✕" && board[2] == "✕") ||
        (board[3] == "✕" && board[4] == "✕" && board[5] == "✕") ||
        (board[6] == "✕" && board[7] == "✕" && board[8] == "✕") ||
        (board[0] == "✕" && board[3] == "✕" && board[6] == "✕") ||
        (board[1] == "✕" && board[4] == "✕" && board[7] == "✕") ||
        (board[2] == "✕" && board[5] == "✕" && board[8] == "✕") ||
        (board[0] == "✕" && board[4] == "✕" && board[8] == "✕") ||
        (board[2] == "✕" && board[4] == "✕" && board[6] == "✕")) {
      score1++;
      return name1;
    } else {
      int filledCells = board.where((cell) => cell != '').length;
      if (filledCells == 9) {
        return 'Draw';
      } else {
        return '';
      }
    }
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          titleTextStyle: TextStyle(
            fontFamily: "CascadiaMono",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          content: Text(winner),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        toolbarHeight: 100,
        title: Text('Tic Tac Toe'),
        centerTitle: true,
        elevation: 25,
        shadowColor: Colors.indigo,
        titleTextStyle: TextStyle(
          fontSize: 40,
          fontFamily: 'LondrinaSketch', // Apply custom font to the app bar text
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/papertexture.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Column(
            children: [
              SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                resetGame();
                                score1 = 0;
                                score2 = 0;
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 20, bottom: 46),
                                child: Image(
                                  image: AssetImage('assets/reset.png'),
                                  height: 50,
                                  width: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '$name1: ×',
                          style: TextStyle(
                            fontFamily: "CascadiaMono",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '$name2: ◯',
                          style: TextStyle(
                            fontFamily: "CascadiaMono",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Score:$score1',
                          style: TextStyle(
                            fontFamily: "CascadiaMono",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        Text(
                          'Score:$score2',
                          style: TextStyle(
                            fontFamily: "CascadiaMono",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 80),
                              child: Text(
                                "$turn's turn",
                                style: TextStyle(
                                  fontFamily: "CascadiaMono",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 255, 17, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _draw(0);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[0],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _draw(1);
                        },
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[1],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _draw(2);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[2],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _draw(3);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[3],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _draw(4);
                        },
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[4],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _draw(5);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[5],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _draw(6);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[6],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _draw(7);
                        },
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[7],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _draw(8);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              board[8],
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
