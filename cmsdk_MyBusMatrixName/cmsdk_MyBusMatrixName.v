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
//      Checked In          : $Date: 2012-10-15 18:01:36 +0100 (Mon, 15 Oct 2012) $
//
//      Revision            : $Revision: 225465 $
//
//      Release Information : Cortex-M System Design Kit-r1p0-01rel0
//
//-----------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
//  Abstract            : BusMatrix is the top-level which connects together
//                        the required Input Stages, MatrixDecodes, Output
//                        Stages and Output Arbitration blocks.
//
//                        Supports the following configured options:
//
//                         - Architecture type 'ahb2',
//                         - 4 slave ports (connecting to masters),
//                         - 8 master ports (connecting to slaves),
//                         - Routing address width of 32 bits,
//                         - Routing data width of 32 bits,
//                         - xUSER signal width of 4 bits,
//                         - Arbiter type 'round',
//                         - Connectivity mapping:
//                             S0 -> M0, M7, 
//                             S1 -> M1, M2, M3, M4, M5, M6, M7, 
//                             S2 -> M0, M1, M2, M3, M4, M5, M6, M7, 
//                             S3 -> M0, M1, M2, M3, M4, M5, M6, M7,
//                         - Connectivity type 'sparse'.
//
//------------------------------------------------------------------------------

`timescale 1ns/1ps

module cmsdk_MyBusMatrixName (

    // Common AHB signals
    HCLK,
    HRESETn,

    // System address remapping control
    REMAP,

    // Input port SI0 (inputs from master 0)
    HSELS0,
    HADDRS0,
    HTRANSS0,
    HWRITES0,
    HSIZES0,
    HBURSTS0,
    HPROTS0,
    HMASTERS0,
    HWDATAS0,
    HMASTLOCKS0,
    HREADYS0,
    HAUSERS0,
    HWUSERS0,

    // Input port SI1 (inputs from master 1)
    HSELS1,
    HADDRS1,
    HTRANSS1,
    HWRITES1,
    HSIZES1,
    HBURSTS1,
    HPROTS1,
    HMASTERS1,
    HWDATAS1,
    HMASTLOCKS1,
    HREADYS1,
    HAUSERS1,
    HWUSERS1,

    // Input port SI2 (inputs from master 2)
    HSELS2,
    HADDRS2,
    HTRANSS2,
    HWRITES2,
    HSIZES2,
    HBURSTS2,
    HPROTS2,
    HMASTERS2,
    HWDATAS2,
    HMASTLOCKS2,
    HREADYS2,
    HAUSERS2,
    HWUSERS2,

    // Input port SI3 (inputs from master 3)
    HSELS3,
    HADDRS3,
    HTRANSS3,
    HWRITES3,
    HSIZES3,
    HBURSTS3,
    HPROTS3,
    HMASTERS3,
    HWDATAS3,
    HMASTLOCKS3,
    HREADYS3,
    HAUSERS3,
    HWUSERS3,

    // Output port MI0 (inputs from slave 0)
    HRDATAM0,
    HREADYOUTM0,
    HRESPM0,
    HRUSERM0,

    // Output port MI1 (inputs from slave 1)
    HRDATAM1,
    HREADYOUTM1,
    HRESPM1,
    HRUSERM1,

    // Output port MI2 (inputs from slave 2)
    HRDATAM2,
    HREADYOUTM2,
    HRESPM2,
    HRUSERM2,

    // Output port MI3 (inputs from slave 3)
    HRDATAM3,
    HREADYOUTM3,
    HRESPM3,
    HRUSERM3,

    // Output port MI4 (inputs from slave 4)
    HRDATAM4,
    HREADYOUTM4,
    HRESPM4,
    HRUSERM4,

    // Output port MI5 (inputs from slave 5)
    HRDATAM5,
    HREADYOUTM5,
    HRESPM5,
    HRUSERM5,

    // Output port MI6 (inputs from slave 6)
    HRDATAM6,
    HREADYOUTM6,
    HRESPM6,
    HRUSERM6,

    // Output port MI7 (inputs from slave 7)
    HRDATAM7,
    HREADYOUTM7,
    HRESPM7,
    HRUSERM7,

    // Scan test dummy signals; not connected until scan insertion
    SCANENABLE,   // Scan Test Mode Enable
    SCANINHCLK,   // Scan Chain Input


    // Output port MI0 (outputs to slave 0)
    HSELM0,
    HADDRM0,
    HTRANSM0,
    HWRITEM0,
    HSIZEM0,
    HBURSTM0,
    HPROTM0,
    HMASTERM0,
    HWDATAM0,
    HMASTLOCKM0,
    HREADYMUXM0,
    HAUSERM0,
    HWUSERM0,

    // Output port MI1 (outputs to slave 1)
    HSELM1,
    HADDRM1,
    HTRANSM1,
    HWRITEM1,
    HSIZEM1,
    HBURSTM1,
    HPROTM1,
    HMASTERM1,
    HWDATAM1,
    HMASTLOCKM1,
    HREADYMUXM1,
    HAUSERM1,
    HWUSERM1,

    // Output port MI2 (outputs to slave 2)
    HSELM2,
    HADDRM2,
    HTRANSM2,
    HWRITEM2,
    HSIZEM2,
    HBURSTM2,
    HPROTM2,
    HMASTERM2,
    HWDATAM2,
    HMASTLOCKM2,
    HREADYMUXM2,
    HAUSERM2,
    HWUSERM2,

    // Output port MI3 (outputs to slave 3)
    HSELM3,
    HADDRM3,
    HTRANSM3,
    HWRITEM3,
    HSIZEM3,
    HBURSTM3,
    HPROTM3,
    HMASTERM3,
    HWDATAM3,
    HMASTLOCKM3,
    HREADYMUXM3,
    HAUSERM3,
    HWUSERM3,

    // Output port MI4 (outputs to slave 4)
    HSELM4,
    HADDRM4,
    HTRANSM4,
    HWRITEM4,
    HSIZEM4,
    HBURSTM4,
    HPROTM4,
    HMASTERM4,
    HWDATAM4,
    HMASTLOCKM4,
    HREADYMUXM4,
    HAUSERM4,
    HWUSERM4,

    // Output port MI5 (outputs to slave 5)
    HSELM5,
    HADDRM5,
    HTRANSM5,
    HWRITEM5,
    HSIZEM5,
    HBURSTM5,
    HPROTM5,
    HMASTERM5,
    HWDATAM5,
    HMASTLOCKM5,
    HREADYMUXM5,
    HAUSERM5,
    HWUSERM5,

    // Output port MI6 (outputs to slave 6)
    HSELM6,
    HADDRM6,
    HTRANSM6,
    HWRITEM6,
    HSIZEM6,
    HBURSTM6,
    HPROTM6,
    HMASTERM6,
    HWDATAM6,
    HMASTLOCKM6,
    HREADYMUXM6,
    HAUSERM6,
    HWUSERM6,

    // Output port MI7 (outputs to slave 7)
    HSELM7,
    HADDRM7,
    HTRANSM7,
    HWRITEM7,
    HSIZEM7,
    HBURSTM7,
    HPROTM7,
    HMASTERM7,
    HWDATAM7,
    HMASTLOCKM7,
    HREADYMUXM7,
    HAUSERM7,
    HWUSERM7,

    // Input port SI0 (outputs to master 0)
    HRDATAS0,
    HREADYOUTS0,
    HRESPS0,
    HRUSERS0,

    // Input port SI1 (outputs to master 1)
    HRDATAS1,
    HREADYOUTS1,
    HRESPS1,
    HRUSERS1,

    // Input port SI2 (outputs to master 2)
    HRDATAS2,
    HREADYOUTS2,
    HRESPS2,
    HRUSERS2,

    // Input port SI3 (outputs to master 3)
    HRDATAS3,
    HREADYOUTS3,
    HRESPS3,
    HRUSERS3,

    // Scan test dummy signals; not connected until scan insertion
    SCANOUTHCLK   // Scan Chain Output

    );


// -----------------------------------------------------------------------------
// Input and Output declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    input         HCLK;            // AHB System Clock
    input         HRESETn;         // AHB System Reset

    // System address remapping control
    input   [3:0] REMAP;           // REMAP input

    // Input port SI0 (inputs from master 0)
    input         HSELS0;          // Slave Select
    input  [31:0] HADDRS0;         // Address bus
    input   [1:0] HTRANSS0;        // Transfer type
    input         HWRITES0;        // Transfer direction
    input   [2:0] HSIZES0;         // Transfer size
    input   [2:0] HBURSTS0;        // Burst type
    input   [3:0] HPROTS0;         // Protection control
    input   [3:0] HMASTERS0;       // Master select
    input  [31:0] HWDATAS0;        // Write data
    input         HMASTLOCKS0;     // Locked Sequence
    input         HREADYS0;        // Transfer done
    input  [3:0] HAUSERS0;        // Address USER signals
    input  [3:0] HWUSERS0;        // Write-data USER signals

    // Input port SI1 (inputs from master 1)
    input         HSELS1;          // Slave Select
    input  [31:0] HADDRS1;         // Address bus
    input   [1:0] HTRANSS1;        // Transfer type
    input         HWRITES1;        // Transfer direction
    input   [2:0] HSIZES1;         // Transfer size
    input   [2:0] HBURSTS1;        // Burst type
    input   [3:0] HPROTS1;         // Protection control
    input   [3:0] HMASTERS1;       // Master select
    input  [31:0] HWDATAS1;        // Write data
    input         HMASTLOCKS1;     // Locked Sequence
    input         HREADYS1;        // Transfer done
    input  [3:0] HAUSERS1;        // Address USER signals
    input  [3:0] HWUSERS1;        // Write-data USER signals

    // Input port SI2 (inputs from master 2)
    input         HSELS2;          // Slave Select
    input  [31:0] HADDRS2;         // Address bus
    input   [1:0] HTRANSS2;        // Transfer type
    input         HWRITES2;        // Transfer direction
    input   [2:0] HSIZES2;         // Transfer size
    input   [2:0] HBURSTS2;        // Burst type
    input   [3:0] HPROTS2;         // Protection control
    input   [3:0] HMASTERS2;       // Master select
    input  [31:0] HWDATAS2;        // Write data
    input         HMASTLOCKS2;     // Locked Sequence
    input         HREADYS2;        // Transfer done
    input  [3:0] HAUSERS2;        // Address USER signals
    input  [3:0] HWUSERS2;        // Write-data USER signals

    // Input port SI3 (inputs from master 3)
    input         HSELS3;          // Slave Select
    input  [31:0] HADDRS3;         // Address bus
    input   [1:0] HTRANSS3;        // Transfer type
    input         HWRITES3;        // Transfer direction
    input   [2:0] HSIZES3;         // Transfer size
    input   [2:0] HBURSTS3;        // Burst type
    input   [3:0] HPROTS3;         // Protection control
    input   [3:0] HMASTERS3;       // Master select
    input  [31:0] HWDATAS3;        // Write data
    input         HMASTLOCKS3;     // Locked Sequence
    input         HREADYS3;        // Transfer done
    input  [3:0] HAUSERS3;        // Address USER signals
    input  [3:0] HWUSERS3;        // Write-data USER signals

    // Output port MI0 (inputs from slave 0)
    input  [31:0] HRDATAM0;        // Read data bus
    input         HREADYOUTM0;     // HREADY feedback
    input   [1:0] HRESPM0;         // Transfer response
    input  [3:0] HRUSERM0;        // Read-data USER signals

    // Output port MI1 (inputs from slave 1)
    input  [31:0] HRDATAM1;        // Read data bus
    input         HREADYOUTM1;     // HREADY feedback
    input   [1:0] HRESPM1;         // Transfer response
    input  [3:0] HRUSERM1;        // Read-data USER signals

    // Output port MI2 (inputs from slave 2)
    input  [31:0] HRDATAM2;        // Read data bus
    input         HREADYOUTM2;     // HREADY feedback
    input   [1:0] HRESPM2;         // Transfer response
    input  [3:0] HRUSERM2;        // Read-data USER signals

    // Output port MI3 (inputs from slave 3)
    input  [31:0] HRDATAM3;        // Read data bus
    input         HREADYOUTM3;     // HREADY feedback
    input   [1:0] HRESPM3;         // Transfer response
    input  [3:0] HRUSERM3;        // Read-data USER signals

    // Output port MI4 (inputs from slave 4)
    input  [31:0] HRDATAM4;        // Read data bus
    input         HREADYOUTM4;     // HREADY feedback
    input   [1:0] HRESPM4;         // Transfer response
    input  [3:0] HRUSERM4;        // Read-data USER signals

    // Output port MI5 (inputs from slave 5)
    input  [31:0] HRDATAM5;        // Read data bus
    input         HREADYOUTM5;     // HREADY feedback
    input   [1:0] HRESPM5;         // Transfer response
    input  [3:0] HRUSERM5;        // Read-data USER signals

    // Output port MI6 (inputs from slave 6)
    input  [31:0] HRDATAM6;        // Read data bus
    input         HREADYOUTM6;     // HREADY feedback
    input   [1:0] HRESPM6;         // Transfer response
    input  [3:0] HRUSERM6;        // Read-data USER signals

    // Output port MI7 (inputs from slave 7)
    input  [31:0] HRDATAM7;        // Read data bus
    input         HREADYOUTM7;     // HREADY feedback
    input   [1:0] HRESPM7;         // Transfer response
    input  [3:0] HRUSERM7;        // Read-data USER signals

    // Scan test dummy signals; not connected until scan insertion
    input         SCANENABLE;      // Scan enable signal
    input         SCANINHCLK;      // HCLK scan input


    // Output port MI0 (outputs to slave 0)
    output        HSELM0;          // Slave Select
    output [31:0] HADDRM0;         // Address bus
    output  [1:0] HTRANSM0;        // Transfer type
    output        HWRITEM0;        // Transfer direction
    output  [2:0] HSIZEM0;         // Transfer size
    output  [2:0] HBURSTM0;        // Burst type
    output  [3:0] HPROTM0;         // Protection control
    output  [3:0] HMASTERM0;       // Master select
    output [31:0] HWDATAM0;        // Write data
    output        HMASTLOCKM0;     // Locked Sequence
    output        HREADYMUXM0;     // Transfer done
    output [3:0] HAUSERM0;        // Address USER signals
    output [3:0] HWUSERM0;        // Write-data USER signals

    // Output port MI1 (outputs to slave 1)
    output        HSELM1;          // Slave Select
    output [31:0] HADDRM1;         // Address bus
    output  [1:0] HTRANSM1;        // Transfer type
    output        HWRITEM1;        // Transfer direction
    output  [2:0] HSIZEM1;         // Transfer size
    output  [2:0] HBURSTM1;        // Burst type
    output  [3:0] HPROTM1;         // Protection control
    output  [3:0] HMASTERM1;       // Master select
    output [31:0] HWDATAM1;        // Write data
    output        HMASTLOCKM1;     // Locked Sequence
    output        HREADYMUXM1;     // Transfer done
    output [3:0] HAUSERM1;        // Address USER signals
    output [3:0] HWUSERM1;        // Write-data USER signals

    // Output port MI2 (outputs to slave 2)
    output        HSELM2;          // Slave Select
    output [31:0] HADDRM2;         // Address bus
    output  [1:0] HTRANSM2;        // Transfer type
    output        HWRITEM2;        // Transfer direction
    output  [2:0] HSIZEM2;         // Transfer size
    output  [2:0] HBURSTM2;        // Burst type
    output  [3:0] HPROTM2;         // Protection control
    output  [3:0] HMASTERM2;       // Master select
    output [31:0] HWDATAM2;        // Write data
    output        HMASTLOCKM2;     // Locked Sequence
    output        HREADYMUXM2;     // Transfer done
    output [3:0] HAUSERM2;        // Address USER signals
    output [3:0] HWUSERM2;        // Write-data USER signals

    // Output port MI3 (outputs to slave 3)
    output        HSELM3;          // Slave Select
    output [31:0] HADDRM3;         // Address bus
    output  [1:0] HTRANSM3;        // Transfer type
    output        HWRITEM3;        // Transfer direction
    output  [2:0] HSIZEM3;         // Transfer size
    output  [2:0] HBURSTM3;        // Burst type
    output  [3:0] HPROTM3;         // Protection control
    output  [3:0] HMASTERM3;       // Master select
    output [31:0] HWDATAM3;        // Write data
    output        HMASTLOCKM3;     // Locked Sequence
    output        HREADYMUXM3;     // Transfer done
    output [3:0] HAUSERM3;        // Address USER signals
    output [3:0] HWUSERM3;        // Write-data USER signals

    // Output port MI4 (outputs to slave 4)
    output        HSELM4;          // Slave Select
    output [31:0] HADDRM4;         // Address bus
    output  [1:0] HTRANSM4;        // Transfer type
    output        HWRITEM4;        // Transfer direction
    output  [2:0] HSIZEM4;         // Transfer size
    output  [2:0] HBURSTM4;        // Burst type
    output  [3:0] HPROTM4;         // Protection control
    output  [3:0] HMASTERM4;       // Master select
    output [31:0] HWDATAM4;        // Write data
    output        HMASTLOCKM4;     // Locked Sequence
    output        HREADYMUXM4;     // Transfer done
    output [3:0] HAUSERM4;        // Address USER signals
    output [3:0] HWUSERM4;        // Write-data USER signals

    // Output port MI5 (outputs to slave 5)
    output        HSELM5;          // Slave Select
    output [31:0] HADDRM5;         // Address bus
    output  [1:0] HTRANSM5;        // Transfer type
    output        HWRITEM5;        // Transfer direction
    output  [2:0] HSIZEM5;         // Transfer size
    output  [2:0] HBURSTM5;        // Burst type
    output  [3:0] HPROTM5;         // Protection control
    output  [3:0] HMASTERM5;       // Master select
    output [31:0] HWDATAM5;        // Write data
    output        HMASTLOCKM5;     // Locked Sequence
    output        HREADYMUXM5;     // Transfer done
    output [3:0] HAUSERM5;        // Address USER signals
    output [3:0] HWUSERM5;        // Write-data USER signals

    // Output port MI6 (outputs to slave 6)
    output        HSELM6;          // Slave Select
    output [31:0] HADDRM6;         // Address bus
    output  [1:0] HTRANSM6;        // Transfer type
    output        HWRITEM6;        // Transfer direction
    output  [2:0] HSIZEM6;         // Transfer size
    output  [2:0] HBURSTM6;        // Burst type
    output  [3:0] HPROTM6;         // Protection control
    output  [3:0] HMASTERM6;       // Master select
    output [31:0] HWDATAM6;        // Write data
    output        HMASTLOCKM6;     // Locked Sequence
    output        HREADYMUXM6;     // Transfer done
    output [3:0] HAUSERM6;        // Address USER signals
    output [3:0] HWUSERM6;        // Write-data USER signals

    // Output port MI7 (outputs to slave 7)
    output        HSELM7;          // Slave Select
    output [31:0] HADDRM7;         // Address bus
    output  [1:0] HTRANSM7;        // Transfer type
    output        HWRITEM7;        // Transfer direction
    output  [2:0] HSIZEM7;         // Transfer size
    output  [2:0] HBURSTM7;        // Burst type
    output  [3:0] HPROTM7;         // Protection control
    output  [3:0] HMASTERM7;       // Master select
    output [31:0] HWDATAM7;        // Write data
    output        HMASTLOCKM7;     // Locked Sequence
    output        HREADYMUXM7;     // Transfer done
    output [3:0] HAUSERM7;        // Address USER signals
    output [3:0] HWUSERM7;        // Write-data USER signals

    // Input port SI0 (outputs to master 0)
    output [31:0] HRDATAS0;        // Read data bus
    output        HREADYOUTS0;     // HREADY feedback
    output  [1:0] HRESPS0;         // Transfer response
    output [3:0] HRUSERS0;        // Read-data USER signals

    // Input port SI1 (outputs to master 1)
    output [31:0] HRDATAS1;        // Read data bus
    output        HREADYOUTS1;     // HREADY feedback
    output  [1:0] HRESPS1;         // Transfer response
    output [3:0] HRUSERS1;        // Read-data USER signals

    // Input port SI2 (outputs to master 2)
    output [31:0] HRDATAS2;        // Read data bus
    output        HREADYOUTS2;     // HREADY feedback
    output  [1:0] HRESPS2;         // Transfer response
    output [3:0] HRUSERS2;        // Read-data USER signals

    // Input port SI3 (outputs to master 3)
    output [31:0] HRDATAS3;        // Read data bus
    output        HREADYOUTS3;     // HREADY feedback
    output  [1:0] HRESPS3;         // Transfer response
    output [3:0] HRUSERS3;        // Read-data USER signals

    // Scan test dummy signals; not connected until scan insertion
    output        SCANOUTHCLK;     // Scan Chain Output


// -----------------------------------------------------------------------------
// Wire declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    wire         HCLK;            // AHB System Clock
    wire         HRESETn;         // AHB System Reset

    // System address remapping control
    wire   [3:0] REMAP;           // REMAP signal

    // Input Port SI0
    wire         HSELS0;          // Slave Select
    wire  [31:0] HADDRS0;         // Address bus
    wire   [1:0] HTRANSS0;        // Transfer type
    wire         HWRITES0;        // Transfer direction
    wire   [2:0] HSIZES0;         // Transfer size
    wire   [2:0] HBURSTS0;        // Burst type
    wire   [3:0] HPROTS0;         // Protection control
    wire   [3:0] HMASTERS0;       // Master select
    wire  [31:0] HWDATAS0;        // Write data
    wire         HMASTLOCKS0;     // Locked Sequence
    wire         HREADYS0;        // Transfer done

    wire  [31:0] HRDATAS0;        // Read data bus
    wire         HREADYOUTS0;     // HREADY feedback
    wire   [1:0] HRESPS0;         // Transfer response
    wire  [3:0] HAUSERS0;        // Address USER signals
    wire  [3:0] HWUSERS0;        // Write-data USER signals
    wire  [3:0] HRUSERS0;        // Read-data USER signals

    // Input Port SI1
    wire         HSELS1;          // Slave Select
    wire  [31:0] HADDRS1;         // Address bus
    wire   [1:0] HTRANSS1;        // Transfer type
    wire         HWRITES1;        // Transfer direction
    wire   [2:0] HSIZES1;         // Transfer size
    wire   [2:0] HBURSTS1;        // Burst type
    wire   [3:0] HPROTS1;         // Protection control
    wire   [3:0] HMASTERS1;       // Master select
    wire  [31:0] HWDATAS1;        // Write data
    wire         HMASTLOCKS1;     // Locked Sequence
    wire         HREADYS1;        // Transfer done

    wire  [31:0] HRDATAS1;        // Read data bus
    wire         HREADYOUTS1;     // HREADY feedback
    wire   [1:0] HRESPS1;         // Transfer response
    wire  [3:0] HAUSERS1;        // Address USER signals
    wire  [3:0] HWUSERS1;        // Write-data USER signals
    wire  [3:0] HRUSERS1;        // Read-data USER signals

    // Input Port SI2
    wire         HSELS2;          // Slave Select
    wire  [31:0] HADDRS2;         // Address bus
    wire   [1:0] HTRANSS2;        // Transfer type
    wire         HWRITES2;        // Transfer direction
    wire   [2:0] HSIZES2;         // Transfer size
    wire   [2:0] HBURSTS2;        // Burst type
    wire   [3:0] HPROTS2;         // Protection control
    wire   [3:0] HMASTERS2;       // Master select
    wire  [31:0] HWDATAS2;        // Write data
    wire         HMASTLOCKS2;     // Locked Sequence
    wire         HREADYS2;        // Transfer done

    wire  [31:0] HRDATAS2;        // Read data bus
    wire         HREADYOUTS2;     // HREADY feedback
    wire   [1:0] HRESPS2;         // Transfer response
    wire  [3:0] HAUSERS2;        // Address USER signals
    wire  [3:0] HWUSERS2;        // Write-data USER signals
    wire  [3:0] HRUSERS2;        // Read-data USER signals

    // Input Port SI3
    wire         HSELS3;          // Slave Select
    wire  [31:0] HADDRS3;         // Address bus
    wire   [1:0] HTRANSS3;        // Transfer type
    wire         HWRITES3;        // Transfer direction
    wire   [2:0] HSIZES3;         // Transfer size
    wire   [2:0] HBURSTS3;        // Burst type
    wire   [3:0] HPROTS3;         // Protection control
    wire   [3:0] HMASTERS3;       // Master select
    wire  [31:0] HWDATAS3;        // Write data
    wire         HMASTLOCKS3;     // Locked Sequence
    wire         HREADYS3;        // Transfer done

    wire  [31:0] HRDATAS3;        // Read data bus
    wire         HREADYOUTS3;     // HREADY feedback
    wire   [1:0] HRESPS3;         // Transfer response
    wire  [3:0] HAUSERS3;        // Address USER signals
    wire  [3:0] HWUSERS3;        // Write-data USER signals
    wire  [3:0] HRUSERS3;        // Read-data USER signals

    // Output Port MI0
    wire         HSELM0;          // Slave Select
    wire  [31:0] HADDRM0;         // Address bus
    wire   [1:0] HTRANSM0;        // Transfer type
    wire         HWRITEM0;        // Transfer direction
    wire   [2:0] HSIZEM0;         // Transfer size
    wire   [2:0] HBURSTM0;        // Burst type
    wire   [3:0] HPROTM0;         // Protection control
    wire   [3:0] HMASTERM0;       // Master select
    wire  [31:0] HWDATAM0;        // Write data
    wire         HMASTLOCKM0;     // Locked Sequence
    wire         HREADYMUXM0;     // Transfer done

    wire  [31:0] HRDATAM0;        // Read data bus
    wire         HREADYOUTM0;     // HREADY feedback
    wire   [1:0] HRESPM0;         // Transfer response
    wire  [3:0] HAUSERM0;        // Address USER signals
    wire  [3:0] HWUSERM0;        // Write-data USER signals
    wire  [3:0] HRUSERM0;        // Read-data USER signals

    // Output Port MI1
    wire         HSELM1;          // Slave Select
    wire  [31:0] HADDRM1;         // Address bus
    wire   [1:0] HTRANSM1;        // Transfer type
    wire         HWRITEM1;        // Transfer direction
    wire   [2:0] HSIZEM1;         // Transfer size
    wire   [2:0] HBURSTM1;        // Burst type
    wire   [3:0] HPROTM1;         // Protection control
    wire   [3:0] HMASTERM1;       // Master select
    wire  [31:0] HWDATAM1;        // Write data
    wire         HMASTLOCKM1;     // Locked Sequence
    wire         HREADYMUXM1;     // Transfer done

    wire  [31:0] HRDATAM1;        // Read data bus
    wire         HREADYOUTM1;     // HREADY feedback
    wire   [1:0] HRESPM1;         // Transfer response
    wire  [3:0] HAUSERM1;        // Address USER signals
    wire  [3:0] HWUSERM1;        // Write-data USER signals
    wire  [3:0] HRUSERM1;        // Read-data USER signals

    // Output Port MI2
    wire         HSELM2;          // Slave Select
    wire  [31:0] HADDRM2;         // Address bus
    wire   [1:0] HTRANSM2;        // Transfer type
    wire         HWRITEM2;        // Transfer direction
    wire   [2:0] HSIZEM2;         // Transfer size
    wire   [2:0] HBURSTM2;        // Burst type
    wire   [3:0] HPROTM2;         // Protection control
    wire   [3:0] HMASTERM2;       // Master select
    wire  [31:0] HWDATAM2;        // Write data
    wire         HMASTLOCKM2;     // Locked Sequence
    wire         HREADYMUXM2;     // Transfer done

    wire  [31:0] HRDATAM2;        // Read data bus
    wire         HREADYOUTM2;     // HREADY feedback
    wire   [1:0] HRESPM2;         // Transfer response
    wire  [3:0] HAUSERM2;        // Address USER signals
    wire  [3:0] HWUSERM2;        // Write-data USER signals
    wire  [3:0] HRUSERM2;        // Read-data USER signals

    // Output Port MI3
    wire         HSELM3;          // Slave Select
    wire  [31:0] HADDRM3;         // Address bus
    wire   [1:0] HTRANSM3;        // Transfer type
    wire         HWRITEM3;        // Transfer direction
    wire   [2:0] HSIZEM3;         // Transfer size
    wire   [2:0] HBURSTM3;        // Burst type
    wire   [3:0] HPROTM3;         // Protection control
    wire   [3:0] HMASTERM3;       // Master select
    wire  [31:0] HWDATAM3;        // Write data
    wire         HMASTLOCKM3;     // Locked Sequence
    wire         HREADYMUXM3;     // Transfer done

    wire  [31:0] HRDATAM3;        // Read data bus
    wire         HREADYOUTM3;     // HREADY feedback
    wire   [1:0] HRESPM3;         // Transfer response
    wire  [3:0] HAUSERM3;        // Address USER signals
    wire  [3:0] HWUSERM3;        // Write-data USER signals
    wire  [3:0] HRUSERM3;        // Read-data USER signals

    // Output Port MI4
    wire         HSELM4;          // Slave Select
    wire  [31:0] HADDRM4;         // Address bus
    wire   [1:0] HTRANSM4;        // Transfer type
    wire         HWRITEM4;        // Transfer direction
    wire   [2:0] HSIZEM4;         // Transfer size
    wire   [2:0] HBURSTM4;        // Burst type
    wire   [3:0] HPROTM4;         // Protection control
    wire   [3:0] HMASTERM4;       // Master select
    wire  [31:0] HWDATAM4;        // Write data
    wire         HMASTLOCKM4;     // Locked Sequence
    wire         HREADYMUXM4;     // Transfer done

    wire  [31:0] HRDATAM4;        // Read data bus
    wire         HREADYOUTM4;     // HREADY feedback
    wire   [1:0] HRESPM4;         // Transfer response
    wire  [3:0] HAUSERM4;        // Address USER signals
    wire  [3:0] HWUSERM4;        // Write-data USER signals
    wire  [3:0] HRUSERM4;        // Read-data USER signals

    // Output Port MI5
    wire         HSELM5;          // Slave Select
    wire  [31:0] HADDRM5;         // Address bus
    wire   [1:0] HTRANSM5;        // Transfer type
    wire         HWRITEM5;        // Transfer direction
    wire   [2:0] HSIZEM5;         // Transfer size
    wire   [2:0] HBURSTM5;        // Burst type
    wire   [3:0] HPROTM5;         // Protection control
    wire   [3:0] HMASTERM5;       // Master select
    wire  [31:0] HWDATAM5;        // Write data
    wire         HMASTLOCKM5;     // Locked Sequence
    wire         HREADYMUXM5;     // Transfer done

    wire  [31:0] HRDATAM5;        // Read data bus
    wire         HREADYOUTM5;     // HREADY feedback
    wire   [1:0] HRESPM5;         // Transfer response
    wire  [3:0] HAUSERM5;        // Address USER signals
    wire  [3:0] HWUSERM5;        // Write-data USER signals
    wire  [3:0] HRUSERM5;        // Read-data USER signals

    // Output Port MI6
    wire         HSELM6;          // Slave Select
    wire  [31:0] HADDRM6;         // Address bus
    wire   [1:0] HTRANSM6;        // Transfer type
    wire         HWRITEM6;        // Transfer direction
    wire   [2:0] HSIZEM6;         // Transfer size
    wire   [2:0] HBURSTM6;        // Burst type
    wire   [3:0] HPROTM6;         // Protection control
    wire   [3:0] HMASTERM6;       // Master select
    wire  [31:0] HWDATAM6;        // Write data
    wire         HMASTLOCKM6;     // Locked Sequence
    wire         HREADYMUXM6;     // Transfer done

    wire  [31:0] HRDATAM6;        // Read data bus
    wire         HREADYOUTM6;     // HREADY feedback
    wire   [1:0] HRESPM6;         // Transfer response
    wire  [3:0] HAUSERM6;        // Address USER signals
    wire  [3:0] HWUSERM6;        // Write-data USER signals
    wire  [3:0] HRUSERM6;        // Read-data USER signals

    // Output Port MI7
    wire         HSELM7;          // Slave Select
    wire  [31:0] HADDRM7;         // Address bus
    wire   [1:0] HTRANSM7;        // Transfer type
    wire         HWRITEM7;        // Transfer direction
    wire   [2:0] HSIZEM7;         // Transfer size
    wire   [2:0] HBURSTM7;        // Burst type
    wire   [3:0] HPROTM7;         // Protection control
    wire   [3:0] HMASTERM7;       // Master select
    wire  [31:0] HWDATAM7;        // Write data
    wire         HMASTLOCKM7;     // Locked Sequence
    wire         HREADYMUXM7;     // Transfer done

    wire  [31:0] HRDATAM7;        // Read data bus
    wire         HREADYOUTM7;     // HREADY feedback
    wire   [1:0] HRESPM7;         // Transfer response
    wire  [3:0] HAUSERM7;        // Address USER signals
    wire  [3:0] HWUSERM7;        // Write-data USER signals
    wire  [3:0] HRUSERM7;        // Read-data USER signals


// -----------------------------------------------------------------------------
// Signal declarations
// -----------------------------------------------------------------------------

    // Bus-switch input SI0
    wire         i_sel0;            // HSEL signal
    wire  [31:0] i_addr0;           // HADDR signal
    wire   [1:0] i_trans0;          // HTRANS signal
    wire         i_write0;          // HWRITE signal
    wire   [2:0] i_size0;           // HSIZE signal
    wire   [2:0] i_burst0;          // HBURST signal
    wire   [3:0] i_prot0;           // HPROTS signal
    wire   [3:0] i_master0;         // HMASTER signal
    wire         i_mastlock0;       // HMASTLOCK signal
    wire         i_active0;         // Active signal
    wire         i_held_tran0;       // HeldTran signal
    wire         i_readyout0;       // Readyout signal
    wire   [1:0] i_resp0;           // Response signal
    wire  [3:0] i_auser0;          // HAUSER signal

    // Bus-switch input SI1
    wire         i_sel1;            // HSEL signal
    wire  [31:0] i_addr1;           // HADDR signal
    wire   [1:0] i_trans1;          // HTRANS signal
    wire         i_write1;          // HWRITE signal
    wire   [2:0] i_size1;           // HSIZE signal
    wire   [2:0] i_burst1;          // HBURST signal
    wire   [3:0] i_prot1;           // HPROTS signal
    wire   [3:0] i_master1;         // HMASTER signal
    wire         i_mastlock1;       // HMASTLOCK signal
    wire         i_active1;         // Active signal
    wire         i_held_tran1;       // HeldTran signal
    wire         i_readyout1;       // Readyout signal
    wire   [1:0] i_resp1;           // Response signal
    wire  [3:0] i_auser1;          // HAUSER signal

    // Bus-switch input SI2
    wire         i_sel2;            // HSEL signal
    wire  [31:0] i_addr2;           // HADDR signal
    wire   [1:0] i_trans2;          // HTRANS signal
    wire         i_write2;          // HWRITE signal
    wire   [2:0] i_size2;           // HSIZE signal
    wire   [2:0] i_burst2;          // HBURST signal
    wire   [3:0] i_prot2;           // HPROTS signal
    wire   [3:0] i_master2;         // HMASTER signal
    wire         i_mastlock2;       // HMASTLOCK signal
    wire         i_active2;         // Active signal
    wire         i_held_tran2;       // HeldTran signal
    wire         i_readyout2;       // Readyout signal
    wire   [1:0] i_resp2;           // Response signal
    wire  [3:0] i_auser2;          // HAUSER signal

    // Bus-switch input SI3
    wire         i_sel3;            // HSEL signal
    wire  [31:0] i_addr3;           // HADDR signal
    wire   [1:0] i_trans3;          // HTRANS signal
    wire         i_write3;          // HWRITE signal
    wire   [2:0] i_size3;           // HSIZE signal
    wire   [2:0] i_burst3;          // HBURST signal
    wire   [3:0] i_prot3;           // HPROTS signal
    wire   [3:0] i_master3;         // HMASTER signal
    wire         i_mastlock3;       // HMASTLOCK signal
    wire         i_active3;         // Active signal
    wire         i_held_tran3;       // HeldTran signal
    wire         i_readyout3;       // Readyout signal
    wire   [1:0] i_resp3;           // Response signal
    wire  [3:0] i_auser3;          // HAUSER signal

    // Bus-switch SI0 to MI0 signals
    wire         i_sel0to0;         // Routing selection signal
    wire         i_active0to0;      // Active signal

    // Bus-switch SI0 to MI7 signals
    wire         i_sel0to7;         // Routing selection signal
    wire         i_active0to7;      // Active signal

    // Bus-switch SI1 to MI1 signals
    wire         i_sel1to1;         // Routing selection signal
    wire         i_active1to1;      // Active signal

    // Bus-switch SI1 to MI2 signals
    wire         i_sel1to2;         // Routing selection signal
    wire         i_active1to2;      // Active signal

    // Bus-switch SI1 to MI3 signals
    wire         i_sel1to3;         // Routing selection signal
    wire         i_active1to3;      // Active signal

    // Bus-switch SI1 to MI4 signals
    wire         i_sel1to4;         // Routing selection signal
    wire         i_active1to4;      // Active signal

    // Bus-switch SI1 to MI5 signals
    wire         i_sel1to5;         // Routing selection signal
    wire         i_active1to5;      // Active signal

    // Bus-switch SI1 to MI6 signals
    wire         i_sel1to6;         // Routing selection signal
    wire         i_active1to6;      // Active signal

    // Bus-switch SI1 to MI7 signals
    wire         i_sel1to7;         // Routing selection signal
    wire         i_active1to7;      // Active signal

    // Bus-switch SI2 to MI0 signals
    wire         i_sel2to0;         // Routing selection signal
    wire         i_active2to0;      // Active signal

    // Bus-switch SI2 to MI1 signals
    wire         i_sel2to1;         // Routing selection signal
    wire         i_active2to1;      // Active signal

    // Bus-switch SI2 to MI2 signals
    wire         i_sel2to2;         // Routing selection signal
    wire         i_active2to2;      // Active signal

    // Bus-switch SI2 to MI3 signals
    wire         i_sel2to3;         // Routing selection signal
    wire         i_active2to3;      // Active signal

    // Bus-switch SI2 to MI4 signals
    wire         i_sel2to4;         // Routing selection signal
    wire         i_active2to4;      // Active signal

    // Bus-switch SI2 to MI5 signals
    wire         i_sel2to5;         // Routing selection signal
    wire         i_active2to5;      // Active signal

    // Bus-switch SI2 to MI6 signals
    wire         i_sel2to6;         // Routing selection signal
    wire         i_active2to6;      // Active signal

    // Bus-switch SI2 to MI7 signals
    wire         i_sel2to7;         // Routing selection signal
    wire         i_active2to7;      // Active signal

    // Bus-switch SI3 to MI0 signals
    wire         i_sel3to0;         // Routing selection signal
    wire         i_active3to0;      // Active signal

    // Bus-switch SI3 to MI1 signals
    wire         i_sel3to1;         // Routing selection signal
    wire         i_active3to1;      // Active signal

    // Bus-switch SI3 to MI2 signals
    wire         i_sel3to2;         // Routing selection signal
    wire         i_active3to2;      // Active signal

    // Bus-switch SI3 to MI3 signals
    wire         i_sel3to3;         // Routing selection signal
    wire         i_active3to3;      // Active signal

    // Bus-switch SI3 to MI4 signals
    wire         i_sel3to4;         // Routing selection signal
    wire         i_active3to4;      // Active signal

    // Bus-switch SI3 to MI5 signals
    wire         i_sel3to5;         // Routing selection signal
    wire         i_active3to5;      // Active signal

    // Bus-switch SI3 to MI6 signals
    wire         i_sel3to6;         // Routing selection signal
    wire         i_active3to6;      // Active signal

    // Bus-switch SI3 to MI7 signals
    wire         i_sel3to7;         // Routing selection signal
    wire         i_active3to7;      // Active signal

    wire         i_hready_mux_m0;    // Internal HREADYMUXM for MI0
    wire         i_hready_mux_m1;    // Internal HREADYMUXM for MI1
    wire         i_hready_mux_m2;    // Internal HREADYMUXM for MI2
    wire         i_hready_mux_m3;    // Internal HREADYMUXM for MI3
    wire         i_hready_mux_m4;    // Internal HREADYMUXM for MI4
    wire         i_hready_mux_m5;    // Internal HREADYMUXM for MI5
    wire         i_hready_mux_m6;    // Internal HREADYMUXM for MI6
    wire         i_hready_mux_m7;    // Internal HREADYMUXM for MI7


// -----------------------------------------------------------------------------
// Beginning of main code
// -----------------------------------------------------------------------------

  // Input stage for SI0
  cmsdk_MyInputName u_cmsdk_MyInputName_0 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS0),
    .HADDRS     (HADDRS0),
    .HTRANSS    (HTRANSS0),
    .HWRITES    (HWRITES0),
    .HSIZES     (HSIZES0),
    .HBURSTS    (HBURSTS0),
    .HPROTS     (HPROTS0),
    .HMASTERS   (HMASTERS0),
    .HMASTLOCKS (HMASTLOCKS0),
    .HREADYS    (HREADYS0),
    .HAUSERS    (HAUSERS0),

    // Internal Response
    .active_ip     (i_active0),
    .readyout_ip   (i_readyout0),
    .resp_ip       (i_resp0),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS0),
    .HRESPS     (HRESPS0),

    // Internal Address/Control Signals
    .sel_ip        (i_sel0),
    .addr_ip       (i_addr0),
    .auser_ip      (i_auser0),
    .trans_ip      (i_trans0),
    .write_ip      (i_write0),
    .size_ip       (i_size0),
    .burst_ip      (i_burst0),
    .prot_ip       (i_prot0),
    .master_ip     (i_master0),
    .mastlock_ip   (i_mastlock0),
    .held_tran_ip   (i_held_tran0)

    );


  // Input stage for SI1
  cmsdk_MyInputName u_cmsdk_MyInputName_1 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS1),
    .HADDRS     (HADDRS1),
    .HTRANSS    (HTRANSS1),
    .HWRITES    (HWRITES1),
    .HSIZES     (HSIZES1),
    .HBURSTS    (HBURSTS1),
    .HPROTS     (HPROTS1),
    .HMASTERS   (HMASTERS1),
    .HMASTLOCKS (HMASTLOCKS1),
    .HREADYS    (HREADYS1),
    .HAUSERS    (HAUSERS1),

    // Internal Response
    .active_ip     (i_active1),
    .readyout_ip   (i_readyout1),
    .resp_ip       (i_resp1),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS1),
    .HRESPS     (HRESPS1),

    // Internal Address/Control Signals
    .sel_ip        (i_sel1),
    .addr_ip       (i_addr1),
    .auser_ip      (i_auser1),
    .trans_ip      (i_trans1),
    .write_ip      (i_write1),
    .size_ip       (i_size1),
    .burst_ip      (i_burst1),
    .prot_ip       (i_prot1),
    .master_ip     (i_master1),
    .mastlock_ip   (i_mastlock1),
    .held_tran_ip   (i_held_tran1)

    );


  // Input stage for SI2
  cmsdk_MyInputName u_cmsdk_MyInputName_2 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS2),
    .HADDRS     (HADDRS2),
    .HTRANSS    (HTRANSS2),
    .HWRITES    (HWRITES2),
    .HSIZES     (HSIZES2),
    .HBURSTS    (HBURSTS2),
    .HPROTS     (HPROTS2),
    .HMASTERS   (HMASTERS2),
    .HMASTLOCKS (HMASTLOCKS2),
    .HREADYS    (HREADYS2),
    .HAUSERS    (HAUSERS2),

    // Internal Response
    .active_ip     (i_active2),
    .readyout_ip   (i_readyout2),
    .resp_ip       (i_resp2),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS2),
    .HRESPS     (HRESPS2),

    // Internal Address/Control Signals
    .sel_ip        (i_sel2),
    .addr_ip       (i_addr2),
    .auser_ip      (i_auser2),
    .trans_ip      (i_trans2),
    .write_ip      (i_write2),
    .size_ip       (i_size2),
    .burst_ip      (i_burst2),
    .prot_ip       (i_prot2),
    .master_ip     (i_master2),
    .mastlock_ip   (i_mastlock2),
    .held_tran_ip   (i_held_tran2)

    );


  // Input stage for SI3
  cmsdk_MyInputName u_cmsdk_MyInputName_3 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Input Port Address/Control Signals
    .HSELS      (HSELS3),
    .HADDRS     (HADDRS3),
    .HTRANSS    (HTRANSS3),
    .HWRITES    (HWRITES3),
    .HSIZES     (HSIZES3),
    .HBURSTS    (HBURSTS3),
    .HPROTS     (HPROTS3),
    .HMASTERS   (HMASTERS3),
    .HMASTLOCKS (HMASTLOCKS3),
    .HREADYS    (HREADYS3),
    .HAUSERS    (HAUSERS3),

    // Internal Response
    .active_ip     (i_active3),
    .readyout_ip   (i_readyout3),
    .resp_ip       (i_resp3),

    // Input Port Response
    .HREADYOUTS (HREADYOUTS3),
    .HRESPS     (HRESPS3),

    // Internal Address/Control Signals
    .sel_ip        (i_sel3),
    .addr_ip       (i_addr3),
    .auser_ip      (i_auser3),
    .trans_ip      (i_trans3),
    .write_ip      (i_write3),
    .size_ip       (i_size3),
    .burst_ip      (i_burst3),
    .prot_ip       (i_prot3),
    .master_ip     (i_master3),
    .mastlock_ip   (i_mastlock3),
    .held_tran_ip   (i_held_tran3)

    );


  // Matrix decoder for SI0
  cmsdk_MyDecoderNameS0 u_cmsdk_mydecodernames0 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( REMAP[0] ),

    // Signals from Input stage SI0
    .HREADYS    (HREADYS0),
    .sel_dec        (i_sel0),
    .decode_addr_dec (i_addr0[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans0),

    // Control/Response for Output Stage MI0
    .active_dec0    (i_active0to0),
    .readyout_dec0  (i_hready_mux_m0),
    .resp_dec0      (HRESPM0),
    .rdata_dec0     (HRDATAM0),
    .ruser_dec0     (HRUSERM0),

    // Control/Response for Output Stage MI7
    .active_dec7    (i_active0to7),
    .readyout_dec7  (i_hready_mux_m7),
    .resp_dec7      (HRESPM7),
    .rdata_dec7     (HRDATAM7),
    .ruser_dec7     (HRUSERM7),

    .sel_dec0       (i_sel0to0),
    .sel_dec7       (i_sel0to7),

    .active_dec     (i_active0),
    .HREADYOUTS (i_readyout0),
    .HRESPS     (i_resp0),
    .HRUSERS    (HRUSERS0),
    .HRDATAS    (HRDATAS0)

    );


  // Matrix decoder for SI1
  cmsdk_MyDecoderNameS1 u_cmsdk_mydecodernames1 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( { REMAP[3], REMAP[2], REMAP[1] } ),

    // Signals from Input stage SI1
    .HREADYS    (HREADYS1),
    .sel_dec        (i_sel1),
    .decode_addr_dec (i_addr1[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans1),

    // Control/Response for Output Stage MI1
    .active_dec1    (i_active1to1),
    .readyout_dec1  (i_hready_mux_m1),
    .resp_dec1      (HRESPM1),
    .rdata_dec1     (HRDATAM1),
    .ruser_dec1     (HRUSERM1),

    // Control/Response for Output Stage MI2
    .active_dec2    (i_active1to2),
    .readyout_dec2  (i_hready_mux_m2),
    .resp_dec2      (HRESPM2),
    .rdata_dec2     (HRDATAM2),
    .ruser_dec2     (HRUSERM2),

    // Control/Response for Output Stage MI3
    .active_dec3    (i_active1to3),
    .readyout_dec3  (i_hready_mux_m3),
    .resp_dec3      (HRESPM3),
    .rdata_dec3     (HRDATAM3),
    .ruser_dec3     (HRUSERM3),

    // Control/Response for Output Stage MI4
    .active_dec4    (i_active1to4),
    .readyout_dec4  (i_hready_mux_m4),
    .resp_dec4      (HRESPM4),
    .rdata_dec4     (HRDATAM4),
    .ruser_dec4     (HRUSERM4),

    // Control/Response for Output Stage MI5
    .active_dec5    (i_active1to5),
    .readyout_dec5  (i_hready_mux_m5),
    .resp_dec5      (HRESPM5),
    .rdata_dec5     (HRDATAM5),
    .ruser_dec5     (HRUSERM5),

    // Control/Response for Output Stage MI6
    .active_dec6    (i_active1to6),
    .readyout_dec6  (i_hready_mux_m6),
    .resp_dec6      (HRESPM6),
    .rdata_dec6     (HRDATAM6),
    .ruser_dec6     (HRUSERM6),

    // Control/Response for Output Stage MI7
    .active_dec7    (i_active1to7),
    .readyout_dec7  (i_hready_mux_m7),
    .resp_dec7      (HRESPM7),
    .rdata_dec7     (HRDATAM7),
    .ruser_dec7     (HRUSERM7),

    .sel_dec1       (i_sel1to1),
    .sel_dec2       (i_sel1to2),
    .sel_dec3       (i_sel1to3),
    .sel_dec4       (i_sel1to4),
    .sel_dec5       (i_sel1to5),
    .sel_dec6       (i_sel1to6),
    .sel_dec7       (i_sel1to7),

    .active_dec     (i_active1),
    .HREADYOUTS (i_readyout1),
    .HRESPS     (i_resp1),
    .HRUSERS    (HRUSERS1),
    .HRDATAS    (HRDATAS1)

    );


  // Matrix decoder for SI2
  cmsdk_MyDecoderNameS2 u_cmsdk_mydecodernames2 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( { REMAP[3], REMAP[2], REMAP[1], REMAP[0] } ),

    // Signals from Input stage SI2
    .HREADYS    (HREADYS2),
    .sel_dec        (i_sel2),
    .decode_addr_dec (i_addr2[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans2),

    // Control/Response for Output Stage MI0
    .active_dec0    (i_active2to0),
    .readyout_dec0  (i_hready_mux_m0),
    .resp_dec0      (HRESPM0),
    .rdata_dec0     (HRDATAM0),
    .ruser_dec0     (HRUSERM0),

    // Control/Response for Output Stage MI1
    .active_dec1    (i_active2to1),
    .readyout_dec1  (i_hready_mux_m1),
    .resp_dec1      (HRESPM1),
    .rdata_dec1     (HRDATAM1),
    .ruser_dec1     (HRUSERM1),

    // Control/Response for Output Stage MI2
    .active_dec2    (i_active2to2),
    .readyout_dec2  (i_hready_mux_m2),
    .resp_dec2      (HRESPM2),
    .rdata_dec2     (HRDATAM2),
    .ruser_dec2     (HRUSERM2),

    // Control/Response for Output Stage MI3
    .active_dec3    (i_active2to3),
    .readyout_dec3  (i_hready_mux_m3),
    .resp_dec3      (HRESPM3),
    .rdata_dec3     (HRDATAM3),
    .ruser_dec3     (HRUSERM3),

    // Control/Response for Output Stage MI4
    .active_dec4    (i_active2to4),
    .readyout_dec4  (i_hready_mux_m4),
    .resp_dec4      (HRESPM4),
    .rdata_dec4     (HRDATAM4),
    .ruser_dec4     (HRUSERM4),

    // Control/Response for Output Stage MI5
    .active_dec5    (i_active2to5),
    .readyout_dec5  (i_hready_mux_m5),
    .resp_dec5      (HRESPM5),
    .rdata_dec5     (HRDATAM5),
    .ruser_dec5     (HRUSERM5),

    // Control/Response for Output Stage MI6
    .active_dec6    (i_active2to6),
    .readyout_dec6  (i_hready_mux_m6),
    .resp_dec6      (HRESPM6),
    .rdata_dec6     (HRDATAM6),
    .ruser_dec6     (HRUSERM6),

    // Control/Response for Output Stage MI7
    .active_dec7    (i_active2to7),
    .readyout_dec7  (i_hready_mux_m7),
    .resp_dec7      (HRESPM7),
    .rdata_dec7     (HRDATAM7),
    .ruser_dec7     (HRUSERM7),

    .sel_dec0       (i_sel2to0),
    .sel_dec1       (i_sel2to1),
    .sel_dec2       (i_sel2to2),
    .sel_dec3       (i_sel2to3),
    .sel_dec4       (i_sel2to4),
    .sel_dec5       (i_sel2to5),
    .sel_dec6       (i_sel2to6),
    .sel_dec7       (i_sel2to7),

    .active_dec     (i_active2),
    .HREADYOUTS (i_readyout2),
    .HRESPS     (i_resp2),
    .HRUSERS    (HRUSERS2),
    .HRDATAS    (HRDATAS2)

    );


  // Matrix decoder for SI3
  cmsdk_MyDecoderNameS3 u_cmsdk_mydecodernames3 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Internal address remapping control
    .remapping_dec  ( { REMAP[3], REMAP[2], REMAP[1], REMAP[0] } ),

    // Signals from Input stage SI3
    .HREADYS    (HREADYS3),
    .sel_dec        (i_sel3),
    .decode_addr_dec (i_addr3[31:10]),   // HADDR[9:0] is not decoded
    .trans_dec      (i_trans3),

    // Control/Response for Output Stage MI0
    .active_dec0    (i_active3to0),
    .readyout_dec0  (i_hready_mux_m0),
    .resp_dec0      (HRESPM0),
    .rdata_dec0     (HRDATAM0),
    .ruser_dec0     (HRUSERM0),

    // Control/Response for Output Stage MI1
    .active_dec1    (i_active3to1),
    .readyout_dec1  (i_hready_mux_m1),
    .resp_dec1      (HRESPM1),
    .rdata_dec1     (HRDATAM1),
    .ruser_dec1     (HRUSERM1),

    // Control/Response for Output Stage MI2
    .active_dec2    (i_active3to2),
    .readyout_dec2  (i_hready_mux_m2),
    .resp_dec2      (HRESPM2),
    .rdata_dec2     (HRDATAM2),
    .ruser_dec2     (HRUSERM2),

    // Control/Response for Output Stage MI3
    .active_dec3    (i_active3to3),
    .readyout_dec3  (i_hready_mux_m3),
    .resp_dec3      (HRESPM3),
    .rdata_dec3     (HRDATAM3),
    .ruser_dec3     (HRUSERM3),

    // Control/Response for Output Stage MI4
    .active_dec4    (i_active3to4),
    .readyout_dec4  (i_hready_mux_m4),
    .resp_dec4      (HRESPM4),
    .rdata_dec4     (HRDATAM4),
    .ruser_dec4     (HRUSERM4),

    // Control/Response for Output Stage MI5
    .active_dec5    (i_active3to5),
    .readyout_dec5  (i_hready_mux_m5),
    .resp_dec5      (HRESPM5),
    .rdata_dec5     (HRDATAM5),
    .ruser_dec5     (HRUSERM5),

    // Control/Response for Output Stage MI6
    .active_dec6    (i_active3to6),
    .readyout_dec6  (i_hready_mux_m6),
    .resp_dec6      (HRESPM6),
    .rdata_dec6     (HRDATAM6),
    .ruser_dec6     (HRUSERM6),

    // Control/Response for Output Stage MI7
    .active_dec7    (i_active3to7),
    .readyout_dec7  (i_hready_mux_m7),
    .resp_dec7      (HRESPM7),
    .rdata_dec7     (HRDATAM7),
    .ruser_dec7     (HRUSERM7),

    .sel_dec0       (i_sel3to0),
    .sel_dec1       (i_sel3to1),
    .sel_dec2       (i_sel3to2),
    .sel_dec3       (i_sel3to3),
    .sel_dec4       (i_sel3to4),
    .sel_dec5       (i_sel3to5),
    .sel_dec6       (i_sel3to6),
    .sel_dec7       (i_sel3to7),

    .active_dec     (i_active3),
    .HREADYOUTS (i_readyout3),
    .HRESPS     (i_resp3),
    .HRUSERS    (HRUSERS3),
    .HRDATAS    (HRDATAS3)

    );


  // Output stage for MI0
  cmsdk_MyOutputNameM0 u_cmsdk_myoutputnamem0_0 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 0 Signals
    .sel_op0       (i_sel0to0),
    .addr_op0      (i_addr0),
    .auser_op0     (i_auser0),
    .trans_op0     (i_trans0),
    .write_op0     (i_write0),
    .size_op0      (i_size0),
    .burst_op0     (i_burst0),
    .prot_op0      (i_prot0),
    .master_op0    (i_master0),
    .mastlock_op0  (i_mastlock0),
    .wdata_op0     (HWDATAS0),
    .wuser_op0     (HWUSERS0),
    .held_tran_op0  (i_held_tran0),

    // Port 2 Signals
    .sel_op2       (i_sel2to0),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS2),
    .wuser_op2     (HWUSERS2),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to0),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS3),
    .wuser_op3     (HWUSERS3),
    .held_tran_op3  (i_held_tran3),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM0),

    .active_op0    (i_active0to0),
    .active_op2    (i_active2to0),
    .active_op3    (i_active3to0),

    // Slave Address/Control Signals
    .HSELM      (HSELM0),
    .HADDRM     (HADDRM0),
    .HAUSERM    (HAUSERM0),
    .HTRANSM    (HTRANSM0),
    .HWRITEM    (HWRITEM0),
    .HSIZEM     (HSIZEM0),
    .HBURSTM    (HBURSTM0),
    .HPROTM     (HPROTM0),
    .HMASTERM   (HMASTERM0),
    .HMASTLOCKM (HMASTLOCKM0),
    .HREADYMUXM (i_hready_mux_m0),
    .HWUSERM    (HWUSERM0),
    .HWDATAM    (HWDATAM0)

    );

  // Drive output with internal version
  assign HREADYMUXM0 = i_hready_mux_m0;


  // Output stage for MI1
  cmsdk_MyOutputNameM1 u_cmsdk_myoutputnamem1_1 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 1 Signals
    .sel_op1       (i_sel1to1),
    .addr_op1      (i_addr1),
    .auser_op1     (i_auser1),
    .trans_op1     (i_trans1),
    .write_op1     (i_write1),
    .size_op1      (i_size1),
    .burst_op1     (i_burst1),
    .prot_op1      (i_prot1),
    .master_op1    (i_master1),
    .mastlock_op1  (i_mastlock1),
    .wdata_op1     (HWDATAS1),
    .wuser_op1     (HWUSERS1),
    .held_tran_op1  (i_held_tran1),

    // Port 2 Signals
    .sel_op2       (i_sel2to1),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS2),
    .wuser_op2     (HWUSERS2),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to1),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS3),
    .wuser_op3     (HWUSERS3),
    .held_tran_op3  (i_held_tran3),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM1),

    .active_op1    (i_active1to1),
    .active_op2    (i_active2to1),
    .active_op3    (i_active3to1),

    // Slave Address/Control Signals
    .HSELM      (HSELM1),
    .HADDRM     (HADDRM1),
    .HAUSERM    (HAUSERM1),
    .HTRANSM    (HTRANSM1),
    .HWRITEM    (HWRITEM1),
    .HSIZEM     (HSIZEM1),
    .HBURSTM    (HBURSTM1),
    .HPROTM     (HPROTM1),
    .HMASTERM   (HMASTERM1),
    .HMASTLOCKM (HMASTLOCKM1),
    .HREADYMUXM (i_hready_mux_m1),
    .HWUSERM    (HWUSERM1),
    .HWDATAM    (HWDATAM1)

    );

  // Drive output with internal version
  assign HREADYMUXM1 = i_hready_mux_m1;


  // Output stage for MI2
  cmsdk_MyOutputNameM2 u_cmsdk_myoutputnamem2_2 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 1 Signals
    .sel_op1       (i_sel1to2),
    .addr_op1      (i_addr1),
    .auser_op1     (i_auser1),
    .trans_op1     (i_trans1),
    .write_op1     (i_write1),
    .size_op1      (i_size1),
    .burst_op1     (i_burst1),
    .prot_op1      (i_prot1),
    .master_op1    (i_master1),
    .mastlock_op1  (i_mastlock1),
    .wdata_op1     (HWDATAS1),
    .wuser_op1     (HWUSERS1),
    .held_tran_op1  (i_held_tran1),

    // Port 2 Signals
    .sel_op2       (i_sel2to2),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS2),
    .wuser_op2     (HWUSERS2),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to2),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS3),
    .wuser_op3     (HWUSERS3),
    .held_tran_op3  (i_held_tran3),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM2),

    .active_op1    (i_active1to2),
    .active_op2    (i_active2to2),
    .active_op3    (i_active3to2),

    // Slave Address/Control Signals
    .HSELM      (HSELM2),
    .HADDRM     (HADDRM2),
    .HAUSERM    (HAUSERM2),
    .HTRANSM    (HTRANSM2),
    .HWRITEM    (HWRITEM2),
    .HSIZEM     (HSIZEM2),
    .HBURSTM    (HBURSTM2),
    .HPROTM     (HPROTM2),
    .HMASTERM   (HMASTERM2),
    .HMASTLOCKM (HMASTLOCKM2),
    .HREADYMUXM (i_hready_mux_m2),
    .HWUSERM    (HWUSERM2),
    .HWDATAM    (HWDATAM2)

    );

  // Drive output with internal version
  assign HREADYMUXM2 = i_hready_mux_m2;


  // Output stage for MI3
  cmsdk_MyOutputNameM3 u_cmsdk_myoutputnamem3_3 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 1 Signals
    .sel_op1       (i_sel1to3),
    .addr_op1      (i_addr1),
    .auser_op1     (i_auser1),
    .trans_op1     (i_trans1),
    .write_op1     (i_write1),
    .size_op1      (i_size1),
    .burst_op1     (i_burst1),
    .prot_op1      (i_prot1),
    .master_op1    (i_master1),
    .mastlock_op1  (i_mastlock1),
    .wdata_op1     (HWDATAS1),
    .wuser_op1     (HWUSERS1),
    .held_tran_op1  (i_held_tran1),

    // Port 2 Signals
    .sel_op2       (i_sel2to3),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS2),
    .wuser_op2     (HWUSERS2),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to3),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS3),
    .wuser_op3     (HWUSERS3),
    .held_tran_op3  (i_held_tran3),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM3),

    .active_op1    (i_active1to3),
    .active_op2    (i_active2to3),
    .active_op3    (i_active3to3),

    // Slave Address/Control Signals
    .HSELM      (HSELM3),
    .HADDRM     (HADDRM3),
    .HAUSERM    (HAUSERM3),
    .HTRANSM    (HTRANSM3),
    .HWRITEM    (HWRITEM3),
    .HSIZEM     (HSIZEM3),
    .HBURSTM    (HBURSTM3),
    .HPROTM     (HPROTM3),
    .HMASTERM   (HMASTERM3),
    .HMASTLOCKM (HMASTLOCKM3),
    .HREADYMUXM (i_hready_mux_m3),
    .HWUSERM    (HWUSERM3),
    .HWDATAM    (HWDATAM3)

    );

  // Drive output with internal version
  assign HREADYMUXM3 = i_hready_mux_m3;


  // Output stage for MI4
  cmsdk_MyOutputNameM4 u_cmsdk_myoutputnamem4_4 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 1 Signals
    .sel_op1       (i_sel1to4),
    .addr_op1      (i_addr1),
    .auser_op1     (i_auser1),
    .trans_op1     (i_trans1),
    .write_op1     (i_write1),
    .size_op1      (i_size1),
    .burst_op1     (i_burst1),
    .prot_op1      (i_prot1),
    .master_op1    (i_master1),
    .mastlock_op1  (i_mastlock1),
    .wdata_op1     (HWDATAS1),
    .wuser_op1     (HWUSERS1),
    .held_tran_op1  (i_held_tran1),

    // Port 2 Signals
    .sel_op2       (i_sel2to4),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS2),
    .wuser_op2     (HWUSERS2),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to4),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS3),
    .wuser_op3     (HWUSERS3),
    .held_tran_op3  (i_held_tran3),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM4),

    .active_op1    (i_active1to4),
    .active_op2    (i_active2to4),
    .active_op3    (i_active3to4),

    // Slave Address/Control Signals
    .HSELM      (HSELM4),
    .HADDRM     (HADDRM4),
    .HAUSERM    (HAUSERM4),
    .HTRANSM    (HTRANSM4),
    .HWRITEM    (HWRITEM4),
    .HSIZEM     (HSIZEM4),
    .HBURSTM    (HBURSTM4),
    .HPROTM     (HPROTM4),
    .HMASTERM   (HMASTERM4),
    .HMASTLOCKM (HMASTLOCKM4),
    .HREADYMUXM (i_hready_mux_m4),
    .HWUSERM    (HWUSERM4),
    .HWDATAM    (HWDATAM4)

    );

  // Drive output with internal version
  assign HREADYMUXM4 = i_hready_mux_m4;


  // Output stage for MI5
  cmsdk_MyOutputNameM5 u_cmsdk_myoutputnamem5_5 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 1 Signals
    .sel_op1       (i_sel1to5),
    .addr_op1      (i_addr1),
    .auser_op1     (i_auser1),
    .trans_op1     (i_trans1),
    .write_op1     (i_write1),
    .size_op1      (i_size1),
    .burst_op1     (i_burst1),
    .prot_op1      (i_prot1),
    .master_op1    (i_master1),
    .mastlock_op1  (i_mastlock1),
    .wdata_op1     (HWDATAS1),
    .wuser_op1     (HWUSERS1),
    .held_tran_op1  (i_held_tran1),

    // Port 2 Signals
    .sel_op2       (i_sel2to5),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS2),
    .wuser_op2     (HWUSERS2),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to5),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS3),
    .wuser_op3     (HWUSERS3),
    .held_tran_op3  (i_held_tran3),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM5),

    .active_op1    (i_active1to5),
    .active_op2    (i_active2to5),
    .active_op3    (i_active3to5),

    // Slave Address/Control Signals
    .HSELM      (HSELM5),
    .HADDRM     (HADDRM5),
    .HAUSERM    (HAUSERM5),
    .HTRANSM    (HTRANSM5),
    .HWRITEM    (HWRITEM5),
    .HSIZEM     (HSIZEM5),
    .HBURSTM    (HBURSTM5),
    .HPROTM     (HPROTM5),
    .HMASTERM   (HMASTERM5),
    .HMASTLOCKM (HMASTLOCKM5),
    .HREADYMUXM (i_hready_mux_m5),
    .HWUSERM    (HWUSERM5),
    .HWDATAM    (HWDATAM5)

    );

  // Drive output with internal version
  assign HREADYMUXM5 = i_hready_mux_m5;


  // Output stage for MI6
  cmsdk_MyOutputNameM6 u_cmsdk_myoutputnamem6_6 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 1 Signals
    .sel_op1       (i_sel1to6),
    .addr_op1      (i_addr1),
    .auser_op1     (i_auser1),
    .trans_op1     (i_trans1),
    .write_op1     (i_write1),
    .size_op1      (i_size1),
    .burst_op1     (i_burst1),
    .prot_op1      (i_prot1),
    .master_op1    (i_master1),
    .mastlock_op1  (i_mastlock1),
    .wdata_op1     (HWDATAS1),
    .wuser_op1     (HWUSERS1),
    .held_tran_op1  (i_held_tran1),

    // Port 2 Signals
    .sel_op2       (i_sel2to6),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS2),
    .wuser_op2     (HWUSERS2),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to6),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS3),
    .wuser_op3     (HWUSERS3),
    .held_tran_op3  (i_held_tran3),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM6),

    .active_op1    (i_active1to6),
    .active_op2    (i_active2to6),
    .active_op3    (i_active3to6),

    // Slave Address/Control Signals
    .HSELM      (HSELM6),
    .HADDRM     (HADDRM6),
    .HAUSERM    (HAUSERM6),
    .HTRANSM    (HTRANSM6),
    .HWRITEM    (HWRITEM6),
    .HSIZEM     (HSIZEM6),
    .HBURSTM    (HBURSTM6),
    .HPROTM     (HPROTM6),
    .HMASTERM   (HMASTERM6),
    .HMASTLOCKM (HMASTLOCKM6),
    .HREADYMUXM (i_hready_mux_m6),
    .HWUSERM    (HWUSERM6),
    .HWDATAM    (HWDATAM6)

    );

  // Drive output with internal version
  assign HREADYMUXM6 = i_hready_mux_m6;


  // Output stage for MI7
  cmsdk_MyOutputNameM7 u_cmsdk_myoutputnamem7_7 (

    // Common AHB signals
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),

    // Port 0 Signals
    .sel_op0       (i_sel0to7),
    .addr_op0      (i_addr0),
    .auser_op0     (i_auser0),
    .trans_op0     (i_trans0),
    .write_op0     (i_write0),
    .size_op0      (i_size0),
    .burst_op0     (i_burst0),
    .prot_op0      (i_prot0),
    .master_op0    (i_master0),
    .mastlock_op0  (i_mastlock0),
    .wdata_op0     (HWDATAS0),
    .wuser_op0     (HWUSERS0),
    .held_tran_op0  (i_held_tran0),

    // Port 1 Signals
    .sel_op1       (i_sel1to7),
    .addr_op1      (i_addr1),
    .auser_op1     (i_auser1),
    .trans_op1     (i_trans1),
    .write_op1     (i_write1),
    .size_op1      (i_size1),
    .burst_op1     (i_burst1),
    .prot_op1      (i_prot1),
    .master_op1    (i_master1),
    .mastlock_op1  (i_mastlock1),
    .wdata_op1     (HWDATAS1),
    .wuser_op1     (HWUSERS1),
    .held_tran_op1  (i_held_tran1),

    // Port 2 Signals
    .sel_op2       (i_sel2to7),
    .addr_op2      (i_addr2),
    .auser_op2     (i_auser2),
    .trans_op2     (i_trans2),
    .write_op2     (i_write2),
    .size_op2      (i_size2),
    .burst_op2     (i_burst2),
    .prot_op2      (i_prot2),
    .master_op2    (i_master2),
    .mastlock_op2  (i_mastlock2),
    .wdata_op2     (HWDATAS2),
    .wuser_op2     (HWUSERS2),
    .held_tran_op2  (i_held_tran2),

    // Port 3 Signals
    .sel_op3       (i_sel3to7),
    .addr_op3      (i_addr3),
    .auser_op3     (i_auser3),
    .trans_op3     (i_trans3),
    .write_op3     (i_write3),
    .size_op3      (i_size3),
    .burst_op3     (i_burst3),
    .prot_op3      (i_prot3),
    .master_op3    (i_master3),
    .mastlock_op3  (i_mastlock3),
    .wdata_op3     (HWDATAS3),
    .wuser_op3     (HWUSERS3),
    .held_tran_op3  (i_held_tran3),

    // Slave read data and response
    .HREADYOUTM (HREADYOUTM7),

    .active_op0    (i_active0to7),
    .active_op1    (i_active1to7),
    .active_op2    (i_active2to7),
    .active_op3    (i_active3to7),

    // Slave Address/Control Signals
    .HSELM      (HSELM7),
    .HADDRM     (HADDRM7),
    .HAUSERM    (HAUSERM7),
    .HTRANSM    (HTRANSM7),
    .HWRITEM    (HWRITEM7),
    .HSIZEM     (HSIZEM7),
    .HBURSTM    (HBURSTM7),
    .HPROTM     (HPROTM7),
    .HMASTERM   (HMASTERM7),
    .HMASTLOCKM (HMASTLOCKM7),
    .HREADYMUXM (i_hready_mux_m7),
    .HWUSERM    (HWUSERM7),
    .HWDATAM    (HWDATAM7)

    );

  // Drive output with internal version
  assign HREADYMUXM7 = i_hready_mux_m7;


endmodule

// --================================= End ===================================--
