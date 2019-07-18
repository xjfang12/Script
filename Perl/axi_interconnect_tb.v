`timescale 1ns/1ps
`define P_MAX_S 16
`define P_MAX_M 16
`define P_NUM_ADDR_RANGES 16
////////////////////////////////////////////////////////////////////////////////
//
// Filename:    axi_interconnect_tb.v
// Author:      FangXinjia
// Create Time: Mon Jul 15 13:33:24 2019
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
module axi_interconnect_tb; 
////////////////////////////////////////////////////////////////////////////////
// Parameter list
////////////////////////////////////////////////////////////////////////////////
parameter                                      C_BASEFAMILY                     = "rtl"                                               ;
parameter integer                              C_NUM_SLAVE_SLOTS                = 1                                                   ;
parameter integer                              C_NUM_MASTER_SLOTS               = 1                                                   ;
parameter integer                              C_AXI_ID_WIDTH                   = 1                                                   ;
parameter integer                              C_AXI_ADDR_WIDTH                 = 32                                                  ;
parameter integer                              C_AXI_DATA_MAX_WIDTH             = 32                                                  ;
parameter [(`P_MAX_S*32-1):0]                  C_S_AXI_DATA_WIDTH               = {`P_MAX_S{32'h00000020}}                            ;
parameter [(`P_MAX_S*32-1):0]                  C_S_AXI_DATA_WIDTH               = {`P_MAX_S{32'h00000020}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_DATA_WIDTH               = {`P_MAX_M{32'h00000020}}                            ;
parameter integer                              C_INTERCONNECT_DATA_WIDTH        = 32                                                  ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_PROTOCOL                 = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_PROTOCOL                 = {`P_MAX_M{32'h00000000}}                            ;
parameter [`P_MAX_M*`P_NUM_ADDR_RANGES*64-1:0] C_M_AXI_BASE_ADDR                = {`P_MAX_M*`P_NUM_ADDR_RANGES{64'hFFFFFFFF_FFFFFFFF}};
parameter [`P_MAX_M*`P_NUM_ADDR_RANGES*64-1:0] C_M_AXI_HIGH_ADDR                = {`P_MAX_M*`P_NUM_ADDR_RANGES{64'h00000000_00000000}};
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_BASE_ID                  = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_THREAD_ID_WIDTH          = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_IS_INTERCONNECT          = {`P_MAX_S{1'b0}}                                    ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_ACLK_RATIO               = {`P_MAX_S{32'h00000001}}                            ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_IS_ACLK_ASYNC            = {`P_MAX_S{1'b0}}                                    ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_ACLK_RATIO               = {`P_MAX_M{32'h00000001}}                            ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_IS_ACLK_ASYNC            = {`P_MAX_M{1'b0}}                                    ;
parameter integer                              C_INTERCONNECT_ACLK_RATIO        = 1                                                   ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_SUPPORTS_WRITE           = {`P_MAX_S{1'b1}}                                    ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_SUPPORTS_READ            = {`P_MAX_S{1'b1}}                                    ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_SUPPORTS_WRITE           = {`P_MAX_M{1'b1}}                                    ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_SUPPORTS_READ            = {`P_MAX_M{1'b1}}                                    ;
parameter integer                              C_AXI_SUPPORTS_USER_SIGNALS      = 0                                                   ;
parameter integer                              C_AXI_AWUSER_WIDTH               = 1                                                   ;
parameter integer                              C_AXI_ARUSER_WIDTH               = 1                                                   ;
parameter integer                              C_AXI_WUSER_WIDTH                = 1                                                   ;
parameter integer                              C_AXI_RUSER_WIDTH                = 1                                                   ;
parameter integer                              C_AXI_BUSER_WIDTH                = 1                                                   ;
parameter [`P_MAX_M*32-1:0]                    C_AXI_CONNECTIVITY               = {`P_MAX_M{32'hFFFFFFFF}}                            ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_SINGLE_THREAD            = {`P_MAX_S{1'b0}}                                    ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_SUPPORTS_REORDERING      = {`P_MAX_M{1'b1}}                                    ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_SUPPORTS_NARROW_BURST    = {`P_MAX_S{1'b1}}                                    ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_SUPPORTS_NARROW_BURST    = {`P_MAX_M{1'b1}}                                    ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_WRITE_ACCEPTANCE         = {`P_MAX_S{32'h00000001}}                            ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_READ_ACCEPTANCE          = {`P_MAX_S{32'h00000001}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_WRITE_ISSUING            = {`P_MAX_M{32'h00000001}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_READ_ISSUING             = {`P_MAX_M{32'h00000001}}                            ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_ARB_PRIORITY             = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_SECURE                   = {`P_MAX_M{1'b0}}                                    ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_WRITE_FIFO_DEPTH         = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_WRITE_FIFO_TYPE          = {`P_MAX_S{1'b1}}                                    ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_WRITE_FIFO_DELAY         = {`P_MAX_S{1'b0}}                                    ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_READ_FIFO_DEPTH          = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_READ_FIFO_TYPE           = {`P_MAX_S{1'b1}}                                    ;
parameter [`P_MAX_S*1-1:0]                     C_S_AXI_READ_FIFO_DELAY          = {`P_MAX_S{1'b0}}                                    ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_WRITE_FIFO_DEPTH         = {`P_MAX_M{32'h00000000}}                            ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_WRITE_FIFO_TYPE          = {`P_MAX_M{1'b1}}                                    ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_WRITE_FIFO_DELAY         = {`P_MAX_M{1'b0}}                                    ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_READ_FIFO_DEPTH          = {`P_MAX_M{32'h00000000}}                            ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_READ_FIFO_TYPE           = {`P_MAX_M{1'b1}}                                    ;
parameter [`P_MAX_M*1-1:0]                     C_M_AXI_READ_FIFO_DELAY          = {`P_MAX_M{1'b0}}                                    ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_AW_REGISTER              = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_AR_REGISTER              = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_W_REGISTER               = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_R_REGISTER               = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_S*32-1:0]                    C_S_AXI_B_REGISTER               = {`P_MAX_S{32'h00000000}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_AW_REGISTER              = {`P_MAX_M{32'h00000000}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_AR_REGISTER              = {`P_MAX_M{32'h00000000}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_W_REGISTER               = {`P_MAX_M{32'h00000000}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_R_REGISTER               = {`P_MAX_M{32'h00000000}}                            ;
parameter [`P_MAX_M*32-1:0]                    C_M_AXI_B_REGISTER               = {`P_MAX_M{32'h00000000}}                            ;
parameter integer                              C_INTERCONNECT_R_REGISTER        = 0                                                   ;
parameter integer                              C_USE_CTRL_PORT                  = 0                                                   ;
parameter integer                              C_USE_INTERRUPT                  = 1                                                   ;
parameter integer                              C_RANGE_CHECK                    = 2                                                   ;
parameter integer                              C_S_AXI_CTRL_ADDR_WIDTH          = 32                                                  ;
parameter integer                              C_S_AXI_CTRL_DATA_WIDTH          = 32                                                  ;
parameter integer                              C_INTERCONNECT_CONNECTIVITY_MODE = 1                                                   ;
parameter integer                              C_DEBUG                          = 1                                                   ;
parameter integer                              C_S_AXI_DEBUG_SLOT               = 0                                                   ;
parameter integer                              C_M_AXI_DEBUG_SLOT               = 0                                                   ;
parameter integer                              C_MAX_DEBUG_THREADS              = 1                                                   ;
////////////////////////////////////////////////////////////////////////////////
// signal list
////////////////////////////////////////////////////////////////////////////////
reg                                                  INTERCONNECT_ACLK        ;
reg                                                  INTERCONNECT_ARESETN     ;
wire                                                 IRQ                      ;
wire [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_ARESET_OUT_N       ;
wire [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_ARESET_OUT_N       ;
wire                                                 INTERCONNECT_ARESET_OUT_N;
reg  [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_ACLK               ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_ID_WIDTH-1:0]          S_AXI_AWID               ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_ADDR_WIDTH-1:0]        S_AXI_AWADDR             ;
reg  [C_NUM_SLAVE_SLOTS*8-1:0]                       S_AXI_AWLEN              ;
reg  [C_NUM_SLAVE_SLOTS*3-1:0]                       S_AXI_AWSIZE             ;
reg  [C_NUM_SLAVE_SLOTS*2-1:0]                       S_AXI_AWBURST            ;
reg  [C_NUM_SLAVE_SLOTS*2-1:0]                       S_AXI_AWLOCK             ;
reg  [C_NUM_SLAVE_SLOTS*4-1:0]                       S_AXI_AWCACHE            ;
reg  [C_NUM_SLAVE_SLOTS*3-1:0]                       S_AXI_AWPROT             ;
reg  [C_NUM_SLAVE_SLOTS*4-1:0]                       S_AXI_AWQOS              ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_AWUSER_WIDTH-1:0]      S_AXI_AWUSER             ;
reg  [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_AWVALID            ;
wire [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_AWREADY            ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_ID_WIDTH-1:0]          S_AXI_WID                ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_DATA_MAX_WIDTH-1:0]    S_AXI_WDATA              ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_DATA_MAX_WIDTH/8-1:0]  S_AXI_WSTRB              ;
reg  [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_WLAST              ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_WUSER_WIDTH-1:0]       S_AXI_WUSER              ;
reg  [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_WVALID             ;
wire [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_WREADY             ;
wire [C_NUM_SLAVE_SLOTS*C_AXI_ID_WIDTH-1:0]          S_AXI_BID                ;
wire [C_NUM_SLAVE_SLOTS*2-1:0]                       S_AXI_BRESP              ;
wire [C_NUM_SLAVE_SLOTS*C_AXI_BUSER_WIDTH-1:0]       S_AXI_BUSER              ;
wire [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_BVALID             ;
reg  [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_BREADY             ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_ID_WIDTH-1:0]          S_AXI_ARID               ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_ADDR_WIDTH-1:0]        S_AXI_ARADDR             ;
reg  [C_NUM_SLAVE_SLOTS*8-1:0]                       S_AXI_ARLEN              ;
reg  [C_NUM_SLAVE_SLOTS*3-1:0]                       S_AXI_ARSIZE             ;
reg  [C_NUM_SLAVE_SLOTS*2-1:0]                       S_AXI_ARBURST            ;
reg  [C_NUM_SLAVE_SLOTS*2-1:0]                       S_AXI_ARLOCK             ;
reg  [C_NUM_SLAVE_SLOTS*4-1:0]                       S_AXI_ARCACHE            ;
reg  [C_NUM_SLAVE_SLOTS*3-1:0]                       S_AXI_ARPROT             ;
reg  [C_NUM_SLAVE_SLOTS*4-1:0]                       S_AXI_ARQOS              ;
reg  [C_NUM_SLAVE_SLOTS*C_AXI_ARUSER_WIDTH-1:0]      S_AXI_ARUSER             ;
reg  [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_ARVALID            ;
wire [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_ARREADY            ;
wire [C_NUM_SLAVE_SLOTS*C_AXI_ID_WIDTH-1:0]          S_AXI_RID                ;
wire [C_NUM_SLAVE_SLOTS*C_AXI_DATA_MAX_WIDTH-1:0]    S_AXI_RDATA              ;
wire [C_NUM_SLAVE_SLOTS*2-1:0]                       S_AXI_RRESP              ;
wire [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_RLAST              ;
wire [C_NUM_SLAVE_SLOTS*C_AXI_RUSER_WIDTH-1:0]       S_AXI_RUSER              ;
wire [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_RVALID             ;
reg  [C_NUM_SLAVE_SLOTS-1:0]                         S_AXI_RREADY             ;
reg  [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_ACLK               ;
wire [C_NUM_MASTER_SLOTS*C_AXI_ID_WIDTH-1:0]         M_AXI_AWID               ;
wire [C_NUM_MASTER_SLOTS*C_AXI_ADDR_WIDTH-1:0]       M_AXI_AWADDR             ;
wire [C_NUM_MASTER_SLOTS*8-1:0]                      M_AXI_AWLEN              ;
wire [C_NUM_MASTER_SLOTS*3-1:0]                      M_AXI_AWSIZE             ;
wire [C_NUM_MASTER_SLOTS*2-1:0]                      M_AXI_AWBURST            ;
wire [C_NUM_MASTER_SLOTS*2-1:0]                      M_AXI_AWLOCK             ;
wire [C_NUM_MASTER_SLOTS*4-1:0]                      M_AXI_AWCACHE            ;
wire [C_NUM_MASTER_SLOTS*3-1:0]                      M_AXI_AWPROT             ;
wire [C_NUM_MASTER_SLOTS*4-1:0]                      M_AXI_AWREGION           ;
wire [C_NUM_MASTER_SLOTS*4-1:0]                      M_AXI_AWQOS              ;
wire [C_NUM_MASTER_SLOTS*C_AXI_AWUSER_WIDTH-1:0]     M_AXI_AWUSER             ;
wire [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_AWVALID            ;
reg  [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_AWREADY            ;
wire [C_NUM_MASTER_SLOTS*C_AXI_ID_WIDTH-1:0]         M_AXI_WID                ;
wire [C_NUM_MASTER_SLOTS*C_AXI_DATA_MAX_WIDTH-1:0]   M_AXI_WDATA              ;
wire [C_NUM_MASTER_SLOTS*C_AXI_DATA_MAX_WIDTH/8-1:0] M_AXI_WSTRB              ;
wire [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_WLAST              ;
wire [C_NUM_MASTER_SLOTS*C_AXI_WUSER_WIDTH-1:0]      M_AXI_WUSER              ;
wire [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_WVALID             ;
reg  [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_WREADY             ;
reg  [C_NUM_MASTER_SLOTS*C_AXI_ID_WIDTH-1:0]         M_AXI_BID                ;
reg  [C_NUM_MASTER_SLOTS*2-1:0]                      M_AXI_BRESP              ;
reg  [C_NUM_MASTER_SLOTS*C_AXI_BUSER_WIDTH-1:0]      M_AXI_BUSER              ;
reg  [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_BVALID             ;
wire [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_BREADY             ;
wire [C_NUM_MASTER_SLOTS*C_AXI_ID_WIDTH-1:0]         M_AXI_ARID               ;
wire [C_NUM_MASTER_SLOTS*C_AXI_ADDR_WIDTH-1:0]       M_AXI_ARADDR             ;
wire [C_NUM_MASTER_SLOTS*8-1:0]                      M_AXI_ARLEN              ;
wire [C_NUM_MASTER_SLOTS*3-1:0]                      M_AXI_ARSIZE             ;
wire [C_NUM_MASTER_SLOTS*2-1:0]                      M_AXI_ARBURST            ;
wire [C_NUM_MASTER_SLOTS*2-1:0]                      M_AXI_ARLOCK             ;
wire [C_NUM_MASTER_SLOTS*4-1:0]                      M_AXI_ARCACHE            ;
wire [C_NUM_MASTER_SLOTS*3-1:0]                      M_AXI_ARPROT             ;
wire [C_NUM_MASTER_SLOTS*4-1:0]                      M_AXI_ARREGION           ;
wire [C_NUM_MASTER_SLOTS*4-1:0]                      M_AXI_ARQOS              ;
wire [C_NUM_MASTER_SLOTS*C_AXI_ARUSER_WIDTH-1:0]     M_AXI_ARUSER             ;
wire [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_ARVALID            ;
reg  [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_ARREADY            ;
reg  [C_NUM_MASTER_SLOTS*C_AXI_ID_WIDTH-1:0]         M_AXI_RID                ;
reg  [C_NUM_MASTER_SLOTS*C_AXI_DATA_MAX_WIDTH-1:0]   M_AXI_RDATA              ;
reg  [C_NUM_MASTER_SLOTS*2-1:0]                      M_AXI_RRESP              ;
reg  [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_RLAST              ;
reg  [C_NUM_MASTER_SLOTS*C_AXI_RUSER_WIDTH-1:0]      M_AXI_RUSER              ;
reg  [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_RVALID             ;
wire [C_NUM_MASTER_SLOTS-1:0]                        M_AXI_RREADY             ;
reg  [(C_S_AXI_CTRL_ADDR_WIDTH-1):0]                 S_AXI_CTRL_AWADDR        ;
reg                                                  S_AXI_CTRL_AWVALID       ;
wire                                                 S_AXI_CTRL_AWREADY       ;
reg  [(C_S_AXI_CTRL_DATA_WIDTH-1):0]                 S_AXI_CTRL_WDATA         ;
reg                                                  S_AXI_CTRL_WVALID        ;
wire                                                 S_AXI_CTRL_WREADY        ;
wire [1:0]                                           S_AXI_CTRL_BRESP         ;
wire                                                 S_AXI_CTRL_BVALID        ;
reg                                                  S_AXI_CTRL_BREADY        ;
reg  [(C_S_AXI_CTRL_ADDR_WIDTH-1):0]                 S_AXI_CTRL_ARADDR        ;
reg                                                  S_AXI_CTRL_ARVALID       ;
wire                                                 S_AXI_CTRL_ARREADY       ;
wire [(C_S_AXI_CTRL_DATA_WIDTH-1):0]                 S_AXI_CTRL_RDATA         ;
wire [1:0]                                           S_AXI_CTRL_RRESP         ;
wire                                                 S_AXI_CTRL_RVALID        ;
reg                                                  S_AXI_CTRL_RREADY        ;
wire [8-1:0]                                         DEBUG_AW_TRANS_SEQ       ;
wire [8-1:0]                                         DEBUG_AW_ARB_GRANT       ;
wire [8-1:0]                                         DEBUG_AR_TRANS_SEQ       ;
wire [8-1:0]                                         DEBUG_AR_ARB_GRANT       ;
wire [C_MAX_DEBUG_THREADS-1:0]                       DEBUG_AW_TRANS_QUAL      ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_AW_ACCEPT_CNT      ;
wire [16-1:0]                                        DEBUG_AW_ACTIVE_THREAD   ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_AW_ACTIVE_TARGET   ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_AW_ACTIVE_REGION   ;
wire [8-1:0]                                         DEBUG_AW_ERROR           ;
wire [8-1:0]                                         DEBUG_AW_TARGET          ;
wire [C_MAX_DEBUG_THREADS-1:0]                       DEBUG_AR_TRANS_QUAL      ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_AR_ACCEPT_CNT      ;
wire [16-1:0]                                        DEBUG_AR_ACTIVE_THREAD   ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_AR_ACTIVE_TARGET   ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_AR_ACTIVE_REGION   ;
wire [8-1:0]                                         DEBUG_AR_ERROR           ;
wire [8-1:0]                                         DEBUG_AR_TARGET          ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_B_TRANS_SEQ        ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_R_BEAT_CNT         ;
wire [C_MAX_DEBUG_THREADS*8-1:0]                     DEBUG_R_TRANS_SEQ        ;
wire [8-1:0]                                         DEBUG_AW_ISSUING_CNT     ;
wire [8-1:0]                                         DEBUG_AR_ISSUING_CNT     ;
wire [8-1:0]                                         DEBUG_W_BEAT_CNT         ;
wire [8-1:0]                                         DEBUG_W_TRANS_SEQ        ;
wire [8-1:0]                                         DEBUG_BID_TARGET         ;
wire                                                 DEBUG_BID_ERROR          ;
wire [8-1:0]                                         DEBUG_RID_TARGET         ;
wire                                                 DEBUG_RID_ERROR          ;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_SR_SC_ARADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_SR_SC_ARADDRCONTROL;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_SR_SC_AWADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_SR_SC_AWADDRCONTROL;
wire [(1+1+2+C_AXI_ID_WIDTH)-1:0]                    DEBUG_SR_SC_BRESP        ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_SR_SC_RDATA        ;
wire [(1+1+1+2+C_AXI_ID_WIDTH)-1:0]                  DEBUG_SR_SC_RDATACONTROL ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_SR_SC_WDATA        ;
wire [(1+1+1+(C_AXI_DATA_MAX_WIDTH/8))-1:0]          DEBUG_SR_SC_WDATACONTROL ;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_SC_SF_ARADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_SC_SF_ARADDRCONTROL;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_SC_SF_AWADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_SC_SF_AWADDRCONTROL;
wire [(1+1+2+C_AXI_ID_WIDTH)-1:0]                    DEBUG_SC_SF_BRESP        ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_SC_SF_RDATA        ;
wire [(1+1+1+2+C_AXI_ID_WIDTH)-1:0]                  DEBUG_SC_SF_RDATACONTROL ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_SC_SF_WDATA        ;
wire [(1+1+1+(C_AXI_DATA_MAX_WIDTH/8))-1:0]          DEBUG_SC_SF_WDATACONTROL ;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_SF_CB_ARADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_SF_CB_ARADDRCONTROL;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_SF_CB_AWADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_SF_CB_AWADDRCONTROL;
wire [(1+1+2+C_AXI_ID_WIDTH)-1:0]                    DEBUG_SF_CB_BRESP        ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_SF_CB_RDATA        ;
wire [(1+1+1+2+C_AXI_ID_WIDTH)-1:0]                  DEBUG_SF_CB_RDATACONTROL ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_SF_CB_WDATA        ;
wire [(1+1+1+(C_AXI_DATA_MAX_WIDTH/8))-1:0]          DEBUG_SF_CB_WDATACONTROL ;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_CB_MF_ARADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_CB_MF_ARADDRCONTROL;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_CB_MF_AWADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_CB_MF_AWADDRCONTROL;
wire [(1+1+2+C_AXI_ID_WIDTH)-1:0]                    DEBUG_CB_MF_BRESP        ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_CB_MF_RDATA        ;
wire [(1+1+1+2+C_AXI_ID_WIDTH)-1:0]                  DEBUG_CB_MF_RDATACONTROL ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_CB_MF_WDATA        ;
wire [(1+1+1+(C_AXI_DATA_MAX_WIDTH/8))-1:0]          DEBUG_CB_MF_WDATACONTROL ;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_MF_MC_ARADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_MF_MC_ARADDRCONTROL;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_MF_MC_AWADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_MF_MC_AWADDRCONTROL;
wire [(1+1+2+C_AXI_ID_WIDTH)-1:0]                    DEBUG_MF_MC_BRESP        ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_MF_MC_RDATA        ;
wire [(1+1+1+2+C_AXI_ID_WIDTH)-1:0]                  DEBUG_MF_MC_RDATACONTROL ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_MF_MC_WDATA        ;
wire [(1+1+1+(C_AXI_DATA_MAX_WIDTH/8))-1:0]          DEBUG_MF_MC_WDATACONTROL ;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_MC_MP_ARADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_MC_MP_ARADDRCONTROL;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_MC_MP_AWADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_MC_MP_AWADDRCONTROL;
wire [(1+1+2+C_AXI_ID_WIDTH)-1:0]                    DEBUG_MC_MP_BRESP        ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_MC_MP_RDATA        ;
wire [(1+1+1+2+C_AXI_ID_WIDTH)-1:0]                  DEBUG_MC_MP_RDATACONTROL ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_MC_MP_WDATA        ;
wire [(1+1+1+(C_AXI_DATA_MAX_WIDTH/8))-1:0]          DEBUG_MC_MP_WDATACONTROL ;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_MP_MR_ARADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_MP_MR_ARADDRCONTROL;
wire [C_AXI_ADDR_WIDTH-1:0]                          DEBUG_MP_MR_AWADDR       ;
wire [(1+1+8+3+2+1+4+3+C_AXI_ID_WIDTH)-1:0]          DEBUG_MP_MR_AWADDRCONTROL;
wire [(1+1+2+C_AXI_ID_WIDTH)-1:0]                    DEBUG_MP_MR_BRESP        ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_MP_MR_RDATA        ;
wire [(1+1+1+2+C_AXI_ID_WIDTH)-1:0]                  DEBUG_MP_MR_RDATACONTROL ;
wire [C_AXI_DATA_MAX_WIDTH-1:0]                      DEBUG_MP_MR_WDATA        ;
wire [(1+1+1+(C_AXI_DATA_MAX_WIDTH/8))-1:0]          DEBUG_MP_MR_WDATACONTROL ;


////////////////////////////////////////////////////////////////////////////////
// initial block
initial begin
  INTERCONNECT_ACLK         = 0;
  INTERCONNECT_ARESETN      = 0;
  S_AXI_ACLK                = 0;
  S_AXI_AWID                = 0;
  S_AXI_AWADDR              = 0;
  S_AXI_AWLEN               = 0;
  S_AXI_AWSIZE              = 0;
  S_AXI_AWBURST             = 0;
  S_AXI_AWLOCK              = 0;
  S_AXI_AWCACHE             = 0;
  S_AXI_AWPROT              = 0;
  S_AXI_AWQOS               = 0;
  S_AXI_AWUSER              = 0;
  S_AXI_AWVALID             = 0;
  S_AXI_WID                 = 0;
  S_AXI_WDATA               = 0;
  S_AXI_WSTRB               = 0;
  S_AXI_WLAST               = 0;
  S_AXI_WUSER               = 0;
  S_AXI_WVALID              = 0;
  S_AXI_BREADY              = 0;
  S_AXI_ARID                = 0;
  S_AXI_ARADDR              = 0;
  S_AXI_ARLEN               = 0;
  S_AXI_ARSIZE              = 0;
  S_AXI_ARBURST             = 0;
  S_AXI_ARLOCK              = 0;
  S_AXI_ARCACHE             = 0;
  S_AXI_ARPROT              = 0;
  S_AXI_ARQOS               = 0;
  S_AXI_ARUSER              = 0;
  S_AXI_ARVALID             = 0;
  S_AXI_RREADY              = 0;
  M_AXI_ACLK                = 0;
  M_AXI_AWREADY             = 0;
  M_AXI_WREADY              = 0;
  M_AXI_BID                 = 0;
  M_AXI_BRESP               = 0;
  M_AXI_BUSER               = 0;
  M_AXI_BVALID              = 0;
  M_AXI_ARREADY             = 0;
  M_AXI_RID                 = 0;
  M_AXI_RDATA               = 0;
  M_AXI_RRESP               = 0;
  M_AXI_RLAST               = 0;
  M_AXI_RUSER               = 0;
  M_AXI_RVALID              = 0;
  S_AXI_CTRL_AWADDR         = 0;
  S_AXI_CTRL_AWVALID        = 0;
  S_AXI_CTRL_WDATA          = 0;
  S_AXI_CTRL_WVALID         = 0;
  S_AXI_CTRL_BREADY         = 0;
  S_AXI_CTRL_ARADDR         = 0;
  S_AXI_CTRL_ARVALID        = 0;
  S_AXI_CTRL_RREADY         = 0;
  #100;
end




////////////////////////////////////////////////////////////////////////////////
// UUT instance
////////////////////////////////////////////////////////////////////////////////
axi_interconnect #(
  .C_BASEFAMILY                    (C_BASEFAMILY                    ),
  .C_NUM_SLAVE_SLOTS               (C_NUM_SLAVE_SLOTS               ),
  .C_NUM_MASTER_SLOTS              (C_NUM_MASTER_SLOTS              ),
  .C_AXI_ID_WIDTH                  (C_AXI_ID_WIDTH                  ),
  .C_AXI_ADDR_WIDTH                (C_AXI_ADDR_WIDTH                ),
  .C_AXI_DATA_MAX_WIDTH            (C_AXI_DATA_MAX_WIDTH            ),
  .C_S_AXI_DATA_WIDTH              (C_S_AXI_DATA_WIDTH              ),
  .C_S_AXI_DATA_WIDTH              (C_S_AXI_DATA_WIDTH              ),
  .C_M_AXI_DATA_WIDTH              (C_M_AXI_DATA_WIDTH              ),
  .C_INTERCONNECT_DATA_WIDTH       (C_INTERCONNECT_DATA_WIDTH       ),
  .C_S_AXI_PROTOCOL                (C_S_AXI_PROTOCOL                ),
  .C_M_AXI_PROTOCOL                (C_M_AXI_PROTOCOL                ),
  .C_M_AXI_BASE_ADDR               (C_M_AXI_BASE_ADDR               ),
  .C_M_AXI_HIGH_ADDR               (C_M_AXI_HIGH_ADDR               ),
  .C_S_AXI_BASE_ID                 (C_S_AXI_BASE_ID                 ),
  .C_S_AXI_THREAD_ID_WIDTH         (C_S_AXI_THREAD_ID_WIDTH         ),
  .C_S_AXI_IS_INTERCONNECT         (C_S_AXI_IS_INTERCONNECT         ),
  .C_S_AXI_ACLK_RATIO              (C_S_AXI_ACLK_RATIO              ),
  .C_S_AXI_IS_ACLK_ASYNC           (C_S_AXI_IS_ACLK_ASYNC           ),
  .C_M_AXI_ACLK_RATIO              (C_M_AXI_ACLK_RATIO              ),
  .C_M_AXI_IS_ACLK_ASYNC           (C_M_AXI_IS_ACLK_ASYNC           ),
  .C_INTERCONNECT_ACLK_RATIO       (C_INTERCONNECT_ACLK_RATIO       ),
  .C_S_AXI_SUPPORTS_WRITE          (C_S_AXI_SUPPORTS_WRITE          ),
  .C_S_AXI_SUPPORTS_READ           (C_S_AXI_SUPPORTS_READ           ),
  .C_M_AXI_SUPPORTS_WRITE          (C_M_AXI_SUPPORTS_WRITE          ),
  .C_M_AXI_SUPPORTS_READ           (C_M_AXI_SUPPORTS_READ           ),
  .C_AXI_SUPPORTS_USER_SIGNALS     (C_AXI_SUPPORTS_USER_SIGNALS     ),
  .C_AXI_AWUSER_WIDTH              (C_AXI_AWUSER_WIDTH              ),
  .C_AXI_ARUSER_WIDTH              (C_AXI_ARUSER_WIDTH              ),
  .C_AXI_WUSER_WIDTH               (C_AXI_WUSER_WIDTH               ),
  .C_AXI_RUSER_WIDTH               (C_AXI_RUSER_WIDTH               ),
  .C_AXI_BUSER_WIDTH               (C_AXI_BUSER_WIDTH               ),
  .C_AXI_CONNECTIVITY              (C_AXI_CONNECTIVITY              ),
  .C_S_AXI_SINGLE_THREAD           (C_S_AXI_SINGLE_THREAD           ),
  .C_M_AXI_SUPPORTS_REORDERING     (C_M_AXI_SUPPORTS_REORDERING     ),
  .C_S_AXI_SUPPORTS_NARROW_BURST   (C_S_AXI_SUPPORTS_NARROW_BURST   ),
  .C_M_AXI_SUPPORTS_NARROW_BURST   (C_M_AXI_SUPPORTS_NARROW_BURST   ),
  .C_S_AXI_WRITE_ACCEPTANCE        (C_S_AXI_WRITE_ACCEPTANCE        ),
  .C_S_AXI_READ_ACCEPTANCE         (C_S_AXI_READ_ACCEPTANCE         ),
  .C_M_AXI_WRITE_ISSUING           (C_M_AXI_WRITE_ISSUING           ),
  .C_M_AXI_READ_ISSUING            (C_M_AXI_READ_ISSUING            ),
  .C_S_AXI_ARB_PRIORITY            (C_S_AXI_ARB_PRIORITY            ),
  .C_M_AXI_SECURE                  (C_M_AXI_SECURE                  ),
  .C_S_AXI_WRITE_FIFO_DEPTH        (C_S_AXI_WRITE_FIFO_DEPTH        ),
  .C_S_AXI_WRITE_FIFO_TYPE         (C_S_AXI_WRITE_FIFO_TYPE         ),
  .C_S_AXI_WRITE_FIFO_DELAY        (C_S_AXI_WRITE_FIFO_DELAY        ),
  .C_S_AXI_READ_FIFO_DEPTH         (C_S_AXI_READ_FIFO_DEPTH         ),
  .C_S_AXI_READ_FIFO_TYPE          (C_S_AXI_READ_FIFO_TYPE          ),
  .C_S_AXI_READ_FIFO_DELAY         (C_S_AXI_READ_FIFO_DELAY         ),
  .C_M_AXI_WRITE_FIFO_DEPTH        (C_M_AXI_WRITE_FIFO_DEPTH        ),
  .C_M_AXI_WRITE_FIFO_TYPE         (C_M_AXI_WRITE_FIFO_TYPE         ),
  .C_M_AXI_WRITE_FIFO_DELAY        (C_M_AXI_WRITE_FIFO_DELAY        ),
  .C_M_AXI_READ_FIFO_DEPTH         (C_M_AXI_READ_FIFO_DEPTH         ),
  .C_M_AXI_READ_FIFO_TYPE          (C_M_AXI_READ_FIFO_TYPE          ),
  .C_M_AXI_READ_FIFO_DELAY         (C_M_AXI_READ_FIFO_DELAY         ),
  .C_S_AXI_AW_REGISTER             (C_S_AXI_AW_REGISTER             ),
  .C_S_AXI_AR_REGISTER             (C_S_AXI_AR_REGISTER             ),
  .C_S_AXI_W_REGISTER              (C_S_AXI_W_REGISTER              ),
  .C_S_AXI_R_REGISTER              (C_S_AXI_R_REGISTER              ),
  .C_S_AXI_B_REGISTER              (C_S_AXI_B_REGISTER              ),
  .C_M_AXI_AW_REGISTER             (C_M_AXI_AW_REGISTER             ),
  .C_M_AXI_AR_REGISTER             (C_M_AXI_AR_REGISTER             ),
  .C_M_AXI_W_REGISTER              (C_M_AXI_W_REGISTER              ),
  .C_M_AXI_R_REGISTER              (C_M_AXI_R_REGISTER              ),
  .C_M_AXI_B_REGISTER              (C_M_AXI_B_REGISTER              ),
  .C_INTERCONNECT_R_REGISTER       (C_INTERCONNECT_R_REGISTER       ),
  .C_USE_CTRL_PORT                 (C_USE_CTRL_PORT                 ),
  .C_USE_INTERRUPT                 (C_USE_INTERRUPT                 ),
  .C_RANGE_CHECK                   (C_RANGE_CHECK                   ),
  .C_S_AXI_CTRL_ADDR_WIDTH         (C_S_AXI_CTRL_ADDR_WIDTH         ),
  .C_S_AXI_CTRL_DATA_WIDTH         (C_S_AXI_CTRL_DATA_WIDTH         ),
  .C_INTERCONNECT_CONNECTIVITY_MODE(C_INTERCONNECT_CONNECTIVITY_MODE),
  .C_DEBUG                         (C_DEBUG                         ),
  .C_S_AXI_DEBUG_SLOT              (C_S_AXI_DEBUG_SLOT              ),
  .C_M_AXI_DEBUG_SLOT              (C_M_AXI_DEBUG_SLOT              ),
  .C_MAX_DEBUG_THREADS             (C_MAX_DEBUG_THREADS             )
u_axi_interconnect (
  .INTERCONNECT_ACLK        (INTERCONNECT_ACLK        ),
  .INTERCONNECT_ARESETN     (INTERCONNECT_ARESETN     ),
  .IRQ                      (IRQ                      ),
  .S_AXI_ARESET_OUT_N       (S_AXI_ARESET_OUT_N       ),
  .M_AXI_ARESET_OUT_N       (M_AXI_ARESET_OUT_N       ),
  .INTERCONNECT_ARESET_OUT_N(INTERCONNECT_ARESET_OUT_N),
  .S_AXI_ACLK               (S_AXI_ACLK               ),
  .S_AXI_AWID               (S_AXI_AWID               ),
  .S_AXI_AWADDR             (S_AXI_AWADDR             ),
  .S_AXI_AWLEN              (S_AXI_AWLEN              ),
  .S_AXI_AWSIZE             (S_AXI_AWSIZE             ),
  .S_AXI_AWBURST            (S_AXI_AWBURST            ),
  .S_AXI_AWLOCK             (S_AXI_AWLOCK             ),
  .S_AXI_AWCACHE            (S_AXI_AWCACHE            ),
  .S_AXI_AWPROT             (S_AXI_AWPROT             ),
  .S_AXI_AWQOS              (S_AXI_AWQOS              ),
  .S_AXI_AWUSER             (S_AXI_AWUSER             ),
  .S_AXI_AWVALID            (S_AXI_AWVALID            ),
  .S_AXI_AWREADY            (S_AXI_AWREADY            ),
  .S_AXI_WID                (S_AXI_WID                ),
  .S_AXI_WDATA              (S_AXI_WDATA              ),
  .S_AXI_WSTRB              (S_AXI_WSTRB              ),
  .S_AXI_WLAST              (S_AXI_WLAST              ),
  .S_AXI_WUSER              (S_AXI_WUSER              ),
  .S_AXI_WVALID             (S_AXI_WVALID             ),
  .S_AXI_WREADY             (S_AXI_WREADY             ),
  .S_AXI_BID                (S_AXI_BID                ),
  .S_AXI_BRESP              (S_AXI_BRESP              ),
  .S_AXI_BUSER              (S_AXI_BUSER              ),
  .S_AXI_BVALID             (S_AXI_BVALID             ),
  .S_AXI_BREADY             (S_AXI_BREADY             ),
  .S_AXI_ARID               (S_AXI_ARID               ),
  .S_AXI_ARADDR             (S_AXI_ARADDR             ),
  .S_AXI_ARLEN              (S_AXI_ARLEN              ),
  .S_AXI_ARSIZE             (S_AXI_ARSIZE             ),
  .S_AXI_ARBURST            (S_AXI_ARBURST            ),
  .S_AXI_ARLOCK             (S_AXI_ARLOCK             ),
  .S_AXI_ARCACHE            (S_AXI_ARCACHE            ),
  .S_AXI_ARPROT             (S_AXI_ARPROT             ),
  .S_AXI_ARQOS              (S_AXI_ARQOS              ),
  .S_AXI_ARUSER             (S_AXI_ARUSER             ),
  .S_AXI_ARVALID            (S_AXI_ARVALID            ),
  .S_AXI_ARREADY            (S_AXI_ARREADY            ),
  .S_AXI_RID                (S_AXI_RID                ),
  .S_AXI_RDATA              (S_AXI_RDATA              ),
  .S_AXI_RRESP              (S_AXI_RRESP              ),
  .S_AXI_RLAST              (S_AXI_RLAST              ),
  .S_AXI_RUSER              (S_AXI_RUSER              ),
  .S_AXI_RVALID             (S_AXI_RVALID             ),
  .S_AXI_RREADY             (S_AXI_RREADY             ),
  .M_AXI_ACLK               (M_AXI_ACLK               ),
  .M_AXI_AWID               (M_AXI_AWID               ),
  .M_AXI_AWADDR             (M_AXI_AWADDR             ),
  .M_AXI_AWLEN              (M_AXI_AWLEN              ),
  .M_AXI_AWSIZE             (M_AXI_AWSIZE             ),
  .M_AXI_AWBURST            (M_AXI_AWBURST            ),
  .M_AXI_AWLOCK             (M_AXI_AWLOCK             ),
  .M_AXI_AWCACHE            (M_AXI_AWCACHE            ),
  .M_AXI_AWPROT             (M_AXI_AWPROT             ),
  .M_AXI_AWREGION           (M_AXI_AWREGION           ),
  .M_AXI_AWQOS              (M_AXI_AWQOS              ),
  .M_AXI_AWUSER             (M_AXI_AWUSER             ),
  .M_AXI_AWVALID            (M_AXI_AWVALID            ),
  .M_AXI_AWREADY            (M_AXI_AWREADY            ),
  .M_AXI_WID                (M_AXI_WID                ),
  .M_AXI_WDATA              (M_AXI_WDATA              ),
  .M_AXI_WSTRB              (M_AXI_WSTRB              ),
  .M_AXI_WLAST              (M_AXI_WLAST              ),
  .M_AXI_WUSER              (M_AXI_WUSER              ),
  .M_AXI_WVALID             (M_AXI_WVALID             ),
  .M_AXI_WREADY             (M_AXI_WREADY             ),
  .M_AXI_BID                (M_AXI_BID                ),
  .M_AXI_BRESP              (M_AXI_BRESP              ),
  .M_AXI_BUSER              (M_AXI_BUSER              ),
  .M_AXI_BVALID             (M_AXI_BVALID             ),
  .M_AXI_BREADY             (M_AXI_BREADY             ),
  .M_AXI_ARID               (M_AXI_ARID               ),
  .M_AXI_ARADDR             (M_AXI_ARADDR             ),
  .M_AXI_ARLEN              (M_AXI_ARLEN              ),
  .M_AXI_ARSIZE             (M_AXI_ARSIZE             ),
  .M_AXI_ARBURST            (M_AXI_ARBURST            ),
  .M_AXI_ARLOCK             (M_AXI_ARLOCK             ),
  .M_AXI_ARCACHE            (M_AXI_ARCACHE            ),
  .M_AXI_ARPROT             (M_AXI_ARPROT             ),
  .M_AXI_ARREGION           (M_AXI_ARREGION           ),
  .M_AXI_ARQOS              (M_AXI_ARQOS              ),
  .M_AXI_ARUSER             (M_AXI_ARUSER             ),
  .M_AXI_ARVALID            (M_AXI_ARVALID            ),
  .M_AXI_ARREADY            (M_AXI_ARREADY            ),
  .M_AXI_RID                (M_AXI_RID                ),
  .M_AXI_RDATA              (M_AXI_RDATA              ),
  .M_AXI_RRESP              (M_AXI_RRESP              ),
  .M_AXI_RLAST              (M_AXI_RLAST              ),
  .M_AXI_RUSER              (M_AXI_RUSER              ),
  .M_AXI_RVALID             (M_AXI_RVALID             ),
  .M_AXI_RREADY             (M_AXI_RREADY             ),
  .S_AXI_CTRL_AWADDR        (S_AXI_CTRL_AWADDR        ),
  .S_AXI_CTRL_AWVALID       (S_AXI_CTRL_AWVALID       ),
  .S_AXI_CTRL_AWREADY       (S_AXI_CTRL_AWREADY       ),
  .S_AXI_CTRL_WDATA         (S_AXI_CTRL_WDATA         ),
  .S_AXI_CTRL_WVALID        (S_AXI_CTRL_WVALID        ),
  .S_AXI_CTRL_WREADY        (S_AXI_CTRL_WREADY        ),
  .S_AXI_CTRL_BRESP         (S_AXI_CTRL_BRESP         ),
  .S_AXI_CTRL_BVALID        (S_AXI_CTRL_BVALID        ),
  .S_AXI_CTRL_BREADY        (S_AXI_CTRL_BREADY        ),
  .S_AXI_CTRL_ARADDR        (S_AXI_CTRL_ARADDR        ),
  .S_AXI_CTRL_ARVALID       (S_AXI_CTRL_ARVALID       ),
  .S_AXI_CTRL_ARREADY       (S_AXI_CTRL_ARREADY       ),
  .S_AXI_CTRL_RDATA         (S_AXI_CTRL_RDATA         ),
  .S_AXI_CTRL_RRESP         (S_AXI_CTRL_RRESP         ),
  .S_AXI_CTRL_RVALID        (S_AXI_CTRL_RVALID        ),
  .S_AXI_CTRL_RREADY        (S_AXI_CTRL_RREADY        ),
  .DEBUG_AW_TRANS_SEQ       (DEBUG_AW_TRANS_SEQ       ),
  .DEBUG_AW_ARB_GRANT       (DEBUG_AW_ARB_GRANT       ),
  .DEBUG_AR_TRANS_SEQ       (DEBUG_AR_TRANS_SEQ       ),
  .DEBUG_AR_ARB_GRANT       (DEBUG_AR_ARB_GRANT       ),
  .DEBUG_AW_TRANS_QUAL      (DEBUG_AW_TRANS_QUAL      ),
  .DEBUG_AW_ACCEPT_CNT      (DEBUG_AW_ACCEPT_CNT      ),
  .DEBUG_AW_ACTIVE_THREAD   (DEBUG_AW_ACTIVE_THREAD   ),
  .DEBUG_AW_ACTIVE_TARGET   (DEBUG_AW_ACTIVE_TARGET   ),
  .DEBUG_AW_ACTIVE_REGION   (DEBUG_AW_ACTIVE_REGION   ),
  .DEBUG_AW_ERROR           (DEBUG_AW_ERROR           ),
  .DEBUG_AW_TARGET          (DEBUG_AW_TARGET          ),
  .DEBUG_AR_TRANS_QUAL      (DEBUG_AR_TRANS_QUAL      ),
  .DEBUG_AR_ACCEPT_CNT      (DEBUG_AR_ACCEPT_CNT      ),
  .DEBUG_AR_ACTIVE_THREAD   (DEBUG_AR_ACTIVE_THREAD   ),
  .DEBUG_AR_ACTIVE_TARGET   (DEBUG_AR_ACTIVE_TARGET   ),
  .DEBUG_AR_ACTIVE_REGION   (DEBUG_AR_ACTIVE_REGION   ),
  .DEBUG_AR_ERROR           (DEBUG_AR_ERROR           ),
  .DEBUG_AR_TARGET          (DEBUG_AR_TARGET          ),
  .DEBUG_B_TRANS_SEQ        (DEBUG_B_TRANS_SEQ        ),
  .DEBUG_R_BEAT_CNT         (DEBUG_R_BEAT_CNT         ),
  .DEBUG_R_TRANS_SEQ        (DEBUG_R_TRANS_SEQ        ),
  .DEBUG_AW_ISSUING_CNT     (DEBUG_AW_ISSUING_CNT     ),
  .DEBUG_AR_ISSUING_CNT     (DEBUG_AR_ISSUING_CNT     ),
  .DEBUG_W_BEAT_CNT         (DEBUG_W_BEAT_CNT         ),
  .DEBUG_W_TRANS_SEQ        (DEBUG_W_TRANS_SEQ        ),
  .DEBUG_BID_TARGET         (DEBUG_BID_TARGET         ),
  .DEBUG_BID_ERROR          (DEBUG_BID_ERROR          ),
  .DEBUG_RID_TARGET         (DEBUG_RID_TARGET         ),
  .DEBUG_RID_ERROR          (DEBUG_RID_ERROR          ),
  .DEBUG_SR_SC_ARADDR       (DEBUG_SR_SC_ARADDR       ),
  .DEBUG_SR_SC_ARADDRCONTROL(DEBUG_SR_SC_ARADDRCONTROL),
  .DEBUG_SR_SC_AWADDR       (DEBUG_SR_SC_AWADDR       ),
  .DEBUG_SR_SC_AWADDRCONTROL(DEBUG_SR_SC_AWADDRCONTROL),
  .DEBUG_SR_SC_BRESP        (DEBUG_SR_SC_BRESP        ),
  .DEBUG_SR_SC_RDATA        (DEBUG_SR_SC_RDATA        ),
  .DEBUG_SR_SC_RDATACONTROL (DEBUG_SR_SC_RDATACONTROL ),
  .DEBUG_SR_SC_WDATA        (DEBUG_SR_SC_WDATA        ),
  .DEBUG_SR_SC_WDATACONTROL (DEBUG_SR_SC_WDATACONTROL ),
  .DEBUG_SC_SF_ARADDR       (DEBUG_SC_SF_ARADDR       ),
  .DEBUG_SC_SF_ARADDRCONTROL(DEBUG_SC_SF_ARADDRCONTROL),
  .DEBUG_SC_SF_AWADDR       (DEBUG_SC_SF_AWADDR       ),
  .DEBUG_SC_SF_AWADDRCONTROL(DEBUG_SC_SF_AWADDRCONTROL),
  .DEBUG_SC_SF_BRESP        (DEBUG_SC_SF_BRESP        ),
  .DEBUG_SC_SF_RDATA        (DEBUG_SC_SF_RDATA        ),
  .DEBUG_SC_SF_RDATACONTROL (DEBUG_SC_SF_RDATACONTROL ),
  .DEBUG_SC_SF_WDATA        (DEBUG_SC_SF_WDATA        ),
  .DEBUG_SC_SF_WDATACONTROL (DEBUG_SC_SF_WDATACONTROL ),
  .DEBUG_SF_CB_ARADDR       (DEBUG_SF_CB_ARADDR       ),
  .DEBUG_SF_CB_ARADDRCONTROL(DEBUG_SF_CB_ARADDRCONTROL),
  .DEBUG_SF_CB_AWADDR       (DEBUG_SF_CB_AWADDR       ),
  .DEBUG_SF_CB_AWADDRCONTROL(DEBUG_SF_CB_AWADDRCONTROL),
  .DEBUG_SF_CB_BRESP        (DEBUG_SF_CB_BRESP        ),
  .DEBUG_SF_CB_RDATA        (DEBUG_SF_CB_RDATA        ),
  .DEBUG_SF_CB_RDATACONTROL (DEBUG_SF_CB_RDATACONTROL ),
  .DEBUG_SF_CB_WDATA        (DEBUG_SF_CB_WDATA        ),
  .DEBUG_SF_CB_WDATACONTROL (DEBUG_SF_CB_WDATACONTROL ),
  .DEBUG_CB_MF_ARADDR       (DEBUG_CB_MF_ARADDR       ),
  .DEBUG_CB_MF_ARADDRCONTROL(DEBUG_CB_MF_ARADDRCONTROL),
  .DEBUG_CB_MF_AWADDR       (DEBUG_CB_MF_AWADDR       ),
  .DEBUG_CB_MF_AWADDRCONTROL(DEBUG_CB_MF_AWADDRCONTROL),
  .DEBUG_CB_MF_BRESP        (DEBUG_CB_MF_BRESP        ),
  .DEBUG_CB_MF_RDATA        (DEBUG_CB_MF_RDATA        ),
  .DEBUG_CB_MF_RDATACONTROL (DEBUG_CB_MF_RDATACONTROL ),
  .DEBUG_CB_MF_WDATA        (DEBUG_CB_MF_WDATA        ),
  .DEBUG_CB_MF_WDATACONTROL (DEBUG_CB_MF_WDATACONTROL ),
  .DEBUG_MF_MC_ARADDR       (DEBUG_MF_MC_ARADDR       ),
  .DEBUG_MF_MC_ARADDRCONTROL(DEBUG_MF_MC_ARADDRCONTROL),
  .DEBUG_MF_MC_AWADDR       (DEBUG_MF_MC_AWADDR       ),
  .DEBUG_MF_MC_AWADDRCONTROL(DEBUG_MF_MC_AWADDRCONTROL),
  .DEBUG_MF_MC_BRESP        (DEBUG_MF_MC_BRESP        ),
  .DEBUG_MF_MC_RDATA        (DEBUG_MF_MC_RDATA        ),
  .DEBUG_MF_MC_RDATACONTROL (DEBUG_MF_MC_RDATACONTROL ),
  .DEBUG_MF_MC_WDATA        (DEBUG_MF_MC_WDATA        ),
  .DEBUG_MF_MC_WDATACONTROL (DEBUG_MF_MC_WDATACONTROL ),
  .DEBUG_MC_MP_ARADDR       (DEBUG_MC_MP_ARADDR       ),
  .DEBUG_MC_MP_ARADDRCONTROL(DEBUG_MC_MP_ARADDRCONTROL),
  .DEBUG_MC_MP_AWADDR       (DEBUG_MC_MP_AWADDR       ),
  .DEBUG_MC_MP_AWADDRCONTROL(DEBUG_MC_MP_AWADDRCONTROL),
  .DEBUG_MC_MP_BRESP        (DEBUG_MC_MP_BRESP        ),
  .DEBUG_MC_MP_RDATA        (DEBUG_MC_MP_RDATA        ),
  .DEBUG_MC_MP_RDATACONTROL (DEBUG_MC_MP_RDATACONTROL ),
  .DEBUG_MC_MP_WDATA        (DEBUG_MC_MP_WDATA        ),
  .DEBUG_MC_MP_WDATACONTROL (DEBUG_MC_MP_WDATACONTROL ),
  .DEBUG_MP_MR_ARADDR       (DEBUG_MP_MR_ARADDR       ),
  .DEBUG_MP_MR_ARADDRCONTROL(DEBUG_MP_MR_ARADDRCONTROL),
  .DEBUG_MP_MR_AWADDR       (DEBUG_MP_MR_AWADDR       ),
  .DEBUG_MP_MR_AWADDRCONTROL(DEBUG_MP_MR_AWADDRCONTROL),
  .DEBUG_MP_MR_BRESP        (DEBUG_MP_MR_BRESP        ),
  .DEBUG_MP_MR_RDATA        (DEBUG_MP_MR_RDATA        ),
  .DEBUG_MP_MR_RDATACONTROL (DEBUG_MP_MR_RDATACONTROL ),
  .DEBUG_MP_MR_WDATA        (DEBUG_MP_MR_WDATA        ),
  .DEBUG_MP_MR_WDATACONTROL (DEBUG_MP_MR_WDATACONTROL )
);



////////////////////////////////////////////////////////////////////////////////
// Clock Generate use if you need
////////////////////////////////////////////////////////////////////////////////
// always #5 clk = ~clk


endmodule
