module interrupt;

import core.bitop;

import soc;
import uart;

/**
 * initialize the ARM interrupt controller
 */
void interrupt_init()
{
    uart_write("Peripheral base address: ");
    uart_write(PERIPHERAL_BASE);
    uart_write("\r\n");

    uint controller_type = volatileLoad(cast(uint*)(PERIPHERAL_BASE + GICD_TYPER));    

    uart_write("Controller type: ");
    uart_write(controller_type);
    uart_write("\r\n");
 }
