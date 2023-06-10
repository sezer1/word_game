import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert'; 
import 'package:flutter/services.dart' show rootBundle; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int score = 0;
int checkCount = 0;
bool gameOver=false;
 int starteri=0;
 int starterj=0;
final List<String> trletters = ['A', 'B', 'C', 'Ç', 'D', 'E', 'F', 'G', 'Ğ', 'H', 'I', 'İ', 'J', 'K', 'L', 'M', 'N', 'O', 'Ö', 'P', 'R', 'S', 'Ş', 'T', 'U', 'Ü', 'V', 'Y', 'Z'];

List<int> scores = [];
int highScore = 0;

Future<List<String>> getWords() async {
  String jsonString = await rootBundle.loadString('words.json');
  List<dynamic> wordsJson = json.decode(jsonString)["words"];
  List<String> words = wordsJson.cast<String>();
  return words;
}

  String letter = '';
  List<List<String>> letters = List.generate(10, (index) => List.generate(8, (index) => ''));
  int currentRow = 0;
  int currentCol = 0;

  List<String> selectedLetters = [];
List<List<int>> selectedIndexes = [];
void selectLetter(int row, int col) {
  setState(() {
    if (letters[row][col] != '') {
      selectedLetters.add(letters[row][col]);
      selectedIndexes.add([row, col]);
 
    }
  });
}
void clearSelectedLetters() {
  setState(() {
    selectedLetters.clear();
  });
}
void checkcounter(){
generateRandomLetter();
 Timer.periodic(Duration(milliseconds: 500), (timer) => shiftLetterDown());
}

void checkWord() async {
  String word = selectedLetters.join('');
  List<String> words = await getWords();
  if (words.contains(word.toLowerCase())) {
    
       if (word.toLowerCase().contains('a')) {
        score += 1;
      }

      
       if (word.toLowerCase().contains('b')) {
        score += 3;
      }

      
       if (word.toLowerCase().contains('ç')) {
        score += 4;
      }

      
       if (word.toLowerCase().contains('d')) {
        score += 4;
      }

      
       if (word.toLowerCase().contains('e')) {
        score += 3;
      }

      
       if (word.toLowerCase().contains('f')) {
        score += 7;
      }

      
       if (word.toLowerCase().contains('g')) {
        score += 5;
      }

      
       if (word.toLowerCase().contains('ğ')) {
        score += 8;
      }

      
       if (word.toLowerCase().contains('h')) {
        score += 5;
      }

      
       if (word.toLowerCase().contains('ı')) {
        score += 2;
      }

      
       if (word.toLowerCase().contains('i')) {
        score += 1;
      }

       if (word.toLowerCase().contains('k')) {
        score += 10;
      }

       if (word.toLowerCase().contains('l')) {
        score += 1;
      }

       if (word.toLowerCase().contains('j')) {
        score += 1;
      }

       if (word.toLowerCase().contains('m')) {
        score += 2;
      }

       if (word.toLowerCase().contains('n')) {
        score += 1;
      }

       if (word.toLowerCase().contains('o')) {
        score += 2;
      }

       if (word.toLowerCase().contains('ö')) {
        score += 7;
      }


       if (word.toLowerCase().contains('p')) {
        score += 5;
      }

       if (word.toLowerCase().contains('r')) {
        score += 1;
      }

       if (word.toLowerCase().contains('s')) {
        score += 2;
      }

       if (word.toLowerCase().contains('ş')) {
        score += 4;
      }

       if (word.toLowerCase().contains('t')) {
        score += 1;
      }

         if (word.toLowerCase().contains('u')) {
        score += 2;
      }

   if (word.toLowerCase().contains('ü')) {
        score += 3;
      }

   if (word.toLowerCase().contains('v')) {
        score += 7;
      }

   if (word.toLowerCase().contains('y')) {
        score += 3;
      }

if (word.toLowerCase().contains('z')) {
        score += 4;
      }

    for (int i = 0; i < selectedIndexes.length; i++) {
      int row = selectedIndexes[i][0];
      int col = selectedIndexes[i][1];
      letters[row][col] = '';
    }
    for (int col = 0; col < 8; col++) {
      for (int row = 9; row > 0; row--) {
        if (letters[row][col] == '') {
          for (int r = row - 1; r >= 0; r--) {
            if (letters[r][col] != '') {
              letters[row][col] = letters[r][col];
              letters[r][col] = '';
              break;
            }
          }
        }
      }
    }
    selectedLetters.clear();
    selectedIndexes.clear();

    setState(() {
 
    });
  }else{
    checkCount++;
    
  }
}

  @override
  void initState() {
    super.initState();
   for ( starteri=0 ; starteri < 3; starteri++) {
    generateRandomLetter();
     for ( starterj=0 ; starterj < 9; starterj++){
 shiftLetterDown();
     }
  }
    Timer.periodic(Duration(seconds: 5), (timer) => singgenerateRandomLetter());
    if(score>100){
     Timer.periodic(Duration(seconds: 4), (timer) => singgenerateRandomLetter());
    }
     if(score>200){
     Timer.periodic(Duration(seconds: 3), (timer) => singgenerateRandomLetter());
    }
     if(score>300){
     Timer.periodic(Duration(seconds: 2), (timer) => singgenerateRandomLetter());
    }
     if(score>400){
     Timer.periodic(Duration(seconds: 1), (timer) => singgenerateRandomLetter());
    }
    Timer.periodic(Duration(milliseconds: 500), (timer) => singshiftLetterDown());
   
  }

 void endGame() {
   int finalScore = score;
  setState(() {
    gameOver = true;
     scores.add(score); 
    highScore = scores.reduce(max); 
  });
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Oyun Bitti"),
       
         content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('En yüksek: $highScore'),
          Text('Skorunuz: $score'),
          SizedBox(height: 20),
          Text('skorlar:'),
          SizedBox(height: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: scores.map((s) => Text(s.toString())).toList(),
          ),
        ],
      ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                gameOver = false;
                letters = List.generate(10, (index) => List.generate(8, (index) => ''));
                score = 0;
                checkCount = 0;
                selectedLetters.clear();
                starteri=0;
                starterj=0;
                  for ( starteri=0 ; starteri < 3; starteri++) {
                   generateRandomLetter();
                   for ( starterj=0 ; starterj < 9; starterj++){
                 shiftLetterDown();
                 }
                }
              });
              Navigator.of(context).pop();
            },
            child: Text(
              'Yeniden Başla',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      );
    },
  );
}



  void restartGame() {
  setState(() {
  gameOver=false;
  });
    initState();
}

