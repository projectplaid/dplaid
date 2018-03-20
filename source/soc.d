module soc;

/** The peripheral base address on the Cortex-A15 */
enum int PERIPHERAL_BASE = 0x1e000000;

/** The Generic Interrupt Controller base address */
enum int GIC_DIST_BASE = PERIPHERAL_BASE + 0x1000;
/** The CPU controller base address */
enum int CPU_BASE = PERIPHERAL_BASE + 0x100;

enum int GICD_CTLR = GIC_DIST_BASE + 0x000;
enum int GICD_TYPER = GIC_DIST_BASE + 0x004;
