//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2001-2013-2019 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2013-01-23 11:45:45 +0000 (Wed, 23 Jan 2013) $
//
//      Revision            : $Revision: 234562 $
//
//      Release Information : Cortex-M System Design Kit-r1p0-01rel0
//
//-----------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------
//  Abstract             : The MatrixDecode is used to determine which output
//                         stage is required for a particular access. Addresses
//                         that do not map to an Output port are diverted to
//                         the local default slave.
//
//  Notes               : The bus matrix has sparse connectivity.
//
//-----------------------------------------------------------------------------

`timescale 1ns/1ps

module cmsdk_MyDecoderNameS0 (

    // Common AHB signals
    HCLK,
    HRESETn,

    // Internal address remapping control
    remapping_dec,

    // Signals from the Input stage
    HREADYS,
    sel_dec,
    decode_addr_dec,
    trans_dec,

    // Bus-switch output 0
    active_dec0,
    readyout_dec0,
    resp_dec0,
    rdata_dec0,
    ruser_dec0,

    // Bus-switch output 7
    active_dec7,
    readyout_dec7,
    resp_dec7,
    rdata_dec7,
    ruser_dec7,

    // Output port selection signals
    sel_dec0,
    sel_dec7,

    // Selected Output port data and control signals
    active_dec,
    HREADYOUTS,
    HRESPS,
    HRUSERS,
    HRDATAS

    );


// -----------------------------------------------------------------------------
// Input and Output declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    input         HCLK;           // AHB System Clock
    input         HRESETn;        // AHB System Reset

    // Internal address remapping control
    input   [0:0] remapping_dec;      // Internal remap signal

    // Signals from the Input stage
    input         HREADYS;        // Transfer done
    input         sel_dec;            // HSEL input
    input [31:10] decode_addr_dec;     // HADDR decoder input
    input   [1:0] trans_dec;          // Input port HTRANS signal

    // Bus-switch output MI0
    input         active_dec0;        // Output stage MI0 active_dec signal
    input         readyout_dec0;      // HREADYOUT input
    input   [1:0] resp_dec0;          // HRESP input
    input  [31:0] rdata_dec0;         // HRDATA input
    input  [3:0] ruser_dec0;         // HRUSER input

    // Bus-switch output MI7
    input         active_dec7;        // Output stage MI7 active_dec signal
    input         readyout_dec7;      // HREADYOUT input
    input   [1:0] resp_dec7;          // HRESP input
    input  [31:0] rdata_dec7;         // HRDATA input
    input  [3:0] ruser_dec7;         // HRUSER input

    // Output port selection signals
    output        sel_dec0;           // HSEL output
    output        sel_dec7;           // HSEL output

    // Selected Output port data and control signals
    output        active_dec;         // Combinatorial active_dec O/P
    output        HREADYOUTS;     // HREADY feedback output
    output  [1:0] HRESPS;         // Transfer response
    output [3:0] HRUSERS;        // User read Data
    output [31:0] HRDATAS;        // Read Data


// -----------------------------------------------------------------------------
// Wire declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    wire          HCLK;            // AHB System Clock
    wire          HRESETn;         // AHB System Reset
    // Internal address remapping control
    wire    [0:0] remapping_dec;       // Internal remap signal

    // Signals from the Input stage
    wire          HREADYS;         // Transfer done
    wire          sel_dec;             // HSEL input
    wire  [31:10] decode_addr_dec;      // HADDR input
    wire    [1:0] trans_dec;           // Input port HTRANS signal

    // Bus-switch output MI0
    wire          active_dec0;         // active_dec signal
    wire          readyout_dec0;       // HREADYOUT input
    wire    [1:0] resp_dec0;           // HRESP input
    wire   [31:0] rdata_dec0;          // HRDATA input
    wire   [3:0] ruser_dec0;          // HRUSER input
    reg           sel_dec0;            // HSEL output

    // Bus-switch output MI7
    wire          active_dec7;         // active_dec signal
    wire          readyout_dec7;       // HREADYOUT input
    wire    [1:0] resp_dec7;           // HRESP input
    wire   [31:0] rdata_dec7;          // HRDATA input
    wire   [3:0] ruser_dec7;          // HRUSER input
    reg           sel_dec7;            // HSEL output


// -----------------------------------------------------------------------------
// Signal declarations
// -----------------------------------------------------------------------------

    // Selected Output port data and control signals
    reg           active_dec;          // Combinatorial active_dec O/P signal
    reg           HREADYOUTS;      // Combinatorial HREADYOUT signal
    reg     [1:0] HRESPS;          // Combinatorial HRESPS signal
    reg    [3:0] HRUSERS;
    reg    [31:0] HRDATAS;         // Read data bus

    reg     [3:0] addr_out_port;     // Address output ports
    reg     [3:0] data_out_port;     // Data output ports

    // Default slave signals
    reg           sel_dft_slv;       // HSEL signal
    wire          readyout_dft_slv;  // HREADYOUT signal
    wire    [1:0] resp_dft_slv;      // Combinatorial HRESPS signal


// -----------------------------------------------------------------------------
// Beginning of main code
// -----------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Default slave (accessed when HADDR is unmapped)
//------------------------------------------------------------------------------

  cmsdk_MyBusMatrixName_default_slave u_cmsdk_MyBusMatrixName_default_slave (

    // Common AHB signals
    .HCLK        (HCLK),
    .HRESETn     (HRESETn),

    // AHB Control signals
    .HSEL        (sel_dft_slv),
    .HTRANS      (trans_dec),
    .HREADY      (HREADYS),
    .HREADYOUT   (readyout_dft_slv),
    .HRESP       (resp_dft_slv)

    );


//------------------------------------------------------------------------------
// Address phase signals
//------------------------------------------------------------------------------

// The address decode is done in two stages. This is so that the address
//  decode occurs in only one process, p_addr_out_portComb, and then the select
//  signal is factored in.
//
// Note that the hexadecimal address values are reformatted to align with the
//  lower bound of decode_addr_dec[31:10], which is not a hex character boundary

  always @ (
             decode_addr_dec or
             remapping_dec or data_out_port or trans_dec
           )
    begin : p_addr_out_port_comb
      case (remapping_dec)  // Composition: REMAP[0]
        1'b0 : begin
          // Static address region 0x00000000-0x0003ffff
          if (((decode_addr_dec >= 22'h000000) & (decode_addr_dec <= 22'h0000ff))
                           | ((data_out_port == 4'b0000) & (trans_dec == 2'b00)))
             addr_out_port = 4'b0000;  // Select Output port MI0
          // Unmoved address region 0x00040000-0x0007ffff
          else if (((decode_addr_dec >= 22'h000100) & (decode_addr_dec <= 22'h0001ff))
                           | ((data_out_port == 4'b0000) & (trans_dec == 2'b00)))
             addr_out_port = 4'b0000;  // Select Output port MI0

          // Static address region 0x00080000-0x1fffffff
          else if (((decode_addr_dec >= 22'h000200) & (decode_addr_dec <= 22'h07ffff))
                           | ((data_out_port == 4'b0111) & (trans_dec == 2'b00)))
             addr_out_port = 4'b0111;  // Select Output port MI7

          else
            addr_out_port = 4'b1000;   // Select the default slave
        end

        1'b1 : begin
          // Remapped address region 0x00040000-0x0007ffff due to REMAP[0]
          if (((decode_addr_dec >= 22'h000100) & (decode_addr_dec <= 22'h0001ff))
                           | ((data_out_port == 4'b0111) & (trans_dec == 2'b00)))
             addr_out_port = 4'b0111;  // Select Output port MI7

          // Static address region 0x00000000-0x0003ffff
          else if (((decode_addr_dec >= 22'h000000) & (decode_addr_dec <= 22'h0000ff))
                           | ((data_out_port == 4'b0000) & (trans_dec == 2'b00)))
             addr_out_port = 4'b0000;  // Select Output port MI0
          // Unmoved address region 0x00040000-0x0007ffff
          else if (((decode_addr_dec >= 22'h000100) & (decode_addr_dec <= 22'h0001ff))
                           | ((data_out_port == 4'b0000) & (trans_dec == 2'b00)))
             addr_out_port = 4'b0000;  // Select Output port MI0

          // Static address region 0x00080000-0x1fffffff
          else if (((decode_addr_dec >= 22'h000200) & (decode_addr_dec <= 22'h07ffff))
                           | ((data_out_port == 4'b0111) & (trans_dec == 2'b00)))
             addr_out_port = 4'b0111;  // Select Output port MI7

          else
            addr_out_port = 4'b1000;   // Select the default slave
        end

        default : addr_out_port = {4{1'bx}};
      endcase
    end // block: p_addr_out_port_comb

  // Select signal decode
  always @ (sel_dec or addr_out_port)
    begin : p_sel_comb
      sel_dec0 = 1'b0;
      sel_dec7 = 1'b0;
      sel_dft_slv = 1'b0;

      if (sel_dec)
        case (addr_out_port)
          4'b0000 : sel_dec0 = 1'b1;
          4'b0111 : sel_dec7 = 1'b1;
          4'b1000 : sel_dft_slv = 1'b1;    // Select the default slave
          default : begin
            sel_dec0 = 1'bx;
            sel_dec7 = 1'bx;
            sel_dft_slv = 1'bx;
          end
        endcase // case(addr_out_port)
    end // block: p_sel_comb

// The decoder selects the appropriate active_dec signal depending on which
//  output stage is required for the transfer.
  always @ (
             active_dec0 or
             active_dec7 or
             addr_out_port
           )
    begin : p_active_comb
      case (addr_out_port)
        4'b0000 : active_dec = active_dec0;
        4'b0111 : active_dec = active_dec7;
        4'b1000 : active_dec = 1'b1;         // Select the default slave
        default : active_dec = 1'bx;
      endcase // case(addr_out_port)
    end // block: p_active_comb


//------------------------------------------------------------------------------
// Data phase signals
//------------------------------------------------------------------------------

// The data_out_port needs to be updated when HREADY from the input stage is high.
//  Note: HREADY must be used, not HREADYOUT, because there are occaisions
//  (namely when the holding register gets loaded) when HREADYOUT may be low
//  but HREADY is high, and in this case it is important that the data_out_port
//  gets updated.

  always @ (negedge HRESETn or posedge HCLK)
    begin : p_data_out_port_seq
      if (~HRESETn)
        data_out_port <= {4{1'b0}};
      else
        if (HREADYS)
          data_out_port <= addr_out_port;
    end // block: p_data_out_port_seq

  // HREADYOUTS output decode
  always @ (
             readyout_dft_slv or
             readyout_dec0 or
             readyout_dec7 or
             data_out_port
           )
  begin : p_ready_comb
    case (data_out_port)
      4'b0000 : HREADYOUTS = readyout_dec0;
      4'b0111 : HREADYOUTS = readyout_dec7;
      4'b1000 : HREADYOUTS = readyout_dft_slv;    // Select the default slave
      default : HREADYOUTS = 1'bx;
    endcase // case(data_out_port)
  end // block: p_ready_comb

  // HRESPS output decode
  always @ (
             resp_dft_slv or
             resp_dec0 or
             resp_dec7 or
             data_out_port
           )
  begin : p_resp_comb
    case (data_out_port)
      4'b0000 : HRESPS = resp_dec0;
      4'b0111 : HRESPS = resp_dec7;
      4'b1000 : HRESPS = resp_dft_slv;     // Select the default slave
      default : HRESPS = {2{1'bx}};
    endcase // case (data_out_port)
  end // block: p_resp_comb

  // HRDATAS output decode
  always @ (
             rdata_dec0 or
             rdata_dec7 or
             data_out_port
           )
  begin : p_rdata_comb
    case (data_out_port)
      4'b0000 : HRDATAS = rdata_dec0;
      4'b0111 : HRDATAS = rdata_dec7;
      4'b1000 : HRDATAS = {32{1'b0}};   // Select the default slave
      default : HRDATAS = {32{1'bx}};
    endcase // case (data_out_port)
  end // block: p_rdata_comb

  // HRUSERS output decode
  always @ (
             ruser_dec0 or
             ruser_dec7 or
             data_out_port
           )
  begin : p_ruser_comb
    case (data_out_port)
      4'b0000 : HRUSERS = ruser_dec0;
      4'b0111 : HRUSERS = ruser_dec7;
      4'b1000 : HRUSERS = {4{1'b0}};   // Select the default slave
      default : HRUSERS = {4{1'bx}};
    endcase // case (data_out_port)
  end // block: p_ruser_comb


endmodule

// --================================= End ===================================--
