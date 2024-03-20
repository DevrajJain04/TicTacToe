import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class Tictac extends StatefulWidget {
  const Tictac({super.key});

  @override
  State<Tictac> createState() => _TictacState();
}

class _TictacState extends State<Tictac> {
  var grid = ['', '', '', '', '', '', '', '', ''];

  var winner = '';
  late ConfettiController confettiController;
  @override
  void initState() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  var currentplayer = 'X';
  void drawxo(i) {
    if (grid[i] == '') {
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
      });

      findWinner(grid[i]);
    }
  }

  void reset() {
    setState(() {
      winner = '';
      grid = ['', '', '', '', '', '', '', '', ''];
    });
  }

  bool checkMove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    } else {
      return false;
    }
  }

  void findWinner(currentsign) {
    if (checkMove(0, 1, 2, currentsign) ||
        checkMove(3, 4, 5, currentsign) ||
        checkMove(6, 7, 8, currentsign) ||
        checkMove(0, 4, 8, currentsign) ||
        checkMove(2, 4, 6, currentsign) ||
        checkMove(0, 3, 6, currentsign) ||
        checkMove(1, 4, 7, currentsign) ||
        checkMove(2, 5, 8, currentsign)) {
      setState(() {
        winner = currentsign;
        show(winner);
        currentplayer = 'X';
        reset();
      });
    } else {
      if (grid[0] != '' &&
          grid[1] != '' &&
          grid[2] != '' &&
          grid[3] != '' &&
          grid[4] != '' &&
          grid[5] != '' &&
          grid[6] != '' &&
          grid[7] != '' &&
          grid[8] != '') {
        setState(() {
          winner = currentsign;
          showDraw();
          currentplayer = 'X';
          reset();
        });
      }
    }
  }

  void show(winner) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Column(
                children: [
                  Text(
                    '$winner has won',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  ConfettiWidget(
                    confettiController: confettiController,
                    numberOfParticles: 20,
                    maxBlastForce: 12,
                  )
                ],
              ),
            ),
          );
        });
  }

  void showDraw() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Center(
              child: Column(
                children: [
                  Text(
                    'Game is a draw',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.gamepad,
                color: Colors.white,
              ),
              Text(" Tic Tac Toe",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 72, 129),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
              margin: const EdgeInsets.all(20),
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: grid.length,
                    itemBuilder: (context, index) => Material(
                          color: Color.fromARGB(255, 97, 131, 160),
                          child: InkWell(
                            splashColor: const Color.fromARGB(255, 2, 72, 129),
                            onTap: () => drawxo(index),
                            child: Center(
                                child: Text(
                              grid[index],
                              style: const TextStyle(
                                  fontSize: 50, color: Colors.white),
                            )),
                          ),
                        )),
              ),
            ),
            Column(
              children: [
                ElevatedButton.icon(
                    onPressed: reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      "Reset Board ",
                      style: TextStyle(fontSize: 25),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        "Go back",
                        style: TextStyle(fontSize: 25),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
