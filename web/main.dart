import 'dart:async';
import 'dart:html';

final startDiv = querySelector('.start_main') as HtmlElement;
final startBtn = querySelector('#start_btn') as HtmlElement;
final suggestion = querySelector('#suggestion') as HtmlElement;
final options = querySelectorAll('.options') as List<HtmlElement>;
final dashboard = querySelector('.dashboard') as HtmlElement;
final option1 = querySelector('#option_1') as HtmlElement;
final option2 = querySelector('#option_2') as HtmlElement;
final option3 = querySelector('#option_3') as HtmlElement;
final player2Div = querySelector('.player_2') as HtmlElement;
final myOptionDiv = querySelector(".options_div") as HtmlElement;
final restartBtn = querySelector('#restart_btn') as HtmlElement;
final userScores = querySelector('#you_scores') as HtmlElement;
final computerScores = querySelector('#computer_scores') as HtmlElement;
final quitBtn = querySelector('#quit_btn') as HtmlElement;
final popupDiv = querySelector('#popup_div') as HtmlElement;
final cancel = querySelector('.cancel') as HtmlElement;
final mainDiv = querySelector('#main_div') as HtmlElement;
final okBtn = querySelector('.okBtn') as HtmlElement;
final instructions = querySelector('#instructions') as HtmlElement;
final instructinsDiv = querySelector('#instructions_div') as HtmlElement;
final startUpperDiv = querySelector('#start_upper_div') as HtmlElement;
final instDivBtn = querySelector('#btn') as HtmlElement;
final playAgainSug = querySelector('#play_again_sug') as HtmlElement;
final rock = querySelector('#rock') as HtmlElement;
final paper = querySelector('#paper') as HtmlElement;
final scissor = querySelector('#scissor') as HtmlElement;

final arr = [option1, option2, option3];
int setUserScores = 0;
int setCompScores = 0;
String? userSelectedOption;
String? CompSelectedOption;
final choices = ['R', 'P', 'S'];

bool IsTrue = false;

void player2(String choice) {
  for (var item in arr) {
    item.classes.remove('transform');
  }
  var randomNum = 0;

  while (true) {
    randomNum = (DateTime.now().millisecondsSinceEpoch % 3);
    if (choice != choices[randomNum]) {
      break;
    }
  }

  arr[randomNum].classes.add('transform');
  CompSelectedOption = choices[randomNum];
}

void main() {
  quitBtn.onClick.listen((event) {
    popupDiv.style.display = 'block';
    mainDiv.classes.add('main_div_before');
  });

  cancel.onClick.listen((event) {
    popupDiv.style.display = 'none';
    mainDiv.classes.remove('main_div_before');
  });

  okBtn.onClick.listen((event) {
    startDiv.style.display = 'flex';
    dashboard.style.display = 'none';
    mainDiv.classes.remove('main_div_before');
    popupDiv.style.display = 'none';
  });

  instructions.onClick.listen((event) {
    instructinsDiv.style.display = 'block';
    startUpperDiv.style.display = 'none';
  });

  instDivBtn.onClick.listen((event) {
    instructinsDiv.style.display = 'none';
    startUpperDiv.style.display = 'block';
  });

  startBtn.onClick.listen((event) {
    startDiv.style.display = 'none';
    dashboard.style.display = 'flex';
    mainDiv.style.display = 'block';
  });

  restartBtn.onClick.listen((event) {
    if (IsTrue) {
      myOptionDiv.style.display = 'flex';
      player2Div.style.display = 'none';
      suggestion.innerHtml = 'Make your move!';
      playAgainSug.style.display = 'none';

      for (var i = 0; i < options.length; i++) {
        options[i].classes.remove('transform');
        options[i].classes.add('transformIs');
        options[i].style.cursor = 'pointer';
      }
      IsTrue = false;
    }
  });

  void clickHandler(Event e, String choice) {
    final selectedOption = e.target as DivElement;
    game(selectedOption, choice);
  }

  rock.onClick.listen((e) {
    clickHandler(e, 'R');
  });

  paper.onClick.listen((e) {
    clickHandler(e, 'P');
  });

  scissor.onClick.listen((e) {
    clickHandler(e, 'S');
  });
}

void game(DivElement selectedOption, String choice) {
  for (var i = 0; i < options.length; i++) {
    options[i].classes.remove('transform');
    options[i].classes.remove('transformIs');
    options[i].style.cursor = 'not-allowed';
  }

  selectedOption.classes.add('transform');
  userSelectedOption = choice;
  suggestion.innerHtml = 'Good!';

  Timer(Duration(seconds: 1), () {
    for (var item in arr) {
      item.classes.remove('transform');
    }

    suggestion.innerHtml = "Now Computer's Turn!";
    myOptionDiv.style.display = 'none';
    player2Div.style.display = 'flex';
  });

  Timer(Duration(seconds: 2), () {
    suggestion.innerHtml = "Computer is choosing!";
  });

  Timer(Duration(seconds: 3), () {
    player2(choice);
  });

  Timer(Duration(seconds: 4), () {
    checkWinner();
  });

  Timer(Duration(seconds: 5), () {
    IsTrue = true;
  });
}

void win() {
  suggestion.innerHtml = 'You Win!';
  setUserScores++;
  userScores.innerHtml = setUserScores.toString();
  playAgainSug.style.display = 'block';
}

void lose() {
  suggestion.innerHtml = 'Computer Win!';
  setCompScores++;
  computerScores.innerHtml = setCompScores.toString();
  playAgainSug.style.display = 'block';
}

void draw() {
  suggestion.innerHtml = "Tie!";
  playAgainSug.style.display = 'block';
}

void checkWinner() {
  switch (userSelectedOption! + CompSelectedOption!) {
    case 'RS':
    case 'PR':
    case 'SP':
      win();
      break;
    case 'RP':
    case 'PS':
    case 'SR':
      lose();
      break;
    case 'RR':
    case 'PP':
    case 'SS':
      draw();
      break;
  }
}
