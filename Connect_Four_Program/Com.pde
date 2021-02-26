class Com {
  public Serial serial;
  public boolean ready;

  Com(String port, Connect_Four_Program _this, int baudRate) {
    serial = new Serial(_this, port, baudRate);
    ready = true;
  }
  
  void run() {
    if(!ready && serial.readChar() == 'e') {
      ready = true;
      println("recieved");
    }
  }
}
