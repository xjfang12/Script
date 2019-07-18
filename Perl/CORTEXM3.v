//------------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2004-2010 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//  Revision            : $Revision: 143211 $
//  Release information : CORTEXM3-r2p1-00rel0
//
//------------------------------------------------------------------------------
// Purpose: CORTEX-M3 MCU
//------------------------------------------------------------------------------

`ifdef ARM_DSM
`timescale 1ps/1ps
`endif

module CORTEXM3
  (// Inputs
   PORESETn, SYSRESETn, FCLK, HCLK, STCLK, STCALIB, BIGEND, INTISR, INTNMI, RXEV,
   EDBGRQ, HREADYI, HRDATAI, HRESPI, IFLUSH, HREADYD, HRDATAD, HRESPD, EXRESPD,
   HREADYS, HRDATAS, HRESPS, EXRESPS, PRDATA, PREADY, PSLVERR, DAPEN, DAPCLKEN,
   DAPCLK, DAPRESETn, DAPSEL, DAPENABLE, DAPWRITE, DAPABORT, DAPADDR, DAPWDATA,
   SE, ATREADY, PPBLOCK, VECTADDR, VECTADDREN, ETMPWRUP, ETMFIFOFULL, TPIUACTV,
   TPIUBAUD, AUXFAULT, DNOTITRANS, DBGRESTART, SLEEPHOLDREQn, RSTBYPASS,
   CGBYPASS, STKALIGNINIT, WICDSREQn, FIXMASTERTYPE, TSVALUEB, TSCLKCHANGE,
   MPUDISABLE, DBGEN,
   // Outputs
   SYSRESETREQ, TXEV, HTRANSI, HSIZEI, HADDRI, HBURSTI, HPROTI, MEMATTRI,
   HMASTERD, HTRANSD, HSIZED, HADDRD, HBURSTD, HPROTD, MEMATTRD, EXREQD, HWRITED,
   HWDATAD, HMASTERS, HTRANSS, HWRITES, HSIZES, HMASTLOCKS, HADDRS, HWDATAS,
   HBURSTS, HPROTS, MEMATTRS, EXREQS, PADDR31, PADDR, PSEL, PENABLE, PWRITE,
   PWDATA, DAPREADY, DAPSLVERR, DAPRDATA, ATVALID, AFREADY, ATDATA, ETMTRIGGER,
   ETMTRIGINOTD, ETMIVALID, ETMISTALL, ETMDVALID, ETMFOLD, ETMCANCEL, ETMIA,
   ETMICCFAIL, ETMIBRANCH, ETMIINDBR, ETMISB, ETMINTSTAT, ETMINTNUM, ETMFLUSH,
   ETMFINDBR, DSYNC, HTMDHADDR, HTMDHTRANS, HTMDHSIZE, HTMDHBURST, HTMDHPROT,
   HTMDHWDATA, HTMDHWRITE, HTMDHRDATA, HTMDHREADY, HTMDHRESP, ATIDITM, BRCHSTAT,
   HALTED, DBGRESTARTED, LOCKUP, SLEEPING, SLEEPDEEP, SLEEPHOLDACKn, CURRPRI,
   TRCENA, INTERNALSTATE, WICDSACKn, WICLOAD, WICCLEAR, WICMASKISR, WICMASKMON,
   WICMASKNMI, WICMASKRXEV
`ifdef ARM_DSM
   // DSM Programmer's model
   , dsm_pc, dsm_r0, dsm_r1, dsm_r2, dsm_r3, dsm_r4, dsm_r5, dsm_r6, dsm_r7,
   dsm_r8, dsm_r9, dsm_r10, dsm_r11, dsm_r12, dsm_r13, dsm_r14, dsm_cpsr,
   dsm_ClkCount, dsm_scs_actlr, dsm_scs_cpuid, dsm_scs_icsr, dsm_scs_vtor,
   dsm_scs_aircr, dsm_scs_scr, dsm_scs_ccr, dsm_scs_shpr1, dsm_scs_shpr2,
   dsm_scs_shpr3, dsm_scs_shcsr, dsm_scs_cfsr, dsm_scs_hfsr, dsm_scs_dfsr,
   dsm_scs_mmfar, dsm_scs_bfar, dsm_scs_afsr, dsm_scs_cpacr, dsm_scs_dhcsr,
   dsm_scs_dcrdr, dsm_scs_demcr, dsm_syst_csr, dsm_syst_rvr, dsm_syst_cvr,
   dsm_syst_calib, dsm_nvic_ictr,
   dsm_nvic_iser0, dsm_nvic_iser1, dsm_nvic_iser2, dsm_nvic_iser3,
   dsm_nvic_iser4, dsm_nvic_iser5, dsm_nvic_iser6, dsm_nvic_iser7,
   dsm_nvic_icer0, dsm_nvic_icer1, dsm_nvic_icer2, dsm_nvic_icer3,
   dsm_nvic_icer4, dsm_nvic_icer5, dsm_nvic_icer6, dsm_nvic_icer7,
   dsm_nvic_ispr0, dsm_nvic_ispr1, dsm_nvic_ispr2, dsm_nvic_ispr3,
   dsm_nvic_ispr4, dsm_nvic_ispr5, dsm_nvic_ispr6, dsm_nvic_ispr7,
   dsm_nvic_icpr0, dsm_nvic_icpr1, dsm_nvic_icpr2, dsm_nvic_icpr3,
   dsm_nvic_icpr4, dsm_nvic_icpr5, dsm_nvic_icpr6, dsm_nvic_icpr7,
   dsm_nvic_iabr0, dsm_nvic_iabr1, dsm_nvic_iabr2, dsm_nvic_iabr3,
   dsm_nvic_iabr4, dsm_nvic_iabr5, dsm_nvic_iabr6, dsm_nvic_iabr7,
   dsm_nvic_ipr0, dsm_nvic_ipr1, dsm_nvic_ipr2, dsm_nvic_ipr3,
   dsm_nvic_ipr4, dsm_nvic_ipr5, dsm_nvic_ipr6, dsm_nvic_ipr7,
   dsm_nvic_ipr8, dsm_nvic_ipr9, dsm_nvic_ipr10, dsm_nvic_ipr11,
   dsm_nvic_ipr12, dsm_nvic_ipr13, dsm_nvic_ipr14, dsm_nvic_ipr15,
   dsm_nvic_ipr16, dsm_nvic_ipr17, dsm_nvic_ipr18, dsm_nvic_ipr19,
   dsm_nvic_ipr20, dsm_nvic_ipr21, dsm_nvic_ipr22, dsm_nvic_ipr23,
   dsm_nvic_ipr24, dsm_nvic_ipr25, dsm_nvic_ipr26, dsm_nvic_ipr27,
   dsm_nvic_ipr28, dsm_nvic_ipr29, dsm_nvic_ipr30, dsm_nvic_ipr31,
   dsm_nvic_ipr32, dsm_nvic_ipr33, dsm_nvic_ipr34, dsm_nvic_ipr35,
   dsm_nvic_ipr36, dsm_nvic_ipr37, dsm_nvic_ipr38, dsm_nvic_ipr39,
   dsm_nvic_ipr40, dsm_nvic_ipr41, dsm_nvic_ipr42, dsm_nvic_ipr43,
   dsm_nvic_ipr44, dsm_nvic_ipr45, dsm_nvic_ipr46, dsm_nvic_ipr47,
   dsm_nvic_ipr48, dsm_nvic_ipr49, dsm_nvic_ipr50, dsm_nvic_ipr51,
   dsm_nvic_ipr52, dsm_nvic_ipr53, dsm_nvic_ipr54, dsm_nvic_ipr55,
   dsm_nvic_ipr56, dsm_nvic_ipr57, dsm_nvic_ipr58, dsm_nvic_ipr59,
   dsm_mpu_ctrl, dsm_mpu_rnr, dsm_mpu_rbar, dsm_mpu_rasr,
   // DSM tarmac
   dsm_ID, dsm_echo_to_stdout, dsm_no_tarmac, dsm_no_ecs,
   // DSM configuration control
   dsm_mpu_present, dsm_num_irq, dsm_lvl_width, dsm_trace_lvl, dsm_debug_lvl,
   dsm_clkgate_present, dsm_reset_all_regs, dsm_observation, dsm_wic_present,
   dsm_wic_lines, dsm_bb_present, dsm_const_ahb_ctrl
