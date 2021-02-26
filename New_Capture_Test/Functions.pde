String substr(String s, int a, int b) {
  String ret = "";
  for(int i = a; i <= b; i ++)
    ret += s.charAt(i);
  return ret;
}

int power(int b, int p) {
  return (p == 0 ? 1 : b * power(b, --p));
}

int strToInt(String s) {
  int ret = 0;
  for(int i = 0; i < s.length(); i ++)
     ret += (s.charAt(i) - '0') * power(10, s.length() - i - 1);
  return ret;
}
