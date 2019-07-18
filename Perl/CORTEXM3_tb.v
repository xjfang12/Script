`timescale 1ns/1ps
////////////////////////////////////////////////////////////////////////////////
//
// Filename:    CORTEXM3_tb.v
// Author:      FangXinjia
// Create Time: Mon Jul 15 13:33:34 2019
// Release:     First Release
// Project:     
// Modified:
//
//
//
// Description: 
//
//
//
//
////////////////////////////////////////////////////////////////////////////////
module CORTEXM3_tb; 
////////////////////////////////////////////////////////////////////////////////
// signal list
////////////////////////////////////////////////////////////////////////////////
reg          PORESETn     ;
reg          SYSRESETn    ;
reg          FCLK         ;
reg          HCLK         ;
reg          STCLK        ;
reg          DAPCLK       ;
reg          DAPCLKEN     ;
reg          DAPRESETn    ;
reg          HREADYI      ;
reg  [31:0]  HRDATAI      ;
reg  [1:0]   HRESPI       ;
reg          IFLUSH       ;
reg          HREADYD      ;
reg  [31:0]  HRDATAD      ;
reg  [1:0]   HRESPD       ;
reg          EXRESPD      ;
reg          HREADYS      ;
reg  [31:0]  HRDATAS      ;
reg  [1:0]   HRESPS       ;
reg          EXRESPS      ;
reg  [31:0]  PRDATA       ;
reg          PREADY       ;
reg          PSLVERR      ;
reg          DAPEN        ;
reg          DAPSEL       ;
reg          DAPENABLE    ;
reg          DAPWRITE     ;
reg          DAPABORT     ;
reg  [31:0]  DAPADDR      ;
reg  [31:0]  DAPWDATA     ;
reg          FIXMASTERTYPE;
reg  [239:0] INTISR       ;
reg          INTNMI       ;
reg          WICDSREQn    ;
reg          ATREADY      ;
reg          RXEV         ;
reg          ETMPWRUP     ;
reg          ETMFIFOFULL  ;
reg          EDBGRQ       ;
reg          DBGRESTART   ;
reg          TPIUACTV     ;
reg          TPIUBAUD     ;
reg          SLEEPHOLDREQn;
reg  [31:0]  AUXFAULT     ;
reg          SE           ;
reg          RSTBYPASS    ;
reg          CGBYPASS     ;
reg  [25:0]  STCALIB      ;
reg          BIGEND       ;
reg          DNOTITRANS   ;
reg          STKALIGNINIT ;
reg  [5:0]   PPBLOCK      ;
reg  [9:0]   VECTADDR     ;
reg          VECTADDREN   ;
reg  [47:0]  TSVALUEB     ;
reg          TSCLKCHANGE  ;
reg          MPUDISABLE   ;
reg          DBGEN        ;
wire [31:0]  HADDRI       ;
wire [1:0]   HTRANSI      ;
wire [2:0]   HSIZEI       ;
wire [2:0]   HBURSTI      ;
wire [3:0]   HPROTI       ;
wire [1:0]   MEMATTRI     ;
wire [3:0]   BRCHSTAT     ;
wire [31:0]  HADDRD       ;
wire [1:0]   HTRANSD      ;
wire [1:0]   HMASTERD     ;
wire [2:0]   HSIZED       ;
wire [2:0]   HBURSTD      ;
wire [3:0]   HPROTD       ;
wire [1:0]   MEMATTRD     ;
wire         EXREQD       ;
wire         HWRITED      ;
wire [31:0]  HWDATAD      ;
wire [31:0]  HADDRS       ;
wire [1:0]   HTRANSS      ;
wire [1:0]   HMASTERS     ;
wire         HWRITES      ;
wire [2:0]   HSIZES       ;
wire         HMASTLOCKS   ;
wire [31:0]  HWDATAS      ;
wire [2:0]   HBURSTS      ;
wire [3:0]   HPROTS       ;
wire [1:0]   MEMATTRS     ;
wire         EXREQS       ;
wire         PSEL         ;
wire         PADDR31      ;
wire [19:2]  PADDR        ;
wire         PENABLE      ;
wire         PWRITE       ;
wire [31:0]  PWDATA       ;
wire         DAPREADY     ;
wire         DAPSLVERR    ;
wire [31:0]  DAPRDATA     ;
wire         WICDSACKn    ;
wire         WICLOAD      ;
wire         WICCLEAR     ;
wire [239:0] WICMASKISR   ;
wire         WICMASKMON   ;
wire         WICMASKNMI   ;
wire         WICMASKRXEV  ;
wire         ATVALID      ;
wire         AFREADY      ;
wire [7:0]   ATDATA       ;
wire         TXEV         ;
wire         SYSRESETREQ  ;
wire [3:0]   ETMTRIGGER   ;
wire [3:0]   ETMTRIGINOTD ;
wire         ETMIVALID    ;
wire         ETMISTALL    ;
wire         ETMDVALID    ;
wire         ETMFOLD      ;
wire         ETMCANCEL    ;
wire [31:1]  ETMIA        ;
wire         ETMICCFAIL   ;
wire         ETMIBRANCH   ;
wire         ETMIINDBR    ;
wire         ETMISB       ;
wire [2:0]   ETMINTSTAT   ;
wire [8:0]   ETMINTNUM    ;
wire         ETMFLUSH     ;
wire         ETMFINDBR    ;
wire         DSYNC        ;
wire         DBGRESTARTED ;
wire [31:0]  HTMDHADDR    ;
wire [1:0]   HTMDHTRANS   ;
wire [2:0]   HTMDHSIZE    ;
wire [2:0]   HTMDHBURST   ;
wire [3:0]   HTMDHPROT    ;
wire [31:0]  HTMDHWDATA   ;
wire         HTMDHWRITE   ;
wire [31:0]  HTMDHRDATA   ;
wire         HTMDHREADY   ;
wire [1:0]   HTMDHRESP    ;
wire [6:0]   ATIDITM      ;
wire         SLEEPHOLDACKn;
wire         SLEEPING     ;
wire         SLEEPDEEP    ;
wire         HALTED       ;
wire         LOCKUP       ;
wire [7:0]   CURRPRI      ;
wire         TRCENA       ;
wire [148:0] INTERNALSTATE;


////////////////////////////////////////////////////////////////////////////////
// initial block
initial begin
  PORESETn      = 0;
  SYSRESETn     = 0;
  FCLK          = 0;
  HCLK          = 0;
  STCLK         = 0;
  DAPCLK        = 0;
  DAPCLKEN      = 0;
  DAPRESETn     = 0;
  HREADYI       = 0;
  HRDATAI       = 0;
  HRESPI        = 0;
  IFLUSH        = 0;
  HREADYD       = 0;
  HRDATAD       = 0;
  HRESPD        = 0;
  EXRESPD       = 0;
  HREADYS       = 0;
  HRDATAS       = 0;
  HRESPS        = 0;
  EXRESPS       = 0;
  PRDATA        = 0;
  PREADY        = 0;
  PSLVERR       = 0;
  DAPEN         = 0;
  DAPSEL        = 0;
  DAPENABLE     = 0;
  DAPWRITE      = 0;
  DAPABORT      = 0;
  DAPADDR       = 0;
  DAPWDATA      = 0;
  FIXMASTERTYPE = 0;
  INTISR        = 0;
  INTNMI        = 0;
  WICDSREQn     = 0;
  ATREADY       = 0;
  RXEV          = 0;
  ETMPWRUP      = 0;
  ETMFIFOFULL   = 0;
  EDBGRQ        = 0;
  DBGRESTART    = 0;
  TPIUACTV      = 0;
  TPIUBAUD      = 0;
  SLEEPHOLDREQn = 0;
  AUXFAULT      = 0;
  SE            = 0;
  RSTBYPASS     = 0;
  CGBYPASS      = 0;
  STCALIB       = 0;
  BIGEND        = 0;
  DNOTITRANS    = 0;
  STKALIGNINIT  = 0;
  PPBLOCK       = 0;
  VECTADDR      = 0;
  VECTADDREN    = 0;
  TSVALUEB      = 0;
  TSCLKCHANGE   = 0;
  MPUDISABLE    = 0;
  DBGEN         = 0;
  #100;
end




////////////////////////////////////////////////////////////////////////////////
// UUT instance
////////////////////////////////////////////////////////////////////////////////
module CORTEXM3 u_module CORTEXM3 (
  .PORESETn     (PORESETn     ),
  .SYSRESETn    (SYSRESETn    ),
  .FCLK         (FCLK         ),
  .HCLK         (HCLK         ),
  .STCLK        (STCLK        ),
  .DAPCLK       (DAPCLK       ),
  .DAPCLKEN     (DAPCLKEN     ),
  .DAPRESETn    (DAPRESETn    ),
  .HREADYI      (HREADYI      ),
  .HRDATAI      (HRDATAI      ),
  .HRESPI       (HRESPI       ),
  .IFLUSH       (IFLUSH       ),
  .HREADYD      (HREADYD      ),
  .HRDATAD      (HRDATAD      ),
  .HRESPD       (HRESPD       ),
  .EXRESPD      (EXRESPD      ),
  .HREADYS      (HREADYS      ),
  .HRDATAS      (HRDATAS      ),
  .HRESPS       (HRESPS       ),
  .EXRESPS      (EXRESPS      ),
  .PRDATA       (PRDATA       ),
  .PREADY       (PREADY       ),
  .PSLVERR      (PSLVERR      ),
  .DAPEN        (DAPEN        ),
  .DAPSEL       (DAPSEL       ),
  .DAPENABLE    (DAPENABLE    ),
  .DAPWRITE     (DAPWRITE     ),
  .DAPABORT     (DAPABORT     ),
  .DAPADDR      (DAPADDR      ),
  .DAPWDATA     (DAPWDATA     ),
  .FIXMASTERTYPE(FIXMASTERTYPE),
  .INTISR       (INTISR       ),
  .INTNMI       (INTNMI       ),
  .WICDSREQn    (WICDSREQn    ),
  .ATREADY      (ATREADY      ),
  .RXEV         (RXEV         ),
  .ETMPWRUP     (ETMPWRUP     ),
  .ETMFIFOFULL  (ETMFIFOFULL  ),
  .EDBGRQ       (EDBGRQ       ),
  .DBGRESTART   (DBGRESTART   ),
  .TPIUACTV     (TPIUACTV     ),
  .TPIUBAUD     (TPIUBAUD     ),
  .SLEEPHOLDREQn(SLEEPHOLDREQn),
  .AUXFAULT     (AUXFAULT     ),
  .SE           (SE           ),
  .RSTBYPASS    (RSTBYPASS    ),
  .CGBYPASS     (CGBYPASS     ),
  .STCALIB      (STCALIB      ),
  .BIGEND       (BIGEND       ),
  .DNOTITRANS   (DNOTITRANS   ),
  .STKALIGNINIT (STKALIGNINIT ),
  .PPBLOCK      (PPBLOCK      ),
  .VECTADDR     (VECTADDR     ),
  .VECTADDREN   (VECTADDREN   ),
  .TSVALUEB     (TSVALUEB     ),
  .TSCLKCHANGE  (TSCLKCHANGE  ),
  .MPUDISABLE   (MPUDISABLE   ),
  .DBGEN        (DBGEN        ),
  .HADDRI       (HADDRI       ),
  .HTRANSI      (HTRANSI      ),
  .HSIZEI       (HSIZEI       ),
  .HBURSTI      (HBURSTI      ),
  .HPROTI       (HPROTI       ),
  .MEMATTRI     (MEMATTRI     ),
  .BRCHSTAT     (BRCHSTAT     ),
  .HADDRD       (HADDRD       ),
  .HTRANSD      (HTRANSD      ),
  .HMASTERD     (HMASTERD     ),
  .HSIZED       (HSIZED       ),
  .HBURSTD      (HBURSTD      ),
  .HPROTD       (HPROTD       ),
  .MEMATTRD     (MEMATTRD     ),
  .EXREQD       (EXREQD       ),
  .HWRITED      (HWRITED      ),
  .HWDATAD      (HWDATAD      ),
  .HADDRS       (HADDRS       ),
  .HTRANSS      (HTRANSS      ),
  .HMASTERS     (HMASTERS     ),
  .HWRITES      (HWRITES      ),
  .HSIZES       (HSIZES       ),
  .HMASTLOCKS   (HMASTLOCKS   ),
  .HWDATAS      (HWDATAS      ),
  .HBURSTS      (HBURSTS      ),
  .HPROTS       (HPROTS       ),
  .MEMATTRS     (MEMATTRS     ),
  .EXREQS       (EXREQS       ),
  .PSEL         (PSEL         ),
  .PADDR31      (PADDR31      ),
  .PADDR        (PADDR        ),
  .PENABLE      (PENABLE      ),
  .PWRITE       (PWRITE       ),
  .PWDATA       (PWDATA       ),
  .DAPREADY     (DAPREADY     ),
  .DAPSLVERR    (DAPSLVERR    ),
  .DAPRDATA     (DAPRDATA     ),
  .WICDSACKn    (WICDSACKn    ),
  .WICLOAD      (WICLOAD      ),
  .WICCLEAR     (WICCLEAR     ),
  .WICMASKISR   (WICMASKISR   ),
  .WICMASKMON   (WICMASKMON   ),
  .WICMASKNMI   (WICMASKNMI   ),
  .WICMASKRXEV  (WICMASKRXEV  ),
  .ATVALID      (ATVALID      ),
  .AFREADY      (AFREADY      ),
  .ATDATA       (ATDATA       ),
  .TXEV         (TXEV         ),
  .SYSRESETREQ  (SYSRESETREQ  ),
  .ETMTRIGGER   (ETMTRIGGER   ),
  .ETMTRIGINOTD (ETMTRIGINOTD ),
  .ETMIVALID    (ETMIVALID    ),
  .ETMISTALL    (ETMISTALL    ),
  .ETMDVALID    (ETMDVALID    ),
  .ETMFOLD      (ETMFOLD      ),
  .ETMCANCEL    (ETMCANCEL    ),
  .ETMIA        (ETMIA        ),
  .ETMICCFAIL   (ETMICCFAIL   ),
  .ETMIBRANCH   (ETMIBRANCH   ),
  .ETMIINDBR    (ETMIINDBR    ),
  .ETMISB       (ETMISB       ),
  .ETMINTSTAT   (ETMINTSTAT   ),
  .ETMINTNUM    (ETMINTNUM    ),
  .ETMFLUSH     (ETMFLUSH     ),
  .ETMFINDBR    (ETMFINDBR    ),
  .DSYNC        (DSYNC        ),
  .DBGRESTARTED (DBGRESTARTED ),
  .HTMDHADDR    (HTMDHADDR    ),
  .HTMDHTRANS   (HTMDHTRANS   ),
  .HTMDHSIZE    (HTMDHSIZE    ),
  .HTMDHBURST   (HTMDHBURST   ),
  .HTMDHPROT    (HTMDHPROT    ),
  .HTMDHWDATA   (HTMDHWDATA   ),
  .HTMDHWRITE   (HTMDHWRITE   ),
  .HTMDHRDATA   (HTMDHRDATA   ),
  .HTMDHREADY   (HTMDHREADY   ),
  .HTMDHRESP    (HTMDHRESP    ),
  .ATIDITM      (ATIDITM      ),
  .SLEEPHOLDACKn(SLEEPHOLDACKn),
  .SLEEPING     (SLEEPING     ),
  .SLEEPDEEP    (SLEEPDEEP    ),
  .HALTED       (HALTED       ),
  .LOCKUP       (LOCKUP       ),
  .CURRPRI      (CURRPRI      ),
  .TRCENA       (TRCENA       ),
  .INTERNALSTATE(INTERNALSTATE)
);



////////////////////////////////////////////////////////////////////////////////
// Clock Generate use if you need
////////////////////////////////////////////////////////////////////////////////
// always #5 clk = ~clk


endmodule