`endif
  );

  //----------------------------------------------------------------------------
  // Parameters
  //----------------------------------------------------------------------------
  parameter MPU_PRESENT     = 0;  // MPU present if 1
  parameter NUM_IRQ         = 16; // Number of interrupts. Between 1 and 240
  parameter LVL_WIDTH       = 3;  // Interrupt priority width. Between 3 and 8
  parameter TRACE_LVL       = 1;  // Trace support level. Between 0 and 3
  parameter DEBUG_LVL       = 3;  // Debug support level. Between 0 and 3
  parameter CLKGATE_PRESENT = 0;  // Architectural clock gating present if 1
  parameter RESET_ALL_REGS  = 0;  // Reset all registers if 1
  parameter OBSERVATION     = 0;  // Allow internal observation if 1
  parameter WIC_PRESENT     = 0;  // WIC present if 1
  parameter WIC_LINES       = 3;  // Number of WIC lines. Between 3 and 243
  parameter BB_PRESENT      = 1;  // Bit banding present if 1
  parameter CONST_AHB_CTRL  = 0;  // Constant AHB control info if 1

  //----------------------------------------------------------------------------
  // Port declarations
  //----------------------------------------------------------------------------

  // Clocks and resets
  input          PORESETn;           // PowerOn reset
  input          SYSRESETn;          // System reset
  input          FCLK;               // Free-running clock
  input          HCLK;               // Main clock
  input          STCLK;              // System Tick enable
  input          DAPCLK;             // DAP clock
  input          DAPCLKEN;           // DAP clock enable
  input          DAPRESETn;          // DAP reset

  // ICode bus
  input          HREADYI;            // ICode ready
  input   [31:0] HRDATAI;            // ICode read data
  input    [1:0] HRESPI;             // ICode transfer response
  input          IFLUSH;             // ICode buffer flush

  // DCode bus
  input          HREADYD;            // DCode ready
  input   [31:0] HRDATAD;            // DCode read data
  input    [1:0] HRESPD;             // DCode transfer response
  input          EXRESPD;            // DCode exclusive response

  // System bus
  input          HREADYS;            // System ready
  input   [31:0] HRDATAS;            // System read data
  input    [1:0] HRESPS;             // System transfer response
  input          EXRESPS;            // System exclusive response

  // External PPB
  input   [31:0] PRDATA;             // PPB read data
  input          PREADY;             // PPB ready
  input          PSLVERR;            // PPB slave error

  // DAP
  input          DAPEN;              // DAP enable
  input          DAPSEL;             // DAP select
  input          DAPENABLE;          // DAP enable
  input          DAPWRITE;           // DAP write
  input          DAPABORT;           // DAP abort
  input   [31:0] DAPADDR;            // DAP address
  input   [31:0] DAPWDATA;           // DAP write data
  input          FIXMASTERTYPE;      // Force HMASTER setting for AHB-AP accesses

  // Interrupts interface
  input  [239:0] INTISR;             // Interrupts
  input          INTNMI;             // Non-maskable interrupt

  // WIC interface
  input          WICDSREQn;          // Use WIC Request

  // ATB interface
  input          ATREADY;            // ATB Ready

  // Events
  input          RXEV;               // Wait for event input

  // ETM interface
  input          ETMPWRUP;           // ETM enabled
  input          ETMFIFOFULL;        // ETM FIFO is full

  // Debug
  input          EDBGRQ;             // External debug request
  input          DBGRESTART;         // External debug restart request

  // TPIU interface
  input          TPIUACTV;           // TPIU has data
  input          TPIUBAUD;           // Unsynchronised baud indicator from TPIU

  // Sleep interface
  input          SLEEPHOLDREQn;      // Hold core in sleep mode

  // Auxiliary fault status
  input   [31:0] AUXFAULT;           // Auxillary FSR pulse inputs

  // Test interface
  input          SE;                 // Scan enable
  input          RSTBYPASS;          // Reset Bypass
  input          CGBYPASS;           // Architectural clock gate bypass

  // Configuration inputs
  input   [25:0] STCALIB;            // System Tick calibration
  input          BIGEND;             // Static endianess select
  input          DNOTITRANS;         // D/ICODE arbitration
  input          STKALIGNINIT;       // STKALIGN reset value

  // Miscellaneous
  input    [5:0] PPBLOCK;            // PPB Lock
  input    [9:0] VECTADDR;           // Vector address overwrite value
  input          VECTADDREN;         // Enable IntAddr -> VECTADDR overwrite

  // Global timestamp interface
  input [47:0]   TSVALUEB;            // Binary coded timestamp count
  input          TSCLKCHANGE;        // Pulse when TS clock ratio changes

  // Logic disable
  input          MPUDISABLE;         // Disable the MPU (act as default)
  input          DBGEN;              // Enable debug

  // ICode bus
  output  [31:0] HADDRI;             // ICode address
  output   [1:0] HTRANSI;            // ICode transfer type
  output   [2:0] HSIZEI;             // ICode transfer size
  output   [2:0] HBURSTI;            // ICode burst length
  output   [3:0] HPROTI;             // ICode protection
  output   [1:0] MEMATTRI;           // ICode memory attributes
  output   [3:0] BRCHSTAT;           // Branch status hint

  // DCode bus
  output  [31:0] HADDRD;             // DCode address
  output   [1:0] HTRANSD;            // DCode transfer type
  output   [1:0] HMASTERD;           // DCode master
  output   [2:0] HSIZED;             // DCode transfer size
  output   [2:0] HBURSTD;            // DCode burst length
  output   [3:0] HPROTD;             // DCode protection
  output   [1:0] MEMATTRD;           // DCode memory attributes
  output         EXREQD;             // DCode exclusive request
  output         HWRITED;            // DCode write not read
  output  [31:0] HWDATAD;            // DCode write data

  // System bus
  output  [31:0] HADDRS;             // System address
  output   [1:0] HTRANSS;            // System transfer type
  output   [1:0] HMASTERS;           // System master
  output         HWRITES;            // System write not read
  output   [2:0] HSIZES;             // System transfer size
  output         HMASTLOCKS;         // System lock
  output  [31:0] HWDATAS;            // System write data
  output   [2:0] HBURSTS;            // System burst length
  output   [3:0] HPROTS;             // System protection
  output   [1:0] MEMATTRS;           // System memory attributes
  output         EXREQS;             // System exclusive request

  // External PPB
  output         PSEL;               // PPB External select
  output         PADDR31;            // PPB External address, bit 31
  output  [19:2] PADDR;              // PPB External address
  output         PENABLE;            // PPB External enable
  output         PWRITE;             // PPB External write not read
  output  [31:0] PWDATA;             // PPB External write data

  // DAP
  output         DAPREADY;           // DAP transfer response
  output         DAPSLVERR;          // DAP slave error
  output  [31:0] DAPRDATA;           // DAP read data

  // WIC interface
  output         WICDSACKn;          // WIC mode acknowledge
  output         WICLOAD;            // Load wake-up sensitiviy list into WIC
  output         WICCLEAR;           // Clear WIC sensitivity list
  output [239:0] WICMASKISR;         // WIC IRQ sensitivity list
  output         WICMASKMON;         // WIC DBG MON sensitivity
  output         WICMASKNMI;         // WIC NMI sensitivity
  output         WICMASKRXEV;        // WIC RXEV sensitivity

  // ATB interface
  output         ATVALID;            // ATB Valid
  output         AFREADY;            // ATB Flush
  output   [7:0] ATDATA;             // ATB Data

  // Events
  output         TXEV;               // Event transmitted
  output         SYSRESETREQ;        // System reset request

  // ETM interface
  output  [3:0]  ETMTRIGGER;         // DWT generated trigger
  output  [3:0]  ETMTRIGINOTD;       // ETM trigger on I match
  output         ETMIVALID;          // Instruction valid
  output         ETMISTALL;          // Instruction stall
  output         ETMDVALID;          // Data valid
  output         ETMFOLD;            // Instruction is folded
  output         ETMCANCEL;          // Instruction cancelled
  output  [31:1] ETMIA;              // PC to ETM
  output         ETMICCFAIL;         // Instruction failed condition code
  output         ETMIBRANCH;         // Instruction is Branch
  output         ETMIINDBR;          // Instruction is indirect branch
  output         ETMISB;             // Instruction is ISB
  output   [2:0] ETMINTSTAT;         // ETM interrupt status
  output   [8:0] ETMINTNUM;          // ETM interrupt number
  output         ETMFLUSH;           // Pipe flush hint
  output         ETMFINDBR;          // Flush indirect branch
  output         DSYNC;              // Sync packet generation trigger

  // Debug
  output         DBGRESTARTED;       // External Debug Restart Ready

  // HTM interface
  output  [31:0] HTMDHADDR;          // HTM data HADDR
  output   [1:0] HTMDHTRANS;         // HTM data HTRANS
  output   [2:0] HTMDHSIZE;          // HTM data HSIZE
  output   [2:0] HTMDHBURST;         // HTM data HBURST
  output   [3:0] HTMDHPROT;          // HTM data HPROT
  output  [31:0] HTMDHWDATA;         // HTM data HWDATA
  output         HTMDHWRITE;         // HTM data HWRITE
  output  [31:0] HTMDHRDATA;         // HTM data HRDATA
  output         HTMDHREADY;         // HTM data HREADY
  output   [1:0] HTMDHRESP;          // HTM data HRESP

  // ITM interface
  output  [6:0]  ATIDITM;            // ITM ID for TPIU

  // Sleep interface
  output         SLEEPHOLDACKn;      // Core is held in sleepmode
  output         SLEEPING;           // Core is Sleeping
  output         SLEEPDEEP;          // System can enter Deep sleep

  // Core status
  output         HALTED;             // Core is Stopped
  output         LOCKUP;             // Core is Locked Up
  output   [7:0] CURRPRI;            // Current INT priority
  output         TRCENA;             // Trace Enable

  // Extended visibility signals
  output [148:0] INTERNALSTATE;     // Exported internal state

  //----------------------------------------------------------------------------
  // DSM port declarations
  //----------------------------------------------------------------------------

`ifdef ARM_DSM

  // DSM  Programmers model:
  // DPU register bank and flags
  output  [31:0] dsm_pc;
  output  [31:0] dsm_r0;
  output  [31:0] dsm_r1;
  output  [31:0] dsm_r2;
  output  [31:0] dsm_r3;
  output  [31:0] dsm_r4;
  output  [31:0] dsm_r5;
  output  [31:0] dsm_r6;
  output  [31:0] dsm_r7;
  output  [31:0] dsm_r8;
  output  [31:0] dsm_r9;
  output  [31:0] dsm_r10;
  output  [31:0] dsm_r11;
  output  [31:0] dsm_r12;
  output  [31:0] dsm_r13;
  output  [31:0] dsm_r14;
  output  [31:0] dsm_cpsr;
  output  [31:0] dsm_ClkCount;

  // SCS registers
  output  [31:0] dsm_scs_actlr;
  output  [31:0] dsm_scs_cpuid;
  output  [31:0] dsm_scs_icsr;
  output  [31:0] dsm_scs_vtor;
  output  [31:0] dsm_scs_aircr;
  output  [31:0] dsm_scs_scr;
  output  [31:0] dsm_scs_ccr;
  output  [31:0] dsm_scs_shpr1;
  output  [31:0] dsm_scs_shpr2;
  output  [31:0] dsm_scs_shpr3;
  output  [31:0] dsm_scs_shcsr;
  output  [31:0] dsm_scs_cfsr;
  output  [31:0] dsm_scs_hfsr;
  output  [31:0] dsm_scs_dfsr;
  output  [31:0] dsm_scs_mmfar;
  output  [31:0] dsm_scs_bfar;
  output  [31:0] dsm_scs_afsr;
  output  [31:0] dsm_scs_cpacr;
  output  [31:0] dsm_scs_dhcsr;
  output  [31:0] dsm_scs_dcrdr;
  output  [31:0] dsm_scs_demcr;

  // System Timer registers
  output  [31:0] dsm_syst_csr;
  output  [31:0] dsm_syst_rvr;
  output  [31:0] dsm_syst_cvr;
  output  [31:0] dsm_syst_calib;

  // NVIC registers
  output  [31:0] dsm_nvic_ictr;
  output  [31:0] dsm_nvic_iser0;
  output  [31:0] dsm_nvic_iser1;
  output  [31:0] dsm_nvic_iser2;
  output  [31:0] dsm_nvic_iser3;
  output  [31:0] dsm_nvic_iser4;
  output  [31:0] dsm_nvic_iser5;
  output  [31:0] dsm_nvic_iser6;
  output  [31:0] dsm_nvic_iser7;
  output  [31:0] dsm_nvic_icer0;
  output  [31:0] dsm_nvic_icer1;
  output  [31:0] dsm_nvic_icer2;
  output  [31:0] dsm_nvic_icer3;
  output  [31:0] dsm_nvic_icer4;
  output  [31:0] dsm_nvic_icer5;
  output  [31:0] dsm_nvic_icer6;
  output  [31:0] dsm_nvic_icer7;
  output  [31:0] dsm_nvic_ispr0;
  output  [31:0] dsm_nvic_ispr1;
  output  [31:0] dsm_nvic_ispr2;
  output  [31:0] dsm_nvic_ispr3;
  output  [31:0] dsm_nvic_ispr4;
  output  [31:0] dsm_nvic_ispr5;
  output  [31:0] dsm_nvic_ispr6;
  output  [31:0] dsm_nvic_ispr7;
  output  [31:0] dsm_nvic_icpr0;
  output  [31:0] dsm_nvic_icpr1;
  output  [31:0] dsm_nvic_icpr2;
  output  [31:0] dsm_nvic_icpr3;
  output  [31:0] dsm_nvic_icpr4;
  output  [31:0] dsm_nvic_icpr5;
  output  [31:0] dsm_nvic_icpr6;
  output  [31:0] dsm_nvic_icpr7;
  output  [31:0] dsm_nvic_iabr0;
  output  [31:0] dsm_nvic_iabr1;
  output  [31:0] dsm_nvic_iabr2;
  output  [31:0] dsm_nvic_iabr3;
  output  [31:0] dsm_nvic_iabr4;
  output  [31:0] dsm_nvic_iabr5;
  output  [31:0] dsm_nvic_iabr6;
  output  [31:0] dsm_nvic_iabr7;
  output  [31:0] dsm_nvic_ipr0;
  output  [31:0] dsm_nvic_ipr1;
  output  [31:0] dsm_nvic_ipr2;
  output  [31:0] dsm_nvic_ipr3;
  output  [31:0] dsm_nvic_ipr4;
  output  [31:0] dsm_nvic_ipr5;
  output  [31:0] dsm_nvic_ipr6;
  output  [31:0] dsm_nvic_ipr7;
  output  [31:0] dsm_nvic_ipr8;
  output  [31:0] dsm_nvic_ipr9;
  output  [31:0] dsm_nvic_ipr10;
  output  [31:0] dsm_nvic_ipr11;
  output  [31:0] dsm_nvic_ipr12;
  output  [31:0] dsm_nvic_ipr13;
  output  [31:0] dsm_nvic_ipr14;
  output  [31:0] dsm_nvic_ipr15;
  output  [31:0] dsm_nvic_ipr16;
  output  [31:0] dsm_nvic_ipr17;
  output  [31:0] dsm_nvic_ipr18;
  output  [31:0] dsm_nvic_ipr19;
  output  [31:0] dsm_nvic_ipr20;
  output  [31:0] dsm_nvic_ipr21;
  output  [31:0] dsm_nvic_ipr22;
  output  [31:0] dsm_nvic_ipr23;
  output  [31:0] dsm_nvic_ipr24;
  output  [31:0] dsm_nvic_ipr25;
  output  [31:0] dsm_nvic_ipr26;
  output  [31:0] dsm_nvic_ipr27;
  output  [31:0] dsm_nvic_ipr28;
  output  [31:0] dsm_nvic_ipr29;
  output  [31:0] dsm_nvic_ipr30;
  output  [31:0] dsm_nvic_ipr31;
  output  [31:0] dsm_nvic_ipr32;
  output  [31:0] dsm_nvic_ipr33;
  output  [31:0] dsm_nvic_ipr34;
  output  [31:0] dsm_nvic_ipr35;
  output  [31:0] dsm_nvic_ipr36;
  output  [31:0] dsm_nvic_ipr37;
  output  [31:0] dsm_nvic_ipr38;
  output  [31:0] dsm_nvic_ipr39;
  output  [31:0] dsm_nvic_ipr40;
  output  [31:0] dsm_nvic_ipr41;
  output  [31:0] dsm_nvic_ipr42;
  output  [31:0] dsm_nvic_ipr43;
  output  [31:0] dsm_nvic_ipr44;
  output  [31:0] dsm_nvic_ipr45;
  output  [31:0] dsm_nvic_ipr46;
  output  [31:0] dsm_nvic_ipr47;
  output  [31:0] dsm_nvic_ipr48;
  output  [31:0] dsm_nvic_ipr49;
  output  [31:0] dsm_nvic_ipr50;
  output  [31:0] dsm_nvic_ipr51;
  output  [31:0] dsm_nvic_ipr52;
  output  [31:0] dsm_nvic_ipr53;
  output  [31:0] dsm_nvic_ipr54;
  output  [31:0] dsm_nvic_ipr55;
  output  [31:0] dsm_nvic_ipr56;
  output  [31:0] dsm_nvic_ipr57;
  output  [31:0] dsm_nvic_ipr58;
  output  [31:0] dsm_nvic_ipr59;

  // MPU registers
  output  [31:0] dsm_mpu_ctrl;
  output  [31:0] dsm_mpu_rnr;
  output  [31:0] dsm_mpu_rbar;
  output  [31:0] dsm_mpu_rasr;

  // DSM disass
  input    [2:0] dsm_ID;
  input          dsm_echo_to_stdout;
  input          dsm_no_tarmac;
  input          dsm_no_ecs;

  // DSM configuration control
  input          dsm_mpu_present;
  input    [7:0] dsm_num_irq;
  input    [3:0] dsm_lvl_width;
  input    [1:0] dsm_trace_lvl;
  input    [1:0] dsm_debug_lvl;
  input          dsm_clkgate_present;
  input          dsm_reset_all_regs;
  input          dsm_observation;
  input          dsm_wic_present;
  input    [7:0] dsm_wic_lines;
  input          dsm_bb_present;
  input          dsm_const_ahb_ctrl;