void singgenerateRandomLetter() {
   
    Random random = Random();
    int row = 0;
    int col = random.nextInt(8);
    currentRow = row;
    currentCol = col;
    bool isOccupied = false;
    for (int i = 9; i >= 0; i--) {
      if (letters[i][col] != '') {
        currentRow = 0;
        isOccupied = true;
        break;
      }
    }
    if (!isOccupied) {
      currentRow = 0;
    }
    letter = trletters[random.nextInt(29)];
    letters[row][col] = letter;    
 
}
 void singshiftLetterDown() {
  setState(() {
  if(currentRow == 9){
      if (letters[currentRow][currentCol] != '') {  
       // singgenerateRandomLetter();
        return;
      }
      letters[currentRow][currentCol] = letter;
  }
     else {
      
      letters[currentRow][currentCol] = '';
      currentRow++;
      if (letters[currentRow][currentCol] != '') {
        currentRow--;
        letters[currentRow][currentCol] = letter;
      //  singgenerateRandomLetter();
        return;
      }
      letters[currentRow][currentCol] = letter;
      
    }

if(checkCount==3){
 for (int i = 0; i < 1; i++) {
    generateRandomLetter();
     for (int j = 0; j < 9; j++){
   shiftLetterDown();
     }
  }
   checkCount=0;
  }


  for (int col = 0; col < 7; col++) {
    if (letters[2][col] != '') {
      for (int col = 0; col < 7; col++) {
        if (letters[1][col] != '') {
          for (int col = 0; col < 7; col++) {
            if (letters[0][col] != '') {
              endGame();
              return;
            }
          }
        }
      }
    }
  } 
 
  }
 
  );
}


void generateRandomLetter() {
   
      Random random = Random();
  for (int col = 0; col < 8; col++) {
    letter = trletters[random.nextInt(29)];
    letters[0][col] = letter;
  } 
 
}
 void shiftLetterDown() {
  setState(() {
    for (int i = 7; i >= 0; i--) {
      for (int j = 9; j > 0; j--) {
        if (letters[j][i] == '') {
          letters[j][i] = letters[j - 1][i];
          letters[j - 1][i] = '';
        }
      }
      if (letters[0][i] != '') {
        if (letters[9][i] != '') {
         
          break;
        }
      }
    }
  });
}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Tetris kelime oyunu'),
    ),
    body: Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Score: $score',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Hata: $checkCount',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: letters == null
            ? Container()
            : GridView.count(
              crossAxisCount: 8,
              children: letters.expand((list) => list.map((item) => GestureDetector(
                onTap: () {
                  selectLetter(letters.indexOf(list), list.indexOf(item));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ))).toList(),
            ),
        ),
        SizedBox(height: 20),
        Container(
          height: 50,
          
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: selectedLetters.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  selectedLetters[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedLetters.clear();
                });
              },
              child: Text(
                'Clear',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                checkWord();
              },
              child: Text(
                'Check',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}