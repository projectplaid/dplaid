module soc;

import uart;

/** PERIPHBASE[39:15] is the GIC base address. PERIPHBASE comes from Configuration Base Address Register */
__gshared uint PERIPHERAL_BASE;

/** The Generic Interrupt Controller base address */
enum uint GIC_DIST_BASE = 0x2000;

enum uint GICD_CTLR = GIC_DIST_BASE + 0x000;
enum uint GICD_TYPER = GIC_DIST_BASE + 0x004;

/** The CPU controller base address */
enum uint CPU_BASE = 0x100;

extern (C) uint get_peripheral_base_address();

void soc_init()
{
    PERIPHERAL_BASE = get_peripheral_base_address();
}
