dynamic getNum(String humanNum) {
  double noHumannum = 0;
  List restr = humanNum.split('.');
  List strNums = restr[0].split(',');
  String finalNum;
  if (strNums.length > 1) {
    String iniNum = '';

    for (var i in strNums) {
      iniNum += i;
    }
    finalNum = iniNum;
  } else {
    finalNum = restr[0];
  }
  String dec = '.';
  try {
    dec = dec + restr[1];
    if (dec.length < 3) {
      dec += '0';
    }
  } on RangeError {
    dec = '.00';
  }
  if (humanNum.contains('.')) {
    String ininoHumannum = finalNum.toString() + dec;
    noHumannum = double.parse(ininoHumannum);
  } else {
    noHumannum = double.parse(finalNum);
  }
  return noHumannum;
}

String humanizeNo(dynamic nonHumanNum) {
  String finalString = '';
  //if double
  if (nonHumanNum > 100000) {
  }
  double decimal = 0;
  if (nonHumanNum.runtimeType == double) {
    decimal = nonHumanNum - nonHumanNum.floor();
    nonHumanNum = nonHumanNum.floor();
    String sdecimal = decimal.toStringAsFixed(2);
    decimal = double.parse(sdecimal);
  }

  if (nonHumanNum >= 1000) {
    String nonHumanString = nonHumanNum.toString();
    int a = 0;
    int b = nonHumanString.length - 1;
    int c = 0;
    String ini = '';
    while (b >= a) {
      if (c < 2) {
        ini = nonHumanString[b] + ini;
        b -= 1;
        c += 1;
      } else {
        c = 0;
        ini = nonHumanString[b] + ini;
        finalString = ',' + ini + finalString;
        ini = '';

        b -= 1;
      }
      if (b == a) {
        ini = nonHumanString[b] + ini;
        finalString = ini + finalString;
        b -= 1;
      }
    }
  } else {
    finalString = nonHumanNum.toString();
  }
  String decimals = decimal.toString();
  while (decimals.length <= 3) {
    decimals += '0';
  }
  if (decimal >= 0) {
    finalString = finalString + decimals.substring(1);
  }
  return finalString;
}

String humanizeNo2(dynamic nonHumanNum) {
  String finalString = '';
  //if double
  if (nonHumanNum > 100000) {
  }
  double decimal = 0;
  if (nonHumanNum.runtimeType == double) {
    decimal = nonHumanNum - nonHumanNum.floor();
    nonHumanNum = nonHumanNum.floor();
    String sdecimal = decimal.toStringAsFixed(2);
    decimal = double.parse(sdecimal);
  }

  if (nonHumanNum >= 1000) {
    String nonHumanString = nonHumanNum.toString();
    int a = 0;
    int b = nonHumanString.length - 1;
    int c = 0;
    String ini = '';
    while (b >= a) {
      if (c < 2) {
        ini = nonHumanString[b] + ini;
        b -= 1;
        c += 1;
      } else {
        c = 0;
        ini = nonHumanString[b] + ini;
        finalString = ',' + ini + finalString;
        ini = '';

        b -= 1;
      }
      if (b == a) {
        ini = nonHumanString[b] + ini;
        finalString = ini + finalString;
        b -= 1;
      }
    }
  } else {
    finalString = nonHumanNum.toString();
  }
  finalString = finalString;
  return finalString;
}
