class A {
  void printA() {
    print('A');
  }
}

class B {
  void printB() {
    print('B');
  }
}

class C with A, B {}

main() {
  var c = new C();
  c.printA();
  c.printB();
}
