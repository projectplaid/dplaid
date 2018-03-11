module uart;

import core.bitop;

const ubyte* UART0 = cast(ubyte*)0x1c090000;

void uart_init() {
}

void uart_write(string str) {
  for (int i = 0; i < str.length; i++) {
    volatileStore(UART0, str[i]);
  }
}
