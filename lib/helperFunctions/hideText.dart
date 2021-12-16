String hidetext(String msg) {
  String temp = "";
  for (int i = 0; i < 25; i++) {
    temp = temp + msg[i];
  }

  print("ye h extra wale ki length " + temp.length.toString());
  return temp;
}
