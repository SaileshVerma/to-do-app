String hidetext(String msg) {
  String temp = "";
  for (int i = 0; i < 25; i++) {
    temp = temp + msg[i];
  }

  return temp;
}