`endif

  //----------------------------------------------------------------------------
  // Signal declarations
  //----------------------------------------------------------------------------

  // Internal clocks
  wire           dclk_gated;              // Gated debug clock
  wire           pclk_gated;              // Gated PPB clock
  wire           i_dclk_gated;            // Mux term for dclk_gated
  wire           i_pclk_gated;            // Mux term for pclk_gated

  // Local resets
  wire           hreset_n;                // Main reset
  wire           dreset_n;                // Debug reset
  wire           dpu_vect_reset_n;        // System reset

  // Miscellaneous
  wire     [3:0] dpu_branch_stat;

  // ICode
  wire    [31:0] mtx_ahb_haddri;          // ICode address
  wire     [1:0] mtx_ahb_htransi;         // ICode transfer type
  wire     [2:0] mtx_ahb_hsizei;          // ICode transfer size
  wire     [2:0] mtx_ahb_hbursti;         // ICode burst length
  wire     [3:0] mtx_ahb_hproti;          // ICode protection
  wire     [1:0] mtx_mem_attri;           // ICode memory attributes

  // DCode
  wire    [31:0] mtx_ahb_haddrd;          // DCode address
  wire     [1:0] mtx_ahb_htransd;         // DCode transfer type
  wire     [1:0] mtx_ahb_hmasterd;        // DCode master
  wire     [2:0] mtx_ahb_hsized;          // DCode transfer size
  wire     [2:0] mtx_ahb_hburstd;         // DCode burst length
  wire     [3:0] mtx_ahb_hprotd;          // DCode protection
  wire     [1:0] mtx_mem_attrd;           // DCode memory attributes
  wire           mtx_exreqd;              // DCode exclusive request
  wire           mtx_ahb_hwrited;         // DCode write not read
  wire    [31:0] mtx_ahb_hwdatad;         // DCode write data

  // System
  wire    [31:0] mtx_ahb_haddrs;          // System-bus address
  wire     [1:0] mtx_ahb_htranss;         // System-bus transfer type
  wire     [1:0] mtx_ahb_hmasters;        // System-bus master
  wire           mtx_ahb_hmastlocks;      // System-bus lock
  wire     [2:0] mtx_ahb_hsizes;          // System-bus transfer size
  wire     [2:0] mtx_ahb_hbursts;         // System-bus burst length
  wire     [3:0] mtx_ahb_hprots;          // System-bus protection
  wire     [1:0] mtx_mem_attrs;           // System-bus memory attributes
  wire           mtx_exreqs;              // System-bus exclusive request
  wire           mtx_ahb_hwrites;         // System-bus write not read
  wire    [31:0] mtx_ahb_hwdatas;         // System-bus write data

  // ICore interface
  wire    [31:0] dpu_ahb_haddri;          // ICore address
  wire     [1:0] dpu_ahb_htransi;         // ICore transfer type
  wire     [1:0] dpu_ahb_hsizei;          // ICore transfer size
  wire     [1:0] dpu_ahb_hproti;          // ICore protection controls
  wire     [1:0] mtx_dpu_ahb_hrespi;      // ICore transfer response
  wire           mtx_dpu_ahb_haddracci;   // ICore addr accept
  wire    [31:0] mtx_dpu_ahb_hrdatai;     // ICore read data
  wire           mpu_dpu_ahb_hreadyi;     // ICore ready, from MPU

  // DCore interface
  wire     [1:0] dpu_ahb_htransd;         // DCore transfer type
  wire           dpu_ahb_hwrited;         // DCore write not read
  wire     [1:0] dpu_ahb_hsized;          // DCore transfer size
  wire    [31:0] dpu_ahb_haddrd;          // DCore address
  wire    [31:0] dpu_ahb_hwdatad;         // DCore write data
  wire     [1:0] dpu_ahb_hprotd;          // DCore protection controls
  wire           dpu_exreqd;              // DCore exclusive request
  wire           mtx_dpu_ahb_haddraccd;   // DCore addr accept
  wire    [31:0] mtx_dpu_ahb_hrdatad;     // DCore read data
  wire     [1:0] mtx_dpu_ahb_hrespd;      // DCore transfer response
  wire           mtx_dpu_exrespd;         // DCore exclusive response
  wire           mpu_dpu_ahb_hreadyd;     // DCore ready, from MPU

  // DAP Debug AHB interface
  wire    [31:0] dap_ahb_haddr;
  wire           dap_ahb_hmaster;
  wire     [1:0] dap_ahb_htrans;
  wire     [1:0] dap_ahb_hsize;
  wire           dap_ahb_hwrite;
  wire    [31:0] dap_ahb_hwdata;
  wire     [2:0] dap_ahb_hburst;
  wire     [3:0] dap_ahb_hprot;
  wire           dap_ahb_habort;
  wire           mtx_dap_ahb_hreadyout;
  wire           mtx_dap_ahb_haddracc;
  wire    [31:0] mtx_dap_ahb_hrdata;
  wire     [1:0] mtx_dap_ahb_hresp;

  // DAP bus interface signals
  wire           dap_ready;
  wire           dap_slverr;
  wire    [31:0] dap_rdata;

  // PPB AHB
  wire    [31:0] mtx_ppb_haddr;           // PPB address
  wire     [1:0] mtx_ppb_hmaster;         // PPB master: 0=DCODE, 1=DAP
  wire     [1:0] mtx_ppb_htrans;          // PPB transfer type
  wire     [2:0] mtx_ppb_hsize;           // PPB transfer size
  wire     [3:0] mtx_ppb_hprot;           // PPB transfer protection
  wire           mtx_ppb_hwrite;          // PPB write not read
  wire    [31:0] mtx_ppb_hwdata;          // PPB write data
  wire    [31:0] ppb_hrdata;              // PPB read data
  wire           ppb_hready;              // PPB ready out
  wire           ppb_hresp;               // PPB transfer response
  wire           ppb_pclken;              // PPB clock enable

  // PPB AHB selects and slave responses
  wire           ppb_hsel_nvic;           // NVIC select
  wire           ppb_hsel_mpu;            // MPU select
  wire           ppb_hsel_itm;            // ITM select
  wire           ppb_hsel_fpb;            // FPB select
  wire           ppb_hsel_dwt;            // DWT select
  wire           ppb_hsel_ext;            // EXT select
  wire           nvic_ppb_hready;         // NVIC ready
  wire           nvic_ppb_hresp;          // NVIC transfer response
  wire    [31:0] nvic_ppb_hrdata;         // NVIC read data
  wire           mpu_ppb_hreadyout;       // MPU ready
  wire           mpu_ppb_hresp;           // MPU transfer response
  wire    [31:0] mpu_ppb_hrdata;          // MPU read data
  wire           itm_ppb_hreadyout;       // ITM ready
  wire           itm_ppb_hresp;           // ITM transfer response
  wire    [31:0] itm_ppb_hrdata;          // ITM read data
  wire           fpb_ppb_hreadyout;       // FPB ready
  wire           fpb_ppb_hresp;           // FPB transfer response
  wire    [31:0] fpb_ppb_hrdata;          // FPB read data
  wire           dwt_ppb_hreadyout;       // DWT ready
  wire           dwt_ppb_hresp;           // DWT transfer response
  wire    [31:0] dwt_ppb_hrdata;          // DWT read data
  wire           ext_ppb_hreadyout;       // EXT ready out
  wire           ext_ppb_hresp;           // EXT transfer response
  wire    [31:0] ext_ppb_hrdata;          // EXT read data

  // External PPB
  wire           ppb_psel;
  wire    [19:2] ppb_paddr;
  wire           ppb_paddr31;
  wire           ppb_penable;
  wire           ppb_pwrite;
  wire    [31:0] ppb_pwdata;

  // MPU outputs
  wire     [3:0] mpu_mtx_ahb_hproti;      // ISide HPROT, from MPU
  wire     [1:0] mpu_mem_attri;           // ISide attributes, from MPU
  wire           mpu_dpu_ahb_hrespi;      // ISide HRESP, from MPU
  wire           mtx_mpu_ahb_hreadyouti;  // ISide HREADY, to MPU
  wire     [3:0] mpu_mtx_ahb_hprotd;      // DSide HPROT, from MPU
  wire     [1:0] mpu_mem_attrd;           // DSide attributes, from MPU
  wire           mpu_dpu_ahb_hrespd;      // DSide HRESP, from MPU
  wire           mtx_mpu_ahb_hreadyoutd;  // DSide HREADY, to MPU

  // FPB
  wire     [1:0] fpb_matched;             // FPB matched code or literal address
  wire           fpb_matchedi;            // IFPB match - BKPT remap
  wire     [4:0] fpb_matched_addri;       // FPB matched I address
  wire     [2:0] fpb_matched_addrd;       // FPB matched D address
  wire     [3:0] fpb_matched_proti;       // FPB matched I prot
  wire     [3:0] fpb_matched_protd;       // FPB matched D prot
  wire     [1:0] fpb_matched_mem_attri;   // FPB matched I memory attributes
  wire     [1:0] fpb_matched_mem_attrd;   // FPB matched D memory attributes
  wire           fpb_matched_exreqd;      // FPB matched D exclusive request
  wire     [1:0] fpb_matched_sized;       // FPB matched D size
  wire    [23:0] fpb_remap_addr;          // FPB Remapped address
  wire     [1:0] fpb_remap_func;          // FPB remap function
  wire           mtx_fpb_active;          // BM remap active

  // DWT
  wire     [3:0] dwt_etm_trigger;
  wire     [3:0] dwt_etm_trig_i_not_d;
  wire     [2:0] dwt_size;
  wire           dwt_overflow;
  wire           dwt_valid;
  wire    [39:0] dwt_data;
  wire           dwt_dist_sync;
  wire           dwt_watchpoint;

  // NVIC - DPU interface
  wire           nvic_int_invoke;
  wire           dpu_int_entry;
  wire           dpu_int_exit;
  wire           nvic_int_stk_actv;
  wire           nvic_int_tail;
  wire           dpu_int_return;
  wire [8:0]     dpu_int_retisr;
  wire           dpu_dbg_wr_isr;
  wire [8:0]     nvic_int_curr_isr;
  wire           nvic_int_new_arrival;
  wire [31:0]    nvic_int_addr;
  wire           nvic_dbg_halt_req;
  wire           nvic_dbg_mon_req;
  wire [1:0]     dpu_slp_ctl;
  wire           dpu_ahb_htransi_iss;
  wire           dpu_bkpt;
  wire           dpu_svc;
  wire           dpu_cp_busy;
  wire [5:0]     dpu_nxt_bfsr;
  wire [9:0]     dpu_nxt_ufsr;
  wire           dpu_nxt_hfsr;
  wire [4:0]     dpu_nxt_mfsr;
  wire           dpu_dbg_ready;
  wire           nvic_slp_sleeponexit;
  wire [2:0]     nvic_int_in_nmihf;
  wire           nvic_int_mpu_nmihf;
  wire           nvic_bfhfnmign;
  wire           nvic_int_stk_algn;
  wire           nvic_div_0_trp;
  wire           nvic_unalign_trp;
  wire           dpu_ivalid;
  wire           dpu_retire;
  wire           dpu_basepri_we;
  wire [7:0]     dpu_basepri_nxt;
  wire           dpu_fmask_we;
  wire           dpu_fmask_nxt;
  wire           dpu_pmask_we;
  wire           dpu_pmask_nxt;
  wire           dpu_raisepri;
  wire [7:0]     nvic_basepri;
  wire           nvic_fmask;
  wire           nvic_pmask;
  wire           dpu_ahb_haddrd_valid;
  wire           nvic_nonbasethrden;
  wire           nvic_slp_asleep;
  wire           dpu_rst_pc_valid;
  wire           nvic_dbg_step;
  wire [7:0]     nvic_int_nxt_isr;
  wire           nvic_dbg_trans;        // Will remain asserted until dbg_ready
  wire           nvic_dbg_reg_wr;       // Debug register read, register write
  wire [6:0]     nvic_dbg_reg_addr;     // Debug register address
  wire           dpu_mcyc_invk_msk;     // Multi-cycle operation in progress
  wire           dpu_ahb_invk_msk;      // Constant AHB invoke mask
  wire           nvic_dismcycint;       // AuxCtrl[0]
  wire           nvic_disfold;          // auxctrl[1]
  wire           nvic_no_def_wbuf;      // auxctrl[2]
  wire           nvic_sleeping;
  wire           nvic_sleepdeep;
  wire           nvic_sleep_hold_ack_n;
  wire           dpu_dbg_halted;
  wire [1:0]     nvic_lockup;
  wire     [7:0] nvic_int_curr_pri;
  wire           nvic_dbg_snapstall;
  wire           nvic_dbg_restarted;
  wire           nvic_data_be8;
  wire           ext_cp_disable;
  wire     [1:0] dpu_fpccr_we;
  wire    [31:0] dpu_fpcar_nxt;
  wire [NUM_IRQ-1:0] irq;
  wire           nmi;
  wire           dpu_privileged;
  wire           dpu_thread;
  wire           dpu_lazy_stk;

  // WIC
  wire           wic_ds_ack_n;
  wire           wic_load;
  wire           wic_clear;
  wire   [243:0] wic_mask_full;
  wire [WIC_LINES-1:0] wic_mask;

  // ETM Interface
  wire           etm_ifen;                // ETM interface enable
  wire           dpu_etm_ivalid;          // Instruction valid
  wire           dpu_etm_istall;          // Instruction stall
  wire           dpu_etm_dvalid;          // Data valid
  wire    [31:1] dpu_etm_ia;              // PC to ETM
  wire     [1:0] dpu_etm_pstat;           // Pipeline status to ETM
  wire           dpu_etm_fold;            // Instruction is folded
  wire           dpu_etm_lsu;             // Instruction is LSU op
  wire           dpu_etm_cancel;          // Instruction cancelled
  wire     [2:0] dpu_etm_intstat;         // ETM interrupt status
  wire     [8:0] dpu_etm_intnum;          // ETM interrupt number
  wire           dpu_etm_ibranch;
  wire           dpu_etm_iindbr;
  wire           dpu_etm_isb;
  wire           dpu_etm_icc_fail;
  wire           dpu_etm_flush;
  wire           dpu_etm_findbr;

  // HTM interface
  wire    [31:0] htm_haddrd;
  wire     [1:0] htm_htransd;
  wire     [2:0] htm_hsized;
  wire     [2:0] htm_hburstd;
  wire     [3:0] htm_hprotd;
  wire    [31:0] htm_hwdatad;
  wire           htm_hwrited;
  wire    [31:0] htm_hrdatad;
  wire           htm_hreadyd;
  wire     [1:0] htm_hrespd;

  // ITM interfaces
  wire           itm_dwt_ready;
  wire           itm_atb_valid;
  wire     [7:0] itm_atb_data;
  wire           itm_atb_flush;
  wire     [6:0] itm_atb_id;

  // MPU - bus matrix interface
  wire           mpu_canceld;
  wire           mpu_canceli;
  wire           mtx_mpu_canceld_reg;     // Cancel trans in cycle after mpu_canceld
  wire           mtx_mpu_canceli_reg;     // Cancel trans in cycle after mpu_canceli

  // Core - Bus matrix interface
  wire           dpu_force_non_buf;       // Force MPU attribs to be non-bufferable
  wire           mpu_addrd_non_buf;       // Data AHB address is non-bufferable
  wire           mtx_wb_abort;            // Write buffer imprecise abort
  wire           mtx_bm_active;           // Bit master is active

  // Master Debug Enable
  wire           nvic_trc_en;
  wire           ext_dbg_en;

  // Observation interface (internal state visibility)
  wire   [148:0] internal_state;
  wire   [31:0]  dpu_obs_instr;
  wire   [108:0] dpu_obs_rf;
  wire           nvic_int_st_obs;
  wire           opt_nvic_int_st_obs;
  wire   [108:0] opt_dpu_obs_rf;
  wire    [31:0] opt_dpu_obs_instr;
  wire     [2:0] fpb_obs_matched;
  wire           dwt_obs_watchpoint;

  // Logic removal terms
  wire           mst_clk_en;
  wire     [1:0] opt_fpb_matched;
  wire           opt_fpb_matchedi;
  wire     [4:0] opt_fpb_matched_addri;
  wire     [2:0] opt_fpb_matched_addrd;
  wire     [3:0] opt_fpb_matched_proti;
  wire     [1:0] opt_fpb_matched_mem_attri;
  wire     [3:0] opt_fpb_matched_protd;
  wire     [1:0] opt_fpb_matched_mem_attrd;
  wire           opt_fpb_matched_exreqd;
  wire     [1:0] opt_fpb_matched_sized;
  wire    [23:0] opt_fpb_remap_addr;
  wire     [1:0] opt_fpb_remap_func;
  wire     [2:0] opt_fpb_obs_matched;
  wire           opt_fpb_ppb_hreadyout;
  wire           opt_fpb_ppb_hresp;
  wire    [31:0] opt_fpb_ppb_hrdata;
  wire           opt_dwt_ppb_hreadyout;
  wire           opt_dwt_ppb_hresp;
  wire    [31:0] opt_dwt_ppb_hrdata;
  wire           opt_dwt_dist_sync;
  wire           opt_dwt_watchpoint;
  wire           opt_dwt_obs_watchpoint;
  wire     [2:0] opt_dwt_size;
  wire           opt_dwt_overflow;
  wire           opt_dwt_valid;
  wire    [39:0] opt_dwt_data;
  wire     [3:0] opt_dwt_etm_trigger;
  wire     [3:0] opt_dwt_etm_trig_i_not_d;
  wire           opt_itm_dwt_ready;
  wire           opt_itm_ppb_hreadyout;
  wire           opt_itm_ppb_hresp;
  wire    [31:0] opt_itm_ppb_hrdata;
  wire           opt_itm_atb_valid;
  wire     [7:0] opt_itm_atb_data;
  wire     [6:0] opt_itm_atb_id;
  wire    [31:0] opt_dap_ahb_haddr;
  wire           opt_dap_ahb_hmaster;
  wire     [1:0] opt_dap_ahb_htrans;
  wire     [1:0] opt_dap_ahb_hsize;
  wire           opt_dap_ahb_hwrite;
  wire    [31:0] opt_dap_ahb_hwdata;
  wire     [2:0] opt_dap_ahb_hburst;
  wire     [3:0] opt_dap_ahb_hprot;
  wire           opt_dap_ahb_habort;
  wire           opt_dap_ready;
  wire           opt_dap_slverr;
  wire    [31:0] opt_dap_rdata;
  wire    [31:0] opt_htm_haddrd;
  wire     [1:0] opt_htm_htransd;
  wire     [2:0] opt_htm_hsized;
  wire     [2:0] opt_htm_hburstd;
  wire     [3:0] opt_htm_hprotd;
  wire    [31:0] opt_htm_hwdatad;
  wire           opt_htm_hwrited;
  wire    [31:0] opt_htm_hrdatad;
  wire           opt_htm_hreadyd;
  wire     [1:0] opt_htm_hrespd;
  wire           opt_wic_ds_ack_n;
  wire           opt_wic_load;
  wire           opt_wic_clear;
  wire   [239:0] opt_wic_mask_isr;
  wire           opt_wic_mask_mon;
  wire           opt_wic_mask_nmi;
  wire           opt_wic_mask_rxev;
  wire           opt_dbg_en;
  wire           opt_fp_en;
  wire           opt_trc_en;
  wire           opt_htm_en;
  wire           opt_wic_en;
  wire           opt_obs_en;

  //----------------------------------------------------------------------------
  // Parameterisable logic control
  //----------------------------------------------------------------------------

`ifdef ARM_DSM

  // DSM
  assign opt_trc_en = (dsm_trace_lvl   > 0);
  assign opt_htm_en = (dsm_trace_lvl   > 2);
  assign opt_dbg_en = (dsm_debug_lvl   > 0);
  assign opt_fp_en  = (dsm_debug_lvl   > 1);
  assign opt_wic_en = (dsm_wic_present > 0);
  assign opt_obs_en = (dsm_observation > 0);

