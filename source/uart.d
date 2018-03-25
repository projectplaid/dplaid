module uart;

import core.bitop;

enum ulong UART0 = 0x1c090000;
enum ulong UART_RSR = 0x004;
enum ulong UART_FR = 0x018;
enum ulong UART_ILPR = 0x020;
enum ulong UART_IBRD = 0x024;
enum ulong UART_FBRD = 0x028;
enum ulong UART_LCR_H = 0x02c;
enum ulong UART_CR = 0x030;
enum ulong UART_IFLS = 0x034;
enum ulong UART_IMSC = 0x038;
enum ulong UART_RIS = 0x03c;
enum ulong UART_MIS = 0x040;
enum ulong UART_ICR = 0x044;
enum ulong UART_DMACR = 0x048;

void mmio_write(ulong address, ulong data)
{
  volatileStore(cast(ulong*) address, data);
}

ulong mmio_read(ulong address)
{
  return volatileLoad(cast(ulong*) address);
}

void uart_init()
{
  mmio_write(UART0 + UART_CR, 0x00000000);

  // enable FIFOs
  mmio_write(UART0 + UART_LCR_H, (1 << 4));

  // Enable UART, Enable transmit, enable receive
  mmio_write(UART0 + UART_CR, (1 << 0) | (1 << 8) | (1 << 9));
}

void uart_write(char c)
{
  while (mmio_read(UART0 + UART_FR) & (1 << 5))
  {
  }
  mmio_write(UART0, c);
}

char uart_read()
{
  while (mmio_read(UART0 + UART_FR) & (1 << 4))
  {
  }
  return cast(char) volatileLoad(cast(ulong*) UART0);
}

void uart_write(string str)
{
  for (uint i; i < str.length; i++)
  {
    uart_write(str[i]);
  }
}

void uart_write(uint i)
{
  uint rb;
  uint rc;

  rb = 32;
  while (true)
  {
    rb -= 4;
    rc = (i >> rb) & 0xF;
    if (rc > 9)
    {
      rc += 0x37;
    } else {
      rc += 0x30;
    }
    uart_write(cast(char)rc);
    if (rb == 0) break;
  }
}