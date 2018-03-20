module interrupt;

import core.bitop;

import soc;

/**
 * initialize the ARM interrupt controller
 */
void interrupt_init()
{
    uint controller_type = volatileLoad(cast(uint*)GICD_TYPER);    
}