`else

  // Parameters
  assign opt_trc_en = (TRACE_LVL   > 0);
  assign opt_htm_en = (TRACE_LVL   > 2);
  assign opt_dbg_en = (DEBUG_LVL   > 0);
  assign opt_fp_en  = (DEBUG_LVL   > 1);
  assign opt_wic_en = (WIC_PRESENT > 0);
  assign opt_obs_en = (OBSERVATION > 0);

`endif

  //----------------------------------------------------------------------------
  // Reset generation
  //----------------------------------------------------------------------------
  assign hreset_n = RSTBYPASS ? PORESETn : (PORESETn & SYSRESETn & dpu_vect_reset_n);
  assign dreset_n = PORESETn;

  //----------------------------------------------------------------------------
  // Clock gates
  //----------------------------------------------------------------------------

  // Clock enable optimization term
  assign mst_clk_en = (CLKGATE_PRESENT != 0) ? 1'b1 : 1'b0;

  // Debug clock
  cm3_clk_gate #(CLKGATE_PRESENT)
    u_cm3_clk_gate_dclk
      (// Inputs
       .clk                       (FCLK),
       .clk_enable_i              (nvic_trc_en),
       .global_disable_i          (CGBYPASS),
       // Outputs
       .clk_gated_o               (i_dclk_gated)
      );

  // PPB clock
  cm3_clk_gate #(CLKGATE_PRESENT)
    u_cm3_clk_gate_pclk
      (// Inputs
       .clk                       (HCLK),
       .clk_enable_i              (ppb_pclken),
       .global_disable_i          (CGBYPASS),
       // Outputs
       .clk_gated_o               (i_pclk_gated)
      );

  // Clock gate removal
  assign dclk_gated = mst_clk_en ? i_dclk_gated : FCLK;
  assign pclk_gated = mst_clk_en ? i_pclk_gated : HCLK;

  //----------------------------------------------------------------------------
  // Synchronisers
  //----------------------------------------------------------------------------

  // Synchronise DBGEN to FCLK
  cm3_sync #(1)
    u_cm3_sync_dbg_en
      (// Inputs
       .reset_n                    (PORESETn),
       .clk                        (FCLK),
       .d_async_i                  (DBGEN),
       // Outputs
       .q_o                        (ext_dbg_en));

  //----------------------------------------------------------------------------
  // Core and NVIC sub-system
  //----------------------------------------------------------------------------
  assign irq         = INTISR[NUM_IRQ-1:0];
  assign nmi         = INTNMI;
  assign etm_ifen    = (nvic_trc_en | ETMPWRUP | VECTADDREN);

  // ---------------------------------------------------------------------------
  // Instantiate the core
  // ---------------------------------------------------------------------------
  cm3_dpu #(CLKGATE_PRESENT, RESET_ALL_REGS, OBSERVATION, CONST_AHB_CTRL)
    u_cm3_dpu
      (// Inputs
       .hreset_n                   (hreset_n),
       .hclk                       (HCLK),
       .ext_cg_bypass_i            (CGBYPASS),
       .mtx_ahb_haddracci_i        (mtx_dpu_ahb_haddracci),
       .mtx_ahb_hreadyi_i          (mpu_dpu_ahb_hreadyi),
       .mtx_ahb_hrdatai_i          (mtx_dpu_ahb_hrdatai),
       .mtx_ahb_hrespi_i           (mtx_dpu_ahb_hrespi[1:0]),
       .mpu_hrespi_i               (mpu_dpu_ahb_hrespi),
       .mtx_ahb_haddraccd_i        (mtx_dpu_ahb_haddraccd),
       .mtx_ahb_hreadyd_i          (mpu_dpu_ahb_hreadyd),
       .mtx_ahb_hrdatad_i          (mtx_dpu_ahb_hrdatad),
       .mtx_ahb_hrespd_i           (mtx_dpu_ahb_hrespd[1:0]),
       .mpu_hrespd_i               (mpu_dpu_ahb_hrespd),
       .mtx_ahb_exrespd_i          (mtx_dpu_exrespd),
       .ext_iflush_i               (IFLUSH),
       .nvic_data_be8_i            (nvic_data_be8),
       .mtx_bm_active_i            (mtx_bm_active),
       .mpu_canceld_i              (mpu_canceld),
       .mpu_addrd_non_buf_i        (mpu_addrd_non_buf),
       .nvic_bfhfnmign_i           (nvic_bfhfnmign),
       .nvic_int_stk_algn_i        (nvic_int_stk_algn),
       .nvic_div_0_trp_i           (nvic_div_0_trp),
       .nvic_unalign_trp_i         (nvic_unalign_trp),
       .nvic_nonbasethrden_i       (nvic_nonbasethrden),
       .nvic_disfold_i             (nvic_disfold),
       .nvic_dismcycint_i          (nvic_dismcycint),
       .nvic_basepri_i             (nvic_basepri),
       .nvic_fmask_i               (nvic_fmask),
       .nvic_pmask_i               (nvic_pmask),
       .nvic_int_nxt_isr_i         (nvic_int_nxt_isr),
       .nvic_int_curr_isr_i        (nvic_int_curr_isr),
       .nvic_lockup_i              (nvic_lockup),
       .nvic_int_invoke_i          (nvic_int_invoke),
       .nvic_int_newarrival_i      (nvic_int_new_arrival),
       .nvic_int_addr_i            (nvic_int_addr),
       .nvic_int_tail_i            (nvic_int_tail),
       .nvic_int_stk_actv_i        (nvic_int_stk_actv),
       .nvic_int_in_nmihf_i        (nvic_int_in_nmihf),
       .nvic_slp_asleep_i          (nvic_slp_asleep),
       .nvic_slp_sleeponexit_i     (nvic_slp_sleeponexit),
       .nvic_dbg_halt_req_i        (nvic_dbg_halt_req),
       .nvic_dbg_mon_req_i         (nvic_dbg_mon_req),
       .nvic_dbg_step_i            (nvic_dbg_step),
       .nvic_dbg_trans_i           (nvic_dbg_trans),
       .nvic_dbg_reg_wr_i          (nvic_dbg_reg_wr),
       .nvic_dbg_reg_addr_i        (nvic_dbg_reg_addr),
       .etm_ifen_i                 (etm_ifen),
       .etm_fifofull_i             (ETMFIFOFULL),
       // Outputs
       .dpu_ahb_haddri_o           (dpu_ahb_haddri),
       .dpu_ahb_htransi_o          (dpu_ahb_htransi[1:0]),
       .dpu_ahb_hsizei_o           (dpu_ahb_hsizei[1:0]),
       .dpu_ahb_hproti_o           (dpu_ahb_hproti),
       .dpu_ahb_haddrd_o           (dpu_ahb_haddrd[31:0]),
       .dpu_ahb_htransd_o          (dpu_ahb_htransd[1:0]),
       .dpu_ahb_hwrited_o          (dpu_ahb_hwrited),
       .dpu_ahb_hsized_o           (dpu_ahb_hsized[1:0]),
       .dpu_ahb_hwdatad_o          (dpu_ahb_hwdatad[31:0]),
       .dpu_ahb_hprotd_o           (dpu_ahb_hprotd),
       .dpu_ahb_exreqd_o           (dpu_exreqd),
       .dpu_ahb_htransi_iss_o      (dpu_ahb_htransi_iss),
       .dpu_rst_pc_valid_o         (dpu_rst_pc_valid),
       .dpu_int_entry_o            (dpu_int_entry),
       .dpu_int_exit_o             (dpu_int_exit),
       .dpu_int_return_o           (dpu_int_return),
       .dpu_int_retisr_o           (dpu_int_retisr),
       .dpu_branch_stat_o          (dpu_branch_stat),
       .dpu_ivalid_o               (dpu_ivalid),
       .dpu_retire_o               (dpu_retire),
       .dpu_bkpt_o                 (dpu_bkpt),
       .dpu_svc_o                  (dpu_svc),
       .dpu_nxt_bfsr_o             (dpu_nxt_bfsr),
       .dpu_nxt_mfsr_o             (dpu_nxt_mfsr),
       .dpu_nxt_ufsr_o             (dpu_nxt_ufsr),
       .dpu_nxt_hfsr_o             (dpu_nxt_hfsr),
       .dpu_basepri_we_o           (dpu_basepri_we),
       .dpu_basepri_nxt_o          (dpu_basepri_nxt),
       .dpu_fmask_we_o             (dpu_fmask_we),
       .dpu_fmask_nxt_o            (dpu_fmask_nxt),
       .dpu_pmask_we_o             (dpu_pmask_we),
       .dpu_pmask_nxt_o            (dpu_pmask_nxt),
       .dpu_raisepri_o             (dpu_raisepri),
       .dpu_slp_txev_o             (TXEV),
       .dpu_slp_ctl_o              (dpu_slp_ctl),
       .dpu_ahb_haddrd_valid_o     (dpu_ahb_haddrd_valid),
       .dpu_mcyc_invk_msk_o        (dpu_mcyc_invk_msk),
       .dpu_ahb_invk_msk_o         (dpu_ahb_invk_msk),
       .dpu_force_non_buf_o        (dpu_force_non_buf),
       .dpu_obs_instr_o            (dpu_obs_instr),
       .dpu_obs_rf_o               (dpu_obs_rf),
       .dpu_dbg_halted_o           (dpu_dbg_halted),
       .dpu_dbg_ready_o            (dpu_dbg_ready),
       .dpu_dbg_wr_isr_o           (dpu_dbg_wr_isr),
       .dpu_etm_ivalid_o           (dpu_etm_ivalid),
       .dpu_etm_istall_o           (dpu_etm_istall),
       .dpu_etm_ia_o               (dpu_etm_ia),
       .dpu_etm_ibranch_o          (dpu_etm_ibranch),
       .dpu_etm_iindrbr_o          (dpu_etm_iindbr),
       .dpu_etm_isb_o              (dpu_etm_isb),
       .dpu_etm_iccfail_o          (dpu_etm_icc_fail),
       .dpu_etm_dvalid_o           (dpu_etm_dvalid),
       .dpu_etm_lsu_o              (dpu_etm_lsu),
       .dpu_etm_pstat_o            (dpu_etm_pstat),
       .dpu_etm_fold_o             (dpu_etm_fold),
       .dpu_etm_cancel_o           (dpu_etm_cancel),
       .dpu_etm_intstat_o          (dpu_etm_intstat),
       .dpu_etm_intnum_o           (dpu_etm_intnum),
       .dpu_etm_flush_o            (dpu_etm_flush),
       .dpu_etm_findbr_o           (dpu_etm_findbr));

  //----------------------------------------------------------------------------
  // DPU logic removal
  //----------------------------------------------------------------------------
  assign opt_dpu_obs_instr = opt_obs_en ? dpu_obs_instr : {32{1'b0}};
  assign opt_dpu_obs_rf    = opt_obs_en ? dpu_obs_rf    : {109{1'b0}};

  // ---------------------------------------------------------------------------
  // Instantiate the NVIC
  // ---------------------------------------------------------------------------
  cm3_nvic #(NUM_IRQ, LVL_WIDTH, DEBUG_LVL, RESET_ALL_REGS, WIC_PRESENT,
             WIC_LINES)
    u_cm3_nvic
      (// Inputs
       .dreset_n                   (dreset_n),
       .hreset_n                   (hreset_n),
       .fclk                       (FCLK),
       .hclk                       (HCLK),
       .pclk                       (pclk_gated),
       .ext_st_clk_i               (STCLK),
       .ext_st_calib_i             (STCALIB),
       .ext_cp_disable_i           (ext_cp_disable),
       .ext_big_end_i              (BIGEND),
       .mtx_ppb_hsel_nvic_i        (ppb_hsel_nvic),
       .mtx_ppb_hmaster_i          (mtx_ppb_hmaster[0]),
       .mtx_ppb_haddr_i            (mtx_ppb_haddr[11:0]),
       .mtx_ppb_hwrite_i           (mtx_ppb_hwrite),
       .mtx_ppb_hsize_i            (mtx_ppb_hsize[1:0]),
       .mtx_ppb_hprot_i            (mtx_ppb_hprot),
       .mtx_ppb_hwdata_i           (mtx_ppb_hwdata[31:0]),
       .mtx_ppb_hready_i           (ppb_hready),
       .dpu_rst_pc_valid_i         (dpu_rst_pc_valid),
       .dpu_ahb_htransi_iss_i      (dpu_ahb_htransi_iss),
       .dpu_ahb_haddrd_i           (dpu_ahb_haddrd),
       .dpu_ahb_haddrd_valid_i     (dpu_ahb_haddrd_valid),
       .dpu_privileged_i           (dpu_privileged),
       .dpu_thread_i               (dpu_thread),
       .dpu_ivalid_i               (dpu_ivalid),
       .dpu_retire_i               (dpu_retire),
       .dpu_fpccr_we_i             (dpu_fpccr_we),
       .dpu_fpcar_nxt_i            (dpu_fpcar_nxt),
       .dpu_lazy_stk_i             (dpu_lazy_stk),
       .dpu_basepri_we_i           (dpu_basepri_we),
       .dpu_basepri_nxt_i          (dpu_basepri_nxt),
       .dpu_fmask_we_i             (dpu_fmask_we),
       .dpu_fmask_nxt_i            (dpu_fmask_nxt),
       .dpu_pmask_we_i             (dpu_pmask_we),
       .dpu_pmask_nxt_i            (dpu_pmask_nxt),
       .dpu_raisepri_i             (dpu_raisepri),
       .ext_stkalign_init_i        (STKALIGNINIT),
       .ext_nmi_i                  (nmi),
       .ext_irq_i                  (irq),
       .mtx_wb_abort_i             (mtx_wb_abort),
       .dpu_bkpt_i                 (dpu_bkpt),
       .dpu_svc_i                  (dpu_svc),
       .dpu_cp_busy_i              (dpu_cp_busy),
       .dpu_nxt_bfsr_i             (dpu_nxt_bfsr),
       .dpu_nxt_ufsr_i             (dpu_nxt_ufsr),
       .dpu_nxt_hfsr_i             (dpu_nxt_hfsr),
       .dpu_nxt_mfsr_i             (dpu_nxt_mfsr),
       .ext_aux_fault_i            (AUXFAULT),
       .ext_vect_addr_i            (VECTADDR),
       .ext_vect_addr_en_i         (VECTADDREN),
       .dpu_mcyc_invk_msk_i        (dpu_mcyc_invk_msk),
       .dpu_ahb_invk_msk_i         (dpu_ahb_invk_msk),
       .dpu_int_entry_i            (dpu_int_entry),
       .dpu_int_exit_i             (dpu_int_exit),
       .dpu_int_return_i           (dpu_int_return),
       .dpu_int_retisr_i           (dpu_int_retisr),
       .ext_slp_rxev_i             (RXEV),
       .ext_slp_txev_i             (TXEV),
       .ext_slp_hold_req_n_i       (SLEEPHOLDREQn),
       .dpu_slp_ctl_i              (dpu_slp_ctl),
       .wic_ds_req_n_i             (WICDSREQn),
       .ext_dbg_en_i               (ext_dbg_en),
       .dwt_watchpoint_i           (opt_dwt_watchpoint),
       .ext_dbg_req_i              (EDBGRQ),
       .dpu_dbg_halted_i           (dpu_dbg_halted),
       .dpu_dbg_ready_i            (dpu_dbg_ready),
       .dpu_dbg_wr_isr_i           (dpu_dbg_wr_isr),
       .ext_dbg_restart_i          (DBGRESTART),
       // Outputs
       .nvic_ppb_hready_o          (nvic_ppb_hready),
       .nvic_ppb_hrdata_o          (nvic_ppb_hrdata),
       .nvic_ppb_hresp_o           (nvic_ppb_hresp),
       .nvic_int_invoke_o          (nvic_int_invoke),
       .nvic_int_new_arrival_o     (nvic_int_new_arrival),
       .nvic_int_addr_o            (nvic_int_addr),
       .nvic_int_tail_o            (nvic_int_tail),
       .nvic_int_nxt_isr_o         (nvic_int_nxt_isr),
       .nvic_int_curr_isr_o        (nvic_int_curr_isr),
       .nvic_int_curr_pri_o        (nvic_int_curr_pri),
       .nvic_int_stk_actv_o        (nvic_int_stk_actv),
       .nvic_int_in_nmihf_o        (nvic_int_in_nmihf),
       .nvic_int_mpu_nmihf_o       (nvic_int_mpu_nmihf),
       .nvic_int_stk_algn_o        (nvic_int_stk_algn),
       .nvic_int_st_obs_o          (nvic_int_st_obs),
       .nvic_basepri_o             (nvic_basepri),
       .nvic_fmask_o               (nvic_fmask),
       .nvic_pmask_o               (nvic_pmask),
       .nvic_data_be8_o            (nvic_data_be8),
       .nvic_bfhfnmign_o           (nvic_bfhfnmign),
       .nvic_div_0_trp_o           (nvic_div_0_trp),
       .nvic_unalign_trp_o         (nvic_unalign_trp),
       .nvic_nonbasethrden_o       (nvic_nonbasethrden),
       .nvic_disfold_o             (nvic_disfold),
       .nvic_dismcycint_o          (nvic_dismcycint),
       .nvic_no_def_wbuf_o         (nvic_no_def_wbuf),
       .nvic_no_ooo_o              (/* not required */),
       .nvic_no_lazy_stk_o         (/* not required */),
       .nvic_aux_ctrl1_we_o        (/* not required */),
       .nvic_cpacr_o               (/* not required */),
       .nvic_fpccr_o               (/* not required */),
       .nvic_fpcar_o               (/* not required */),
       .nvic_fpdscr_o              (/* not required */),
       .nvic_lockup_o              (nvic_lockup),
       .nvic_vect_reset_n_o        (dpu_vect_reset_n),
       .nvic_sys_reset_req_o       (SYSRESETREQ),
       .nvic_slp_sleeponexit_o     (nvic_slp_sleeponexit),
       .nvic_slp_asleep_o          (nvic_slp_asleep),
       .nvic_slp_sleeping_o        (nvic_sleeping),
       .nvic_slp_sleepdeep_o       (nvic_sleepdeep),
       .nvic_slp_hold_ack_n_o      (nvic_sleep_hold_ack_n),
       .nvic_wic_ds_ack_n_o        (wic_ds_ack_n),
       .nvic_wic_load_o            (wic_load),
       .nvic_wic_clear_o           (wic_clear),
       .nvic_wic_mask_o            (wic_mask),
       .nvic_dbg_halt_req_o        (nvic_dbg_halt_req),
       .nvic_dbg_mon_req_o         (nvic_dbg_mon_req),
       .nvic_dbg_step_o            (nvic_dbg_step),
       .nvic_dbg_restarted_o       (nvic_dbg_restarted),
       .nvic_dbg_trans_o           (nvic_dbg_trans),
       .nvic_dbg_reg_wr_o          (nvic_dbg_reg_wr),
       .nvic_dbg_reg_addr_o        (nvic_dbg_reg_addr),
       .nvic_dbg_snapstall_o       (nvic_dbg_snapstall),
       .nvic_trc_en_o              (nvic_trc_en));

  // These NVIC inputs are not required in this configuration.
  assign ext_cp_disable  = 1'b1;
  assign dpu_fpccr_we    = 2'b00;
  assign dpu_fpcar_nxt   = {32{1'b0}};
  assign dpu_privileged  = 1'b0;
  assign dpu_thread      = 1'b0;
  assign dpu_lazy_stk    = 1'b0;
  assign dpu_cp_busy     = 1'b0;

  //----------------------------------------------------------------------------
  // NVIC logic removal
  //----------------------------------------------------------------------------
  assign wic_mask_full       = {{244-WIC_LINES{1'b0}}, wic_mask[WIC_LINES-1:0]};
  assign opt_wic_ds_ack_n    = opt_wic_en ? wic_ds_ack_n         : 1'b1;
  assign opt_wic_load        = opt_wic_en ? wic_load             : 1'b0;
  assign opt_wic_clear       = opt_wic_en ? wic_clear            : 1'b0;
  assign opt_wic_mask_isr    = opt_wic_en ? wic_mask_full[242:3] : {240{1'b0}};
  assign opt_wic_mask_mon    = opt_wic_en ? wic_mask_full[2]     : 1'b0;
  assign opt_wic_mask_nmi    = opt_wic_en ? wic_mask_full[1]     : 1'b0;
  assign opt_wic_mask_rxev   = opt_wic_en ? wic_mask_full[0]     : 1'b0;
  assign opt_nvic_int_st_obs = opt_obs_en ? nvic_int_st_obs      : 1'b0;

  //----------------------------------------------------------------------------
  // MPU
  //----------------------------------------------------------------------------

  cm3_mpu #(MPU_PRESENT, CLKGATE_PRESENT)
    u_cm3_mpu
      (// Inputs
       .hclk                      (HCLK),
       .pclk                      (pclk_gated),
       .hreset_n                  (hreset_n),
       .mpu_disable_i             (MPUDISABLE),
       .ppb_hsel_i                (ppb_hsel_mpu),
       .ppb_hwrite_i              (mtx_ppb_hwrite),
       .ppb_hsize_i               (mtx_ppb_hsize[1:0]),
       .ppb_haddr_i               (mtx_ppb_haddr[11:0]),
       .ppb_hwdata_i              (mtx_ppb_hwdata),
       .ppb_hprot_i               (mtx_ppb_hprot),
       .ppb_hready_i              (ppb_hready),
       .dpu_ahb_haddri_i          (dpu_ahb_haddri),
       .dpu_ahb_hproti_i          (dpu_ahb_hproti),
       .dpu_ahb_htransi_i         (dpu_ahb_htransi),
       .mtx_mpu_ahb_hreadyouti_i  (mtx_mpu_ahb_hreadyouti),
       .mtx_dpu_ahb_haddracci_i   (mtx_dpu_ahb_haddracci),
       .dpu_ahb_haddrd_i          (dpu_ahb_haddrd),
       .dpu_ahb_hsized_i          (dpu_ahb_hsized),
       .dpu_ahb_hprotd_i          (dpu_ahb_hprotd),
       .dpu_ahb_hwrited_i         (dpu_ahb_hwrited),
       .dpu_ahb_htransd_i         (dpu_ahb_htransd),
       .mtx_mpu_ahb_hreadyoutd_i  (mtx_mpu_ahb_hreadyoutd),
       .mtx_dpu_ahb_haddraccd_i   (mtx_dpu_ahb_haddraccd),
       .nvic_int_mpu_nmihf_i      (nvic_int_mpu_nmihf),
       .nvic_no_def_wbuf_i        (nvic_no_def_wbuf),
       // Outputs
       .ppb_hresp_o               (mpu_ppb_hresp),
       .ppb_hrdata_o              (mpu_ppb_hrdata),
       .ppb_hreadyout_o           (mpu_ppb_hreadyout),
       .mpu_dpu_ahb_hreadyi_o     (mpu_dpu_ahb_hreadyi),
       .mpu_dpu_ahb_hrespi_o      (mpu_dpu_ahb_hrespi),
       .mpu_mtx_ahb_hproti_o      (mpu_mtx_ahb_hproti),
       .mpu_dpu_ahb_hreadyd_o     (mpu_dpu_ahb_hreadyd),
       .mpu_dpu_ahb_hrespd_o      (mpu_dpu_ahb_hrespd),
       .mpu_mtx_ahb_hprotd_o      (mpu_mtx_ahb_hprotd),
       .mpu_addrd_non_buf_o       (mpu_addrd_non_buf),
       .mpu_mem_attrd_o           (mpu_mem_attrd),
       .mpu_mem_attri_o           (mpu_mem_attri),
       .mpu_canceli_o             (mpu_canceli),
       .mpu_canceld_o             (mpu_canceld)
      );

  //----------------------------------------------------------------------------
  // Bus matrix
  //----------------------------------------------------------------------------

  cm3_bus_matrix #(DEBUG_LVL, RESET_ALL_REGS, BB_PRESENT, CONST_AHB_CTRL)
    u_cm3_bus_matrix
      (// Inputs
       .hclk                      (HCLK),
       .hreset_n                  (hreset_n),
       .dreset_n                  (dreset_n),
       .mpu_mem_attri_i           (mpu_mem_attri),
       .mpu_mem_attrd_i           (mpu_mem_attrd),
       .mpu_addrd_non_buf_i       (mpu_addrd_non_buf),
       .mpu_canceli_i             (mpu_canceli),
       .mpu_canceld_i             (mpu_canceld),
       .fpb_matched_i             (opt_fpb_matched),
       .fpb_matchedi_i            (opt_fpb_matchedi),
       .fpb_matched_addri_i       (opt_fpb_matched_addri),
       .fpb_matched_addrd_i       (opt_fpb_matched_addrd),
       .fpb_matched_proti_i       (opt_fpb_matched_proti),
       .fpb_matched_mem_attri_i   (opt_fpb_matched_mem_attri),
       .fpb_matched_protd_i       (opt_fpb_matched_protd),
       .fpb_matched_mem_attrd_i   (opt_fpb_matched_mem_attrd),
       .fpb_matched_exreqd_i      (opt_fpb_matched_exreqd),
       .fpb_matched_sized_i       (opt_fpb_matched_sized),
       .fpb_remap_addr_i          (opt_fpb_remap_addr),
       .fpb_remap_func_i          (opt_fpb_remap_func),
       .dpu_ahb_haddrd_i          (dpu_ahb_haddrd),
       .dpu_ahb_htransd_i         (dpu_ahb_htransd),
       .dpu_ahb_hwrited_i         (dpu_ahb_hwrited),
       .dpu_ahb_hsized_i          (dpu_ahb_hsized),
       .dpu_ahb_hburstd_i         (3'b001),
       .dpu_ahb_hprotd_i          (mpu_mtx_ahb_hprotd),
       .dpu_ahb_hwdatad_i         (dpu_ahb_hwdatad),
       .dpu_exreqd_i              (dpu_exreqd),
       .dpu_ahb_haddri_i          (dpu_ahb_haddri),
       .dpu_ahb_htransi_i         (dpu_ahb_htransi),
       .dpu_ahb_hsizei_i          (dpu_ahb_hsizei),
       .dpu_ahb_hbursti_i         (3'b000),
       .dpu_ahb_hproti_i          (mpu_mtx_ahb_hproti),
       .dap_ahb_haddr_i           (opt_dap_ahb_haddr),
       .dap_ahb_hmaster_i         ({1'b0,opt_dap_ahb_hmaster}),
       .dap_ahb_htrans_i          (opt_dap_ahb_htrans),
       .dap_ahb_hwrite_i          (opt_dap_ahb_hwrite),
       .dap_ahb_hsize_i           (opt_dap_ahb_hsize),
       .dap_ahb_hburst_i          (opt_dap_ahb_hburst),
       .dap_ahb_hprot_i           (opt_dap_ahb_hprot),
       .dap_ahb_habort_i          (opt_dap_ahb_habort),
       .dap_ahb_hwdata_i          (opt_dap_ahb_hwdata),
       .mtx_ahb_hrdatai_i         (HRDATAI),
       .mtx_ahb_hreadyi_i         (HREADYI),
       .mtx_ahb_hrespi_i          (HRESPI),
       .mtx_ahb_hrdatad_i         (HRDATAD),
       .mtx_ahb_hreadyd_i         (HREADYD),
       .mtx_ahb_hrespd_i          (HRESPD),
       .mtx_exrespd_i             (EXRESPD),
       .mtx_ahb_hrdatas_i         (HRDATAS),
       .mtx_ahb_hreadys_i         (HREADYS),
       .mtx_ahb_hresps_i          (HRESPS),
       .mtx_exresps_i             (EXRESPS),
       .mtx_ppb_hrdata_i          (ppb_hrdata),
       .mtx_ppb_hready_i          (ppb_hready),
       .mtx_ppb_hresp_i           ({1'b0,ppb_hresp}),
       .dpu_dbg_snapstall_i       (nvic_dbg_snapstall),
       .data_be8_i                (nvic_data_be8),
       .dpu_force_non_buf_i       (dpu_force_non_buf),
       .d_not_i_trans_i           (DNOTITRANS),
       // Outputs
       .mtx_ahb_haddri_o          (mtx_ahb_haddri),
       .mtx_ahb_htransi_o         (mtx_ahb_htransi),
       .mtx_ahb_hsizei_o          (mtx_ahb_hsizei),
       .mtx_ahb_hbursti_o         (mtx_ahb_hbursti),
       .mtx_ahb_hproti_o          (mtx_ahb_hproti),
       .mtx_mem_attri_o           (mtx_mem_attri),
       .mtx_ahb_haddrd_o          (mtx_ahb_haddrd),
       .mtx_ahb_hmasterd_o        (mtx_ahb_hmasterd),
       .mtx_ahb_htransd_o         (mtx_ahb_htransd),
       .mtx_ahb_hwrited_o         (mtx_ahb_hwrited),
       .mtx_ahb_hsized_o          (mtx_ahb_hsized),
       .mtx_ahb_hburstd_o         (mtx_ahb_hburstd),
       .mtx_ahb_hprotd_o          (mtx_ahb_hprotd),
       .mtx_ahb_hwdatad_o         (mtx_ahb_hwdatad),
       .mtx_mem_attrd_o           (mtx_mem_attrd),
       .mtx_exreqd_o              (mtx_exreqd),
       .mtx_ahb_haddrs_o          (mtx_ahb_haddrs),
       .mtx_ahb_hmasters_o        (mtx_ahb_hmasters),
       .mtx_ahb_hmastlocks_o      (mtx_ahb_hmastlocks),
       .mtx_ahb_htranss_o         (mtx_ahb_htranss),
       .mtx_ahb_hwrites_o         (mtx_ahb_hwrites),
       .mtx_ahb_hsizes_o          (mtx_ahb_hsizes),
       .mtx_ahb_hbursts_o         (mtx_ahb_hbursts),
       .mtx_ahb_hprots_o          (mtx_ahb_hprots),
       .mtx_ahb_hwdatas_o         (mtx_ahb_hwdatas),
       .mtx_mem_attrs_o           (mtx_mem_attrs),
       .mtx_exreqs_o              (mtx_exreqs),
       .mtx_ppb_hmaster_o         (mtx_ppb_hmaster),
       .mtx_ppb_haddr_o           (mtx_ppb_haddr),
       .mtx_ppb_htrans_o          (mtx_ppb_htrans),
       .mtx_ppb_hwrite_o          (mtx_ppb_hwrite),
       .mtx_ppb_hsize_o           (mtx_ppb_hsize),
       .mtx_ppb_hburst_o          (/* No bursts on PPB */),
       .mtx_ppb_hprot_o           (mtx_ppb_hprot),
       .mtx_ppb_hwdata_o          (mtx_ppb_hwdata),
       .mtx_dpu_ahb_hrdatad_o     (mtx_dpu_ahb_hrdatad),
       .mtx_mpu_ahb_hreadyoutd_o  (mtx_mpu_ahb_hreadyoutd),
       .mtx_dpu_ahb_haddraccd_o   (mtx_dpu_ahb_haddraccd),
       .mtx_dpu_ahb_hrespd_o      (mtx_dpu_ahb_hrespd),
       .mtx_dpu_exrespd_o         (mtx_dpu_exrespd),
       .mtx_dpu_ahb_hrdatai_o     (mtx_dpu_ahb_hrdatai),
       .mtx_mpu_ahb_hreadyouti_o  (mtx_mpu_ahb_hreadyouti),
       .mtx_dpu_ahb_haddracci_o   (mtx_dpu_ahb_haddracci),
       .mtx_dpu_ahb_hrespi_o      (mtx_dpu_ahb_hrespi),
       .mtx_dap_ahb_hrdata_o      (mtx_dap_ahb_hrdata),
       .mtx_dap_ahb_hreadyout_o   (mtx_dap_ahb_hreadyout),
       .mtx_dap_ahb_haddracc_o    (mtx_dap_ahb_haddracc),
       .mtx_dap_ahb_hresp_o       (mtx_dap_ahb_hresp),
       .mtx_bm_active_o           (mtx_bm_active),
       .mtx_write_buff_abort_o    (mtx_wb_abort),
       .mtx_mpu_canceli_reg_o     (mtx_mpu_canceli_reg),
       .mtx_mpu_canceld_reg_o     (mtx_mpu_canceld_reg),
       .mtx_fpb_active_o          (mtx_fpb_active)
      );

  //----------------------------------------------------------------------------
  // DAP AHB-AP
  //----------------------------------------------------------------------------

  cm3_dap_ahb_ap #(DEBUG_LVL, RESET_ALL_REGS)
    u_cm3_dap_ahb_ap
      (// Inputs
       .hclk                      (HCLK),
       .hreset_n                  (dreset_n),
       .dap_clk                   (DAPCLK),
       .dap_clken_i               (DAPCLKEN),
       .dap_reset_n               (DAPRESETn),
       .master_enable_i           (1'b1),
       .dap_en_i                  (DAPEN),
       .fix_master_type_i         (FIXMASTERTYPE),
       .dap_sel_i                 (DAPSEL),
       .dap_addr_i                (DAPADDR[7:0]),
       .dap_enable_i              (DAPENABLE),
       .dap_write_i               (DAPWRITE),
       .dap_abort_i               (DAPABORT),
       .dap_wdata_i               (DAPWDATA),
       .dap_ahb_hready_i          (mtx_dap_ahb_hreadyout),
       .dap_ahb_haddracc_i        (mtx_dap_ahb_haddracc),
       .dap_ahb_hresp_i           (mtx_dap_ahb_hresp[0]),
       .dap_ahb_hrdata_i          (mtx_dap_ahb_hrdata),
       // Outputs
       .dap_ahb_haddr_o           (dap_ahb_haddr),
       .dap_ahb_hmaster_o         (dap_ahb_hmaster),
       .dap_ahb_htrans_o          (dap_ahb_htrans),
       .dap_ahb_hwrite_o          (dap_ahb_hwrite),
       .dap_ahb_hsize_o           (dap_ahb_hsize),
       .dap_ahb_hburst_o          (dap_ahb_hburst),
       .dap_ahb_hprot_o           (dap_ahb_hprot),
       .dap_ahb_hwdata_o          (dap_ahb_hwdata),
       .dap_ahb_habort_o          (dap_ahb_habort),
       .dap_ready_o               (dap_ready),
       .dap_slverr_o              (dap_slverr),
       .dap_rdata_o               (dap_rdata)
      );

  //----------------------------------------------------------------------------
  // DAP logic removal
  //----------------------------------------------------------------------------

  // DAP AHB-AP
  assign opt_dap_ahb_haddr   = opt_dbg_en ? dap_ahb_haddr   : {32{1'b0}};
  assign opt_dap_ahb_htrans  = opt_dbg_en ? dap_ahb_htrans  : {2{1'b0}};
  assign opt_dap_ahb_hmaster = opt_dbg_en ? dap_ahb_hmaster : 1'b0;
  assign opt_dap_ahb_hwrite  = opt_dbg_en ? dap_ahb_hwrite  : 1'b0;
  assign opt_dap_ahb_hsize   = opt_dbg_en ? dap_ahb_hsize   : 2'b00;
  assign opt_dap_ahb_hburst  = opt_dbg_en ? dap_ahb_hburst  : 3'b000;
  assign opt_dap_ahb_hprot   = opt_dbg_en ? dap_ahb_hprot   : 4'b0000;
  assign opt_dap_ahb_hwdata  = opt_dbg_en ? dap_ahb_hwdata  : {32{1'b0}};
  assign opt_dap_ahb_habort  = opt_dbg_en ? dap_ahb_habort  : 1'b0;

  // DAP bus
  assign opt_dap_ready       = opt_dbg_en ? dap_ready       : 1'b1;
  assign opt_dap_slverr      = opt_dbg_en ? dap_slverr      : 1'b0;
  assign opt_dap_rdata       = opt_dbg_en ? dap_rdata       : {32{1'b0}};

  //----------------------------------------------------------------------------
  // PPB address decoder
  //----------------------------------------------------------------------------

  cm3_ppb_decoder
    u_cm3_ppb_decoder
      (// Inputs
       .hclk                      (HCLK),
       .dreset_n                  (dreset_n),
       .ppb_lock_i                (PPBLOCK),
       .ppb_hwrite_i              (mtx_ppb_hwrite),
       .ppb_hmaster_i             (mtx_ppb_hmaster[0]),
       .ppb_htrans_i              (mtx_ppb_htrans),
       .ppb_hprot_i               (mtx_ppb_hprot),
       .ppb_haddr_i               (mtx_ppb_haddr),
       .itm_ppb_hreadyout_i       (opt_itm_ppb_hreadyout),
       .dwt_ppb_hreadyout_i       (opt_dwt_ppb_hreadyout),
       .fpb_ppb_hreadyout_i       (opt_fpb_ppb_hreadyout),
       .ext_ppb_hreadyout_i       (ext_ppb_hreadyout),
       .nvic_ppb_hreadyout_i      (nvic_ppb_hready),
       .mpu_ppb_hreadyout_i       (mpu_ppb_hreadyout),
       .itm_ppb_hresp_i           (opt_itm_ppb_hresp),
       .dwt_ppb_hresp_i           (opt_dwt_ppb_hresp),
       .fpb_ppb_hresp_i           (opt_fpb_ppb_hresp),
       .ext_ppb_hresp_i           (ext_ppb_hresp),
       .nvic_ppb_hresp_i          (nvic_ppb_hresp),
       .mpu_ppb_hresp_i           (mpu_ppb_hresp),
       .itm_ppb_hrdata_i          (opt_itm_ppb_hrdata),
       .dwt_ppb_hrdata_i          (opt_dwt_ppb_hrdata),
       .fpb_ppb_hrdata_i          (opt_fpb_ppb_hrdata),
       .ext_ppb_hrdata_i          (ext_ppb_hrdata),
       .nvic_ppb_hrdata_i         (nvic_ppb_hrdata),
       .mpu_ppb_hrdata_i          (mpu_ppb_hrdata),
       // Outputs
       .ppb_hsel_itm_o            (ppb_hsel_itm),
       .ppb_hsel_dwt_o            (ppb_hsel_dwt),
       .ppb_hsel_fpb_o            (ppb_hsel_fpb),
       .ppb_hsel_ext_o            (ppb_hsel_ext),
       .ppb_hsel_nvic_o           (ppb_hsel_nvic),
       .ppb_hsel_mpu_o            (ppb_hsel_mpu),
       .ppb_hrdata_o              (ppb_hrdata),
       .ppb_hready_o              (ppb_hready),
       .ppb_hresp_o               (ppb_hresp),
       .ppb_pclken_o              (ppb_pclken)
      );

  //----------------------------------------------------------------------------
  // FPB
  //----------------------------------------------------------------------------

  cm3_fpb #(DEBUG_LVL, RESET_ALL_REGS, OBSERVATION)
    u_cm3_fpb
      (// Inputs
       .hclk                      (HCLK),
       .pclk                      (pclk_gated),
       .hreset_n                  (dreset_n),
       .ppb_hsel_i                (ppb_hsel_fpb),
       .ppb_haddr_i               (mtx_ppb_haddr[11:2]),
       .ppb_hwrite_i              (mtx_ppb_hwrite),
       .ppb_hwdata_i              (mtx_ppb_hwdata),
       .ppb_hready_i              (ppb_hready),
       .dpu_ahb_haddri_i          (dpu_ahb_haddri),
       .dpu_ahb_htransi_i         (dpu_ahb_htransi[1]),
       .dpu_ahb_hproti_i          (mpu_mtx_ahb_hproti),
       .dpu_ahb_hreadyi_i         (mpu_dpu_ahb_hreadyi),
       .dpu_ahb_haddracci_i       (mtx_dpu_ahb_haddracci),
       .dpu_ahb_haddrd_i          (dpu_ahb_haddrd),
       .dpu_ahb_htransd_i         (dpu_ahb_htransd[1]),
       .dpu_ahb_hprotd_i          (mpu_mtx_ahb_hprotd),
       .dpu_ahb_hwrited_i         (dpu_ahb_hwrited),
       .dpu_ahb_hsized_i          (dpu_ahb_hsized),
       .dpu_ahb_hreadyd_i         (mpu_dpu_ahb_hreadyd),
       .dpu_ahb_haddraccd_i       (mtx_dpu_ahb_haddraccd),
       .dpu_exreqd_i              (dpu_exreqd),
       .mpu_canceli_i             (mpu_canceli),
       .mpu_canceld_i             (mpu_canceld),
       .mpu_mem_attri_i           (mpu_mem_attri),
       .mpu_mem_attrd_i           (mpu_mem_attrd),
       .mtx_mpu_canceli_reg_i     (mtx_mpu_canceli_reg),
       .mtx_mpu_canceld_reg_i     (mtx_mpu_canceld_reg),
       .mtx_fpb_active_i          (mtx_fpb_active),
       // Outputs
       .ppb_hreadyout_o           (fpb_ppb_hreadyout),
       .ppb_hresp_o               (fpb_ppb_hresp),
       .ppb_hrdata_o              (fpb_ppb_hrdata),
       .fpb_matched_o             (fpb_matched),
       .fpb_matchedi_o            (fpb_matchedi),
       .fpb_matched_addri_o       (fpb_matched_addri),
       .fpb_matched_proti_o       (fpb_matched_proti),
       .fpb_matched_mem_attri_o   (fpb_matched_mem_attri),
       .fpb_matched_addrd_o       (fpb_matched_addrd),
       .fpb_matched_protd_o       (fpb_matched_protd),
       .fpb_matched_mem_attrd_o   (fpb_matched_mem_attrd),
       .fpb_matched_exreqd_o      (fpb_matched_exreqd),
       .fpb_matched_sized_o       (fpb_matched_sized),
       .fpb_remap_addr_o          (fpb_remap_addr),
       .fpb_remap_func_o          (fpb_remap_func),
       .fpb_observe_matched_o     (fpb_obs_matched)
      );

  //----------------------------------------------------------------------------
  // FPB logic removal
  //----------------------------------------------------------------------------
  assign opt_fpb_matched           = opt_fp_en  ? fpb_matched           : 2'b00;
  assign opt_fpb_matched_addri     = opt_fp_en  ? fpb_matched_addri     : 5'b00000;
  assign opt_fpb_matched_proti     = opt_fp_en  ? fpb_matched_proti     : 4'b0000;
  assign opt_fpb_matched_mem_attri = opt_fp_en  ? fpb_matched_mem_attri : 2'b00;
  assign opt_fpb_matched_addrd     = opt_fp_en  ? fpb_matched_addrd     : 3'b000;
  assign opt_fpb_matched_protd     = opt_fp_en  ? fpb_matched_protd     : 4'b0000;
  assign opt_fpb_matched_mem_attrd = opt_fp_en  ? fpb_matched_mem_attrd : 2'b00;
  assign opt_fpb_matched_exreqd    = opt_fp_en  ? fpb_matched_exreqd    : 1'b0;
  assign opt_fpb_matched_sized     = opt_fp_en  ? fpb_matched_sized     : 2'b00;
  assign opt_fpb_remap_addr        = opt_fp_en  ? fpb_remap_addr        : {24{1'b0}};
  assign opt_fpb_matchedi          = opt_dbg_en ? fpb_matchedi          : 1'b0;
  assign opt_fpb_remap_func        = opt_dbg_en ? fpb_remap_func        : 2'b00;
  assign opt_fpb_ppb_hreadyout     = opt_dbg_en ? fpb_ppb_hreadyout     : 1'b1;
  assign opt_fpb_ppb_hresp         = opt_dbg_en ? fpb_ppb_hresp         : 1'b0;
  assign opt_fpb_ppb_hrdata        = opt_dbg_en ? fpb_ppb_hrdata        : {32{1'b0}};

  // Observation
  assign opt_fpb_obs_matched       = ((opt_dbg_en & opt_obs_en) ?
                                      fpb_obs_matched  : 3'b000);

  //----------------------------------------------------------------------------
  // DWT
  //----------------------------------------------------------------------------

  cm3_dwt #(TRACE_LVL, DEBUG_LVL, RESET_ALL_REGS, OBSERVATION,0)
    u_cm3_dwt
      (// Inputs
       .clk                       (dclk_gated),
       .reset_n                   (dreset_n),
       .dpu_trace_enable_i        (nvic_trc_en),
       .dpu_sleeping_i            (nvic_sleeping),
       .dpu_sleep_hold_ack_n      (nvic_sleep_hold_ack_n),
       .dpu_etm_int_num_i         (dpu_etm_intnum[8:0]),
       .dpu_etm_int_stat_i        (dpu_etm_intstat[1:0]),
       .dpu_ahb_haddrd_i          (dpu_ahb_haddrd[31:0]),
       .dpu_ahb_htransd_i         (dpu_ahb_htransd[1:0]),
       .dpu_ahb_hsized_i          (dpu_ahb_hsized[1:0]),
       .dpu_ahb_hwrited_i         (dpu_ahb_hwrited),
       .dpu_ahb_hwdatad_i         (dpu_ahb_hwdatad[31:0]),
       .dpu_ahb_hrdatad_i         (mtx_dpu_ahb_hrdatad[31:0]),
       .mpu_ahb_hreadyoutd_i      (mpu_dpu_ahb_hreadyd),
       .dpu_ahb_hrespd_i          (mtx_dpu_ahb_hrespd),
       .mpu_ppb_hresp_i           (mpu_ppb_hresp),
       .dpu_ahb_haddraccd_i       (mtx_dpu_ahb_haddraccd),
       .mpu_canceld_i             (mpu_canceld),
       .ppb_hsel_i                (ppb_hsel_dwt),
       .ppb_haddr_i               (mtx_ppb_haddr[12:2]),
       .ppb_hwrite_i              (mtx_ppb_hwrite),
       .ppb_hwdata_i              (mtx_ppb_hwdata[31:0]),
       .ppb_hready_i              (ppb_hready),
       .dpu_etm_ivalid_i          (dpu_etm_ivalid),
       .dpu_etm_istall_i          (dpu_etm_istall),
       .dpu_etm_cancel_i          (dpu_etm_cancel),
       .dpu_etm_pstat_i           (dpu_etm_pstat[1:0]),
       .dpu_etm_lsu_i             (dpu_etm_lsu),
       .dpu_etm_fold_i            (dpu_etm_fold),
       .dpu_etm_ia_i              (dpu_etm_ia[31:1]),
       .itm_dwt_ready_i           (opt_itm_dwt_ready),
       // Outputs
       .ppb_hreadyout_o           (dwt_ppb_hreadyout),
       .ppb_hresp_o               (dwt_ppb_hresp),
       .ppb_hrdata_o              (dwt_ppb_hrdata[31:0]),
       .dwt_size_o                (dwt_size[2:0]),
       .dwt_overflow_o            (dwt_overflow),
       .dwt_valid_o               (dwt_valid),
       .dwt_data_o                (dwt_data[39:0]),
       .dwt_dist_sync_o           (dwt_dist_sync),
       .dwt_watchpoint_o          (dwt_watchpoint),
       .dwt_etm_trigger_o         (dwt_etm_trigger),
       .dwt_etm_trig_i_not_d_o    (dwt_etm_trig_i_not_d),
       .dwt_observe_watchpoint_o  (dwt_obs_watchpoint)
      );

  //----------------------------------------------------------------------------
  // DWT logic removal
  //----------------------------------------------------------------------------
  assign opt_dwt_ppb_hreadyout    = opt_dbg_en ? dwt_ppb_hreadyout    : 1'b1;
  assign opt_dwt_ppb_hresp        = opt_dbg_en ? dwt_ppb_hresp        : 1'b0;
  assign opt_dwt_ppb_hrdata       = opt_dbg_en ? dwt_ppb_hrdata       : 32'h0F000000;
  assign opt_dwt_dist_sync        = opt_dbg_en ? dwt_dist_sync        : 1'b0;
  assign opt_dwt_watchpoint       = opt_dbg_en ? dwt_watchpoint       : 1'b0;
  assign opt_dwt_etm_trigger      = opt_trc_en ? dwt_etm_trigger      : 4'b0000;
  assign opt_dwt_etm_trig_i_not_d = opt_trc_en ? dwt_etm_trig_i_not_d : 4'b0000;
  assign opt_dwt_valid            = opt_trc_en ? dwt_valid            : 1'b0;
  assign opt_dwt_size             = opt_trc_en ? dwt_size             : 3'b000;
  assign opt_dwt_overflow         = opt_trc_en ? dwt_overflow         : 1'b0;
  assign opt_dwt_data             = opt_trc_en ? dwt_data             : {40{1'b0}};

  // Observation
  assign opt_dwt_obs_watchpoint   = ((opt_dbg_en & opt_obs_en) ?
                                     dwt_obs_watchpoint : 1'b0);

  //----------------------------------------------------------------------------
  // AHB to APB bridge
  //----------------------------------------------------------------------------

  cm3_ppb_ahb_to_apb
    u_cm3_ppb_ahb_to_apb
      (// Inputs
       .hclk                      (HCLK),
       .dreset_n                  (dreset_n),
       .ahb_hsel_i                (ppb_hsel_ext),
       .ahb_haddr_i               (mtx_ppb_haddr[19:2]),
       .ahb_hmaster_i             (mtx_ppb_hmaster[0]),
       .ahb_htrans_i              (mtx_ppb_htrans),
       .ahb_hwrite_i              (mtx_ppb_hwrite),
       .ahb_hready_i              (ppb_hready),
       .ahb_hwdata_i              (mtx_ppb_hwdata),
       .apb_prdata_i              (PRDATA),
       .apb_pready_i              (PREADY),
       .apb_pslverr_i             (PSLVERR),
       // Outputs
       .apb_psel_o                (ppb_psel),
       .apb_paddr_o               (ppb_paddr),
       .apb_paddr31_o             (ppb_paddr31),
       .apb_pwrite_o              (ppb_pwrite),
       .apb_penable_o             (ppb_penable),
       .apb_pwdata_o              (ppb_pwdata),
       .ahb_hreadyout_o           (ext_ppb_hreadyout),
       .ahb_hresp_o               (ext_ppb_hresp),
       .ahb_hrdata_o              (ext_ppb_hrdata)
      );

  //----------------------------------------------------------------------------
  // ITM
  //----------------------------------------------------------------------------

  cm3_itm #(TRACE_LVL, RESET_ALL_REGS,0)
    u_cm3_itm
      (// Inputs
       .clk                       (dclk_gated),
       .reset_n                   (dreset_n),
       .dpu_trace_enable_i        (nvic_trc_en),
       .dpu_halted_i              (dpu_dbg_halted),
       .ppb_hsel_itm_i            (ppb_hsel_itm),
       .ppb_hprot_i               (mtx_ppb_hprot),
       .ppb_htrans_i              (mtx_ppb_htrans),
       .ppb_hwrite_i              (mtx_ppb_hwrite),
       .ppb_hsize_i               (mtx_ppb_hsize[1:0]),
       .ppb_haddr_i               (mtx_ppb_haddr[11:0]),
       .ppb_hready_i              (ppb_hready),
       .ppb_hwdata_i              (mtx_ppb_hwdata),
       .tpiu_active_i             (TPIUACTV),
       .tpiu_baud_i               (TPIUBAUD),
       .dwt_dist_sync_i           (opt_dwt_dist_sync),
       .dwt_valid_i               (opt_dwt_valid),
       .dwt_overflow_i            (opt_dwt_overflow),
       .dwt_size_i                (opt_dwt_size),
       .dwt_data_i                (opt_dwt_data),
       .atb_ready_i               (ATREADY),
       .ts_value_i                (TSVALUEB),
       .ts_clk_change_i           (TSCLKCHANGE),
       // Outputs
       .ppb_hreadyout_o           (itm_ppb_hreadyout),
       .ppb_hresp_o               (itm_ppb_hresp),
       .ppb_hrdata_o              (itm_ppb_hrdata),
       .itm_dwt_ready_o           (itm_dwt_ready),
       .atb_valid_o               (itm_atb_valid),
       .atb_data_o                (itm_atb_data),
       .atb_id_o                  (itm_atb_id)
      );

  assign itm_atb_flush = 1'b1;

  //----------------------------------------------------------------------------
  // ITM logic removal
  //----------------------------------------------------------------------------
  assign opt_itm_ppb_hreadyout = opt_trc_en ? itm_ppb_hreadyout : 1'b1;
  assign opt_itm_ppb_hresp     = opt_trc_en ? itm_ppb_hresp     : 1'b0;
  assign opt_itm_ppb_hrdata    = opt_trc_en ? itm_ppb_hrdata    : {32{1'b0}};
  assign opt_itm_dwt_ready     = opt_trc_en ? itm_dwt_ready     : 1'b1;
  assign opt_itm_atb_valid     = opt_trc_en ? itm_atb_valid     : 1'b0;
  assign opt_itm_atb_data      = opt_trc_en ? itm_atb_data      : {8{1'b0}};
  assign opt_itm_atb_id        = opt_trc_en ? itm_atb_id        : {7{1'b0}};

  //----------------------------------------------------------------------------
  // HTM port
  //----------------------------------------------------------------------------

  cm3_htm_port #(TRACE_LVL)
    u_cm3_htm_port
      (// Inputs
       .hclk                      (HCLK),
       .hreset_n                  (hreset_n),
       .trace_enable_i            (nvic_trc_en),
       .dpu_ahb_haddrd_i          (dpu_ahb_haddrd),
       .dpu_ahb_htransd_i         (dpu_ahb_htransd),
       .dpu_ahb_hsized_i          (dpu_ahb_hsized),
       .dpu_ahb_hprotd_i          (dpu_ahb_hprotd),
       .dpu_ahb_hwrited_i         (dpu_ahb_hwrited),
       .dpu_ahb_hwdatad_i         (dpu_ahb_hwdatad),
       .dpu_ahb_hrdatad_i         (mtx_dpu_ahb_hrdatad),
       .dpu_ahb_hreadyd_i         (mpu_dpu_ahb_hreadyd),
       .dpu_ahb_haddraccd_i       (mtx_dpu_ahb_haddraccd),
       .dpu_ahb_hrespd_i          (mtx_dpu_ahb_hrespd),
       .mpu_ahb_hrespd_i          (mpu_dpu_ahb_hrespd),
       // Outputs
       .htm_haddrd_o              (htm_haddrd),
       .htm_htransd_o             (htm_htransd),
       .htm_hsized_o              (htm_hsized),
       .htm_hburstd_o             (htm_hburstd),
       .htm_hprotd_o              (htm_hprotd),
       .htm_hwrited_o             (htm_hwrited),
       .htm_hwdatad_o             (htm_hwdatad),
       .htm_hrdatad_o             (htm_hrdatad),
       .htm_hreadyd_o             (htm_hreadyd),
       .htm_hrespd_o              (htm_hrespd)
      );

  //----------------------------------------------------------------------------
  // HTM logic removal
  //----------------------------------------------------------------------------
  assign opt_htm_haddrd  = opt_htm_en ? htm_haddrd  : 32'h00000000;
  assign opt_htm_htransd = opt_htm_en ? htm_htransd : 2'b00;
  assign opt_htm_hsized  = opt_htm_en ? htm_hsized  : 3'b000;
  assign opt_htm_hburstd = opt_htm_en ? htm_hburstd : 3'b000;
  assign opt_htm_hprotd  = opt_htm_en ? htm_hprotd  : 4'b0000;
  assign opt_htm_hwdatad = opt_htm_en ? htm_hwdatad : 32'h00000000;
  assign opt_htm_hwrited = opt_htm_en ? htm_hwrited : 1'b0;
  assign opt_htm_hrdatad = opt_htm_en ? htm_hrdatad : 32'h00000000;
  assign opt_htm_hreadyd = opt_htm_en ? htm_hreadyd : 1'b0;
  assign opt_htm_hrespd  = opt_htm_en ? htm_hrespd  : 2'b00;

  //----------------------------------------------------------------------------
  // Internal state observance
  //----------------------------------------------------------------------------

  // Instruction in decode (registered into execute)
  assign internal_state[31:0]    = opt_obs_en ? opt_dpu_obs_instr[31:0]  : {32{1'b0}};
  // Register bank ports (registered)
  assign internal_state[140:32]  = opt_obs_en ? opt_dpu_obs_rf[108:0]    : {109{1'b0}};
  // DAP HTRANSM (not registered)
  assign internal_state[142:141] = opt_obs_en ? opt_dap_ahb_htrans[1:0]  : 2'b00;
  // DAP HABORTM (not registered)
  assign internal_state[143]     = opt_obs_en ? opt_dap_ahb_habort       : 1'b0;
  // Watchpoint (registered)
  assign internal_state[144]     = opt_obs_en ? opt_dwt_obs_watchpoint   : 1'b0;
  // fpb_matchedi and fpb_matched (registered)
  assign internal_state[147:145] = opt_obs_en ? opt_fpb_obs_matched[2:0] : 3'b000;
  // TickIRQ (not registered)
  assign internal_state[148]     = opt_obs_en ? opt_nvic_int_st_obs      : 1'b0;

  //----------------------------------------------------------------------------
  // Output assignments
  //----------------------------------------------------------------------------

  // ICode AHB
  assign HTRANSI      = mtx_ahb_htransi;
  assign HSIZEI       = mtx_ahb_hsizei;
  assign HADDRI       = mtx_ahb_haddri;
  assign HBURSTI      = mtx_ahb_hbursti;
  assign HPROTI       = mtx_ahb_hproti;
  assign MEMATTRI     = mtx_mem_attri;

  // DCode AHB
  assign HMASTERD     = mtx_ahb_hmasterd;
  assign HTRANSD      = mtx_ahb_htransd;
  assign HSIZED       = mtx_ahb_hsized;
  assign HADDRD       = mtx_ahb_haddrd;
  assign HBURSTD      = mtx_ahb_hburstd;
  assign HPROTD       = mtx_ahb_hprotd;
  assign MEMATTRD     = mtx_mem_attrd;
  assign EXREQD       = mtx_exreqd;
  assign HWRITED      = mtx_ahb_hwrited;
  assign HWDATAD      = mtx_ahb_hwdatad;

  // SYS AHB
  assign HADDRS       = mtx_ahb_haddrs;
  assign HMASTERS     = mtx_ahb_hmasters;
  assign HMASTLOCKS   = mtx_ahb_hmastlocks;
  assign HTRANSS      = mtx_ahb_htranss;
  assign HWRITES      = mtx_ahb_hwrites;
  assign HSIZES       = mtx_ahb_hsizes;
  assign HBURSTS      = mtx_ahb_hbursts;
  assign HPROTS       = mtx_ahb_hprots;
  assign HWDATAS      = mtx_ahb_hwdatas;
  assign MEMATTRS     = mtx_mem_attrs;
  assign EXREQS       = mtx_exreqs;

  // External PPB
  assign PSEL         = ppb_psel;
  assign PADDR        = ppb_paddr;
  assign PADDR31      = ppb_paddr31;
  assign PENABLE      = ppb_penable;
  assign PWRITE       = ppb_pwrite;
  assign PWDATA       = ppb_pwdata;

  // DAP internal bus
  assign DAPREADY     = opt_dap_ready;
  assign DAPSLVERR    = opt_dap_slverr;
  assign DAPRDATA     = opt_dap_rdata;

  // HTM port
  assign HTMDHADDR    = opt_htm_haddrd;
  assign HTMDHTRANS   = opt_htm_htransd;
  assign HTMDHSIZE    = opt_htm_hsized;
  assign HTMDHBURST   = opt_htm_hburstd;
  assign HTMDHPROT    = opt_htm_hprotd;
  assign HTMDHWDATA   = opt_htm_hwdatad;
  assign HTMDHWRITE   = opt_htm_hwrited;
  assign HTMDHRDATA   = opt_htm_hrdatad;
  assign HTMDHREADY   = opt_htm_hreadyd;
  assign HTMDHRESP    = opt_htm_hrespd;

  // DWT
  assign DSYNC        = opt_dwt_dist_sync;

  // WIC
  assign WICDSACKn    = opt_wic_ds_ack_n;
  assign WICLOAD      = opt_wic_load;
  assign WICCLEAR     = opt_wic_clear;
  assign WICMASKISR   = opt_wic_mask_isr;
  assign WICMASKMON   = opt_wic_mask_mon;
  assign WICMASKNMI   = opt_wic_mask_nmi;
  assign WICMASKRXEV  = opt_wic_mask_rxev;

  // ETM
  assign ETMTRIGGER   = opt_dwt_etm_trigger;
  assign ETMTRIGINOTD = opt_dwt_etm_trig_i_not_d;
  assign ETMIVALID    = dpu_etm_ivalid;
  assign ETMISTALL    = dpu_etm_istall;
  assign ETMDVALID    = dpu_etm_dvalid;
  assign ETMFOLD      = dpu_etm_fold;
  assign ETMCANCEL    = dpu_etm_cancel;
  assign ETMIA        = dpu_etm_ia;
  assign ETMICCFAIL   = dpu_etm_icc_fail;
  assign ETMIBRANCH   = dpu_etm_ibranch;
  assign ETMIINDBR    = dpu_etm_iindbr;
  assign ETMISB       = dpu_etm_isb;
  assign ETMINTSTAT   = dpu_etm_intstat;
  assign ETMINTNUM    = dpu_etm_intnum;
  assign ETMFLUSH     = dpu_etm_flush;
  assign ETMFINDBR    = dpu_etm_findbr;

  // ATB interface
  assign ATVALID      = opt_itm_atb_valid;
  assign ATDATA       = opt_itm_atb_data;
  assign ATIDITM      = opt_itm_atb_id;
  assign AFREADY      = itm_atb_flush;

  // Core status outputs
  assign BRCHSTAT      = dpu_branch_stat;
  assign HALTED        = dpu_dbg_halted;
  assign LOCKUP        = nvic_lockup[0];
  assign SLEEPING      = nvic_sleeping;
  assign SLEEPDEEP     = nvic_sleepdeep;
  assign SLEEPHOLDACKn = nvic_sleep_hold_ack_n;
  assign CURRPRI       = nvic_int_curr_pri;
  assign TRCENA        = nvic_trc_en;
  assign DBGRESTARTED  = nvic_dbg_restarted;

  // Internal state
  assign INTERNALSTATE = internal_state;

  //----------------------------------------------------------------------------
  // Logic required for DSM generation
  //----------------------------------------------------------------------------

`ifdef ARM_DSM
`include "cm3_dsm_cfg.v"
`endif

  // ---------------------------------------------------------------------------
  // OVL assertions
  // ---------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON

  // dpu_dbg_halted and nvic_sleeping/sleep_hold_ack_n should be exclusive
  assert_never #(0,0,"dpu_dbg_halted and nvic_sleeping/sleep_hold_ack_n should be exclusive")
    ovl_slp_halt_chk(HCLK, hreset_n, dpu_dbg_halted & (nvic_sleeping|~nvic_sleep_hold_ack_n));

  // dpu_ivalid and nvic_sleeping/sleep_hold_ack_n should be exclusive
  assert_never #(0,0,"dpu_ivalid and nvic_sleeping/sleep_hold_ack_n should be exclusive")
    ovl_slp_de_chk(HCLK, hreset_n, dpu_ivalid & (nvic_sleeping|~nvic_sleep_hold_ack_n));

  // dpu_ahb_htransi and nvic_sleeping/sleep_hold_ack_n should be exclusive
  assert_never #(0,0,"dpu_ahb_htransi and nvic_sleeping/sleep_hold_ack_n should be exclusive")
    ovl_slp_htransi_chk(HCLK, hreset_n, (|dpu_ahb_htransi) & (nvic_sleeping|~nvic_sleep_hold_ack_n));

  // I-AHB data phase and nvic_sleeping/sleep_hold_ack_n should be exclusive
  assert_never #(0,0,"dpu_ahb_htransi_iss and nvic_sleeping/sleep_hold_ack_n should be exclusive")
    ovl_slp_hrdatai_chk(HCLK, hreset_n, dpu_ahb_htransi_iss & (nvic_sleeping|~nvic_sleep_hold_ack_n));

  // dpu_ahb_htransd and nvic_sleeping/sleep_hold_ack_n should be exclusive
  assert_never #(0,0,"DHTRANS and nvic_sleeping/sleep_hold_ack_n should be exclusive")
    ovl_slp_htransd_chk(HCLK, hreset_n, (|dpu_ahb_htransd) & (nvic_sleeping|~nvic_sleep_hold_ack_n));

  // int_invoke and nvic_sleeping/sleep_hold_ack_n should be exclusive
  assert_never #(0,0,"int_invoke and nvic_sleeping/sleep_hold_ack_n should be exclusive")
    ovl_slp_invoke_chk(HCLK, hreset_n, nvic_int_invoke & (nvic_sleeping|~nvic_sleep_hold_ack_n));

`endif

endmodule
