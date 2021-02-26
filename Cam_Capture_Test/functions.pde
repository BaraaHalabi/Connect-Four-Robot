double colorDiff(color c1, color c2) {
  return sqrt(pow(red(c2) - red(c1), 2) + pow(green(c2) - green(c1), 2)); 
}
