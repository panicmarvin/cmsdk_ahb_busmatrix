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
//  Abstract            : BusMatrixLite is a wrapper module that wraps around
//                        the BusMatrix module to give AHB Lite compliant
//                        slave and master interfaces.
//
//-----------------------------------------------------------------------------

`timescale 1ns/1ps

module cmsdk_MyBusMatrixName_lite (

    // Common AHB signals
    HCLK,
    HRESETn,

    // System Address Remap control
    REMAP,

    // Input port SI0 (inputs from master 0)
    HADDRS0,
    HTRANSS0,
    HWRITES0,
    HSIZES0,
    HBURSTS0,
    HPROTS0,
    HWDATAS0,
    HMASTLOCKS0,
    HAUSERS0,
    HWUSERS0,

    // Input port SI1 (inputs from master 1)
    HADDRS1,
    HTRANSS1,
    HWRITES1,
    HSIZES1,
    HBURSTS1,
    HPROTS1,
    HWDATAS1,
    HMASTLOCKS1,
    HAUSERS1,
    HWUSERS1,

    // Input port SI2 (inputs from master 2)
    HADDRS2,
    HTRANSS2,
    HWRITES2,
    HSIZES2,
    HBURSTS2,
    HPROTS2,
    HWDATAS2,
    HMASTLOCKS2,
    HAUSERS2,
    HWUSERS2,

    // Input port SI3 (inputs from master 3)
    HADDRS3,
    HTRANSS3,
    HWRITES3,
    HSIZES3,
    HBURSTS3,
    HPROTS3,
    HWDATAS3,
    HMASTLOCKS3,
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
    HWDATAM7,
    HMASTLOCKM7,
    HREADYMUXM7,
    HAUSERM7,
    HWUSERM7,

    // Input port SI0 (outputs to master 0)
    HRDATAS0,
    HREADYS0,
    HRESPS0,
    HRUSERS0,

    // Input port SI1 (outputs to master 1)
    HRDATAS1,
    HREADYS1,
    HRESPS1,
    HRUSERS1,

    // Input port SI2 (outputs to master 2)
    HRDATAS2,
    HREADYS2,
    HRESPS2,
    HRUSERS2,

    // Input port SI3 (outputs to master 3)
    HRDATAS3,
    HREADYS3,
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

    // System Address Remap control
    input   [3:0] REMAP;           // System Address REMAP control

    // Input port SI0 (inputs from master 0)
    input  [31:0] HADDRS0;         // Address bus
    input   [1:0] HTRANSS0;        // Transfer type
    input         HWRITES0;        // Transfer direction
    input   [2:0] HSIZES0;         // Transfer size
    input   [2:0] HBURSTS0;        // Burst type
    input   [3:0] HPROTS0;         // Protection control
    input  [31:0] HWDATAS0;        // Write data
    input         HMASTLOCKS0;     // Locked Sequence
    input  [3:0] HAUSERS0;        // Address USER signals
    input  [3:0] HWUSERS0;        // Write-data USER signals

    // Input port SI1 (inputs from master 1)
    input  [31:0] HADDRS1;         // Address bus
    input   [1:0] HTRANSS1;        // Transfer type
    input         HWRITES1;        // Transfer direction
    input   [2:0] HSIZES1;         // Transfer size
    input   [2:0] HBURSTS1;        // Burst type
    input   [3:0] HPROTS1;         // Protection control
    input  [31:0] HWDATAS1;        // Write data
    input         HMASTLOCKS1;     // Locked Sequence
    input  [3:0] HAUSERS1;        // Address USER signals
    input  [3:0] HWUSERS1;        // Write-data USER signals

    // Input port SI2 (inputs from master 2)
    input  [31:0] HADDRS2;         // Address bus
    input   [1:0] HTRANSS2;        // Transfer type
    input         HWRITES2;        // Transfer direction
    input   [2:0] HSIZES2;         // Transfer size
    input   [2:0] HBURSTS2;        // Burst type
    input   [3:0] HPROTS2;         // Protection control
    input  [31:0] HWDATAS2;        // Write data
    input         HMASTLOCKS2;     // Locked Sequence
    input  [3:0] HAUSERS2;        // Address USER signals
    input  [3:0] HWUSERS2;        // Write-data USER signals

    // Input port SI3 (inputs from master 3)
    input  [31:0] HADDRS3;         // Address bus
    input   [1:0] HTRANSS3;        // Transfer type
    input         HWRITES3;        // Transfer direction
    input   [2:0] HSIZES3;         // Transfer size
    input   [2:0] HBURSTS3;        // Burst type
    input   [3:0] HPROTS3;         // Protection control
    input  [31:0] HWDATAS3;        // Write data
    input         HMASTLOCKS3;     // Locked Sequence
    input  [3:0] HAUSERS3;        // Address USER signals
    input  [3:0] HWUSERS3;        // Write-data USER signals

    // Output port MI0 (inputs from slave 0)
    input  [31:0] HRDATAM0;        // Read data bus
    input         HREADYOUTM0;     // HREADY feedback
    input         HRESPM0;         // Transfer response
    input  [3:0] HRUSERM0;        // Read-data USER signals

    // Output port MI1 (inputs from slave 1)
    input  [31:0] HRDATAM1;        // Read data bus
    input         HREADYOUTM1;     // HREADY feedback
    input         HRESPM1;         // Transfer response
    input  [3:0] HRUSERM1;        // Read-data USER signals

    // Output port MI2 (inputs from slave 2)
    input  [31:0] HRDATAM2;        // Read data bus
    input         HREADYOUTM2;     // HREADY feedback
    input         HRESPM2;         // Transfer response
    input  [3:0] HRUSERM2;        // Read-data USER signals

    // Output port MI3 (inputs from slave 3)
    input  [31:0] HRDATAM3;        // Read data bus
    input         HREADYOUTM3;     // HREADY feedback
    input         HRESPM3;         // Transfer response
    input  [3:0] HRUSERM3;        // Read-data USER signals

    // Output port MI4 (inputs from slave 4)
    input  [31:0] HRDATAM4;        // Read data bus
    input         HREADYOUTM4;     // HREADY feedback
    input         HRESPM4;         // Transfer response
    input  [3:0] HRUSERM4;        // Read-data USER signals

    // Output port MI5 (inputs from slave 5)
    input  [31:0] HRDATAM5;        // Read data bus
    input         HREADYOUTM5;     // HREADY feedback
    input         HRESPM5;         // Transfer response
    input  [3:0] HRUSERM5;        // Read-data USER signals

    // Output port MI6 (inputs from slave 6)
    input  [31:0] HRDATAM6;        // Read data bus
    input         HREADYOUTM6;     // HREADY feedback
    input         HRESPM6;         // Transfer response
    input  [3:0] HRUSERM6;        // Read-data USER signals

    // Output port MI7 (inputs from slave 7)
    input  [31:0] HRDATAM7;        // Read data bus
    input         HREADYOUTM7;     // HREADY feedback
    input         HRESPM7;         // Transfer response
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
    output [31:0] HWDATAM7;        // Write data
    output        HMASTLOCKM7;     // Locked Sequence
    output        HREADYMUXM7;     // Transfer done
    output [3:0] HAUSERM7;        // Address USER signals
    output [3:0] HWUSERM7;        // Write-data USER signals

    // Input port SI0 (outputs to master 0)
    output [31:0] HRDATAS0;        // Read data bus
    output        HREADYS0;     // HREADY feedback
    output        HRESPS0;         // Transfer response
    output [3:0] HRUSERS0;        // Read-data USER signals

    // Input port SI1 (outputs to master 1)
    output [31:0] HRDATAS1;        // Read data bus
    output        HREADYS1;     // HREADY feedback
    output        HRESPS1;         // Transfer response
    output [3:0] HRUSERS1;        // Read-data USER signals

    // Input port SI2 (outputs to master 2)
    output [31:0] HRDATAS2;        // Read data bus
    output        HREADYS2;     // HREADY feedback
    output        HRESPS2;         // Transfer response
    output [3:0] HRUSERS2;        // Read-data USER signals

    // Input port SI3 (outputs to master 3)
    output [31:0] HRDATAS3;        // Read data bus
    output        HREADYS3;     // HREADY feedback
    output        HRESPS3;         // Transfer response
    output [3:0] HRUSERS3;        // Read-data USER signals

    // Scan test dummy signals; not connected until scan insertion
    output        SCANOUTHCLK;     // Scan Chain Output

// -----------------------------------------------------------------------------
// Wire declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    wire         HCLK;            // AHB System Clock
    wire         HRESETn;         // AHB System Reset

    // System Address Remap control
    wire   [3:0] REMAP;           // System REMAP signal

    // Input Port SI0
    wire  [31:0] HADDRS0;         // Address bus
    wire   [1:0] HTRANSS0;        // Transfer type
    wire         HWRITES0;        // Transfer direction
    wire   [2:0] HSIZES0;         // Transfer size
    wire   [2:0] HBURSTS0;        // Burst type
    wire   [3:0] HPROTS0;         // Protection control
    wire  [31:0] HWDATAS0;        // Write data
    wire         HMASTLOCKS0;     // Locked Sequence

    wire  [31:0] HRDATAS0;        // Read data bus
    wire         HREADYS0;     // HREADY feedback
    wire         HRESPS0;         // Transfer response
    wire  [3:0] HAUSERS0;        // Address USER signals
    wire  [3:0] HWUSERS0;        // Write-data USER signals
    wire  [3:0] HRUSERS0;        // Read-data USER signals

    // Input Port SI1
    wire  [31:0] HADDRS1;         // Address bus
    wire   [1:0] HTRANSS1;        // Transfer type
    wire         HWRITES1;        // Transfer direction
    wire   [2:0] HSIZES1;         // Transfer size
    wire   [2:0] HBURSTS1;        // Burst type
    wire   [3:0] HPROTS1;         // Protection control
    wire  [31:0] HWDATAS1;        // Write data
    wire         HMASTLOCKS1;     // Locked Sequence

    wire  [31:0] HRDATAS1;        // Read data bus
    wire         HREADYS1;     // HREADY feedback
    wire         HRESPS1;         // Transfer response
    wire  [3:0] HAUSERS1;        // Address USER signals
    wire  [3:0] HWUSERS1;        // Write-data USER signals
    wire  [3:0] HRUSERS1;        // Read-data USER signals

    // Input Port SI2
    wire  [31:0] HADDRS2;         // Address bus
    wire   [1:0] HTRANSS2;        // Transfer type
    wire         HWRITES2;        // Transfer direction
    wire   [2:0] HSIZES2;         // Transfer size
    wire   [2:0] HBURSTS2;        // Burst type
    wire   [3:0] HPROTS2;         // Protection control
    wire  [31:0] HWDATAS2;        // Write data
    wire         HMASTLOCKS2;     // Locked Sequence

    wire  [31:0] HRDATAS2;        // Read data bus
    wire         HREADYS2;     // HREADY feedback
    wire         HRESPS2;         // Transfer response
    wire  [3:0] HAUSERS2;        // Address USER signals
    wire  [3:0] HWUSERS2;        // Write-data USER signals
    wire  [3:0] HRUSERS2;        // Read-data USER signals

    // Input Port SI3
    wire  [31:0] HADDRS3;         // Address bus
    wire   [1:0] HTRANSS3;        // Transfer type
    wire         HWRITES3;        // Transfer direction
    wire   [2:0] HSIZES3;         // Transfer size
    wire   [2:0] HBURSTS3;        // Burst type
    wire   [3:0] HPROTS3;         // Protection control
    wire  [31:0] HWDATAS3;        // Write data
    wire         HMASTLOCKS3;     // Locked Sequence

    wire  [31:0] HRDATAS3;        // Read data bus
    wire         HREADYS3;     // HREADY feedback
    wire         HRESPS3;         // Transfer response
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
    wire  [31:0] HWDATAM0;        // Write data
    wire         HMASTLOCKM0;     // Locked Sequence
    wire         HREADYMUXM0;     // Transfer done

    wire  [31:0] HRDATAM0;        // Read data bus
    wire         HREADYOUTM0;     // HREADY feedback
    wire         HRESPM0;         // Transfer response
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
    wire  [31:0] HWDATAM1;        // Write data
    wire         HMASTLOCKM1;     // Locked Sequence
    wire         HREADYMUXM1;     // Transfer done

    wire  [31:0] HRDATAM1;        // Read data bus
    wire         HREADYOUTM1;     // HREADY feedback
    wire         HRESPM1;         // Transfer response
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
    wire  [31:0] HWDATAM2;        // Write data
    wire         HMASTLOCKM2;     // Locked Sequence
    wire         HREADYMUXM2;     // Transfer done

    wire  [31:0] HRDATAM2;        // Read data bus
    wire         HREADYOUTM2;     // HREADY feedback
    wire         HRESPM2;         // Transfer response
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
    wire  [31:0] HWDATAM3;        // Write data
    wire         HMASTLOCKM3;     // Locked Sequence
    wire         HREADYMUXM3;     // Transfer done

    wire  [31:0] HRDATAM3;        // Read data bus
    wire         HREADYOUTM3;     // HREADY feedback
    wire         HRESPM3;         // Transfer response
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
    wire  [31:0] HWDATAM4;        // Write data
    wire         HMASTLOCKM4;     // Locked Sequence
    wire         HREADYMUXM4;     // Transfer done

    wire  [31:0] HRDATAM4;        // Read data bus
    wire         HREADYOUTM4;     // HREADY feedback
    wire         HRESPM4;         // Transfer response
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
    wire  [31:0] HWDATAM5;        // Write data
    wire         HMASTLOCKM5;     // Locked Sequence
    wire         HREADYMUXM5;     // Transfer done

    wire  [31:0] HRDATAM5;        // Read data bus
    wire         HREADYOUTM5;     // HREADY feedback
    wire         HRESPM5;         // Transfer response
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
    wire  [31:0] HWDATAM6;        // Write data
    wire         HMASTLOCKM6;     // Locked Sequence
    wire         HREADYMUXM6;     // Transfer done

    wire  [31:0] HRDATAM6;        // Read data bus
    wire         HREADYOUTM6;     // HREADY feedback
    wire         HRESPM6;         // Transfer response
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
    wire  [31:0] HWDATAM7;        // Write data
    wire         HMASTLOCKM7;     // Locked Sequence
    wire         HREADYMUXM7;     // Transfer done

    wire  [31:0] HRDATAM7;        // Read data bus
    wire         HREADYOUTM7;     // HREADY feedback
    wire         HRESPM7;         // Transfer response
    wire  [3:0] HAUSERM7;        // Address USER signals
    wire  [3:0] HWUSERM7;        // Write-data USER signals
    wire  [3:0] HRUSERM7;        // Read-data USER signals


// -----------------------------------------------------------------------------
// Signal declarations
// -----------------------------------------------------------------------------
    wire   [3:0] tie_hi_4;
    wire         tie_hi;
    wire         tie_low;
    wire   [1:0] i_hrespS0;
    wire   [1:0] i_hrespS1;
    wire   [1:0] i_hrespS2;
    wire   [1:0] i_hrespS3;

    wire   [3:0]        i_hmasterM0;
    wire   [1:0] i_hrespM0;
    wire   [3:0]        i_hmasterM1;
    wire   [1:0] i_hrespM1;
    wire   [3:0]        i_hmasterM2;
    wire   [1:0] i_hrespM2;
    wire   [3:0]        i_hmasterM3;
    wire   [1:0] i_hrespM3;
    wire   [3:0]        i_hmasterM4;
    wire   [1:0] i_hrespM4;
    wire   [3:0]        i_hmasterM5;
    wire   [1:0] i_hrespM5;
    wire   [3:0]        i_hmasterM6;
    wire   [1:0] i_hrespM6;
    wire   [3:0]        i_hmasterM7;
    wire   [1:0] i_hrespM7;

// -----------------------------------------------------------------------------
// Beginning of main code
// -----------------------------------------------------------------------------

    assign tie_hi   = 1'b1;
    assign tie_hi_4 = 4'b1111;
    assign tie_low  = 1'b0;


    assign HRESPS0  = i_hrespS0[0];

    assign HRESPS1  = i_hrespS1[0];

    assign HRESPS2  = i_hrespS2[0];

    assign HRESPS3  = i_hrespS3[0];

    assign i_hrespM0 = {tie_low, HRESPM0};
    assign i_hrespM1 = {tie_low, HRESPM1};
    assign i_hrespM2 = {tie_low, HRESPM2};
    assign i_hrespM3 = {tie_low, HRESPM3};
    assign i_hrespM4 = {tie_low, HRESPM4};
    assign i_hrespM5 = {tie_low, HRESPM5};
    assign i_hrespM6 = {tie_low, HRESPM6};
    assign i_hrespM7 = {tie_low, HRESPM7};

// BusMatrix instance
  cmsdk_MyBusMatrixName ucmsdk_MyBusMatrixName (
    .HCLK       (HCLK),
    .HRESETn    (HRESETn),
    .REMAP      (REMAP),

    // Input port SI0 signals
    .HSELS0       (tie_hi),
    .HADDRS0      (HADDRS0),
    .HTRANSS0     (HTRANSS0),
    .HWRITES0     (HWRITES0),
    .HSIZES0      (HSIZES0),
    .HBURSTS0     (HBURSTS0),
    .HPROTS0      (HPROTS0),
    .HWDATAS0     (HWDATAS0),
    .HMASTLOCKS0  (HMASTLOCKS0),
    .HMASTERS0    (tie_hi_4),
    .HREADYS0     (HREADYS0),
    .HAUSERS0     (HAUSERS0),
    .HWUSERS0     (HWUSERS0),
    .HRDATAS0     (HRDATAS0),
    .HREADYOUTS0  (HREADYS0),
    .HRESPS0      (i_hrespS0),
    .HRUSERS0     (HRUSERS0),

    // Input port SI1 signals
    .HSELS1       (tie_hi),
    .HADDRS1      (HADDRS1),
    .HTRANSS1     (HTRANSS1),
    .HWRITES1     (HWRITES1),
    .HSIZES1      (HSIZES1),
    .HBURSTS1     (HBURSTS1),
    .HPROTS1      (HPROTS1),
    .HWDATAS1     (HWDATAS1),
    .HMASTLOCKS1  (HMASTLOCKS1),
    .HMASTERS1    (tie_hi_4),
    .HREADYS1     (HREADYS1),
    .HAUSERS1     (HAUSERS1),
    .HWUSERS1     (HWUSERS1),
    .HRDATAS1     (HRDATAS1),
    .HREADYOUTS1  (HREADYS1),
    .HRESPS1      (i_hrespS1),
    .HRUSERS1     (HRUSERS1),

    // Input port SI2 signals
    .HSELS2       (tie_hi),
    .HADDRS2      (HADDRS2),
    .HTRANSS2     (HTRANSS2),
    .HWRITES2     (HWRITES2),
    .HSIZES2      (HSIZES2),
    .HBURSTS2     (HBURSTS2),
    .HPROTS2      (HPROTS2),
    .HWDATAS2     (HWDATAS2),
    .HMASTLOCKS2  (HMASTLOCKS2),
    .HMASTERS2    (tie_hi_4),
    .HREADYS2     (HREADYS2),
    .HAUSERS2     (HAUSERS2),
    .HWUSERS2     (HWUSERS2),
    .HRDATAS2     (HRDATAS2),
    .HREADYOUTS2  (HREADYS2),
    .HRESPS2      (i_hrespS2),
    .HRUSERS2     (HRUSERS2),

    // Input port SI3 signals
    .HSELS3       (tie_hi),
    .HADDRS3      (HADDRS3),
    .HTRANSS3     (HTRANSS3),
    .HWRITES3     (HWRITES3),
    .HSIZES3      (HSIZES3),
    .HBURSTS3     (HBURSTS3),
    .HPROTS3      (HPROTS3),
    .HWDATAS3     (HWDATAS3),
    .HMASTLOCKS3  (HMASTLOCKS3),
    .HMASTERS3    (tie_hi_4),
    .HREADYS3     (HREADYS3),
    .HAUSERS3     (HAUSERS3),
    .HWUSERS3     (HWUSERS3),
    .HRDATAS3     (HRDATAS3),
    .HREADYOUTS3  (HREADYS3),
    .HRESPS3      (i_hrespS3),
    .HRUSERS3     (HRUSERS3),


    // Output port MI0 signals
    .HSELM0       (HSELM0),
    .HADDRM0      (HADDRM0),
    .HTRANSM0     (HTRANSM0),
    .HWRITEM0     (HWRITEM0),
    .HSIZEM0      (HSIZEM0),
    .HBURSTM0     (HBURSTM0),
    .HPROTM0      (HPROTM0),
    .HWDATAM0     (HWDATAM0),
    .HMASTERM0    (i_hmasterM0),
    .HMASTLOCKM0  (HMASTLOCKM0),
    .HREADYMUXM0  (HREADYMUXM0),
    .HAUSERM0     (HAUSERM0),
    .HWUSERM0     (HWUSERM0),
    .HRDATAM0     (HRDATAM0),
    .HREADYOUTM0  (HREADYOUTM0),
    .HRESPM0      (i_hrespM0),
    .HRUSERM0     (HRUSERM0),

    // Output port MI1 signals
    .HSELM1       (HSELM1),
    .HADDRM1      (HADDRM1),
    .HTRANSM1     (HTRANSM1),
    .HWRITEM1     (HWRITEM1),
    .HSIZEM1      (HSIZEM1),
    .HBURSTM1     (HBURSTM1),
    .HPROTM1      (HPROTM1),
    .HWDATAM1     (HWDATAM1),
    .HMASTERM1    (i_hmasterM1),
    .HMASTLOCKM1  (HMASTLOCKM1),
    .HREADYMUXM1  (HREADYMUXM1),
    .HAUSERM1     (HAUSERM1),
    .HWUSERM1     (HWUSERM1),
    .HRDATAM1     (HRDATAM1),
    .HREADYOUTM1  (HREADYOUTM1),
    .HRESPM1      (i_hrespM1),
    .HRUSERM1     (HRUSERM1),

    // Output port MI2 signals
    .HSELM2       (HSELM2),
    .HADDRM2      (HADDRM2),
    .HTRANSM2     (HTRANSM2),
    .HWRITEM2     (HWRITEM2),
    .HSIZEM2      (HSIZEM2),
    .HBURSTM2     (HBURSTM2),
    .HPROTM2      (HPROTM2),
    .HWDATAM2     (HWDATAM2),
    .HMASTERM2    (i_hmasterM2),
    .HMASTLOCKM2  (HMASTLOCKM2),
    .HREADYMUXM2  (HREADYMUXM2),
    .HAUSERM2     (HAUSERM2),
    .HWUSERM2     (HWUSERM2),
    .HRDATAM2     (HRDATAM2),
    .HREADYOUTM2  (HREADYOUTM2),
    .HRESPM2      (i_hrespM2),
    .HRUSERM2     (HRUSERM2),

    // Output port MI3 signals
    .HSELM3       (HSELM3),
    .HADDRM3      (HADDRM3),
    .HTRANSM3     (HTRANSM3),
    .HWRITEM3     (HWRITEM3),
    .HSIZEM3      (HSIZEM3),
    .HBURSTM3     (HBURSTM3),
    .HPROTM3      (HPROTM3),
    .HWDATAM3     (HWDATAM3),
    .HMASTERM3    (i_hmasterM3),
    .HMASTLOCKM3  (HMASTLOCKM3),
    .HREADYMUXM3  (HREADYMUXM3),
    .HAUSERM3     (HAUSERM3),
    .HWUSERM3     (HWUSERM3),
    .HRDATAM3     (HRDATAM3),
    .HREADYOUTM3  (HREADYOUTM3),
    .HRESPM3      (i_hrespM3),
    .HRUSERM3     (HRUSERM3),

    // Output port MI4 signals
    .HSELM4       (HSELM4),
    .HADDRM4      (HADDRM4),
    .HTRANSM4     (HTRANSM4),
    .HWRITEM4     (HWRITEM4),
    .HSIZEM4      (HSIZEM4),
    .HBURSTM4     (HBURSTM4),
    .HPROTM4      (HPROTM4),
    .HWDATAM4     (HWDATAM4),
    .HMASTERM4    (i_hmasterM4),
    .HMASTLOCKM4  (HMASTLOCKM4),
    .HREADYMUXM4  (HREADYMUXM4),
    .HAUSERM4     (HAUSERM4),
    .HWUSERM4     (HWUSERM4),
    .HRDATAM4     (HRDATAM4),
    .HREADYOUTM4  (HREADYOUTM4),
    .HRESPM4      (i_hrespM4),
    .HRUSERM4     (HRUSERM4),

    // Output port MI5 signals
    .HSELM5       (HSELM5),
    .HADDRM5      (HADDRM5),
    .HTRANSM5     (HTRANSM5),
    .HWRITEM5     (HWRITEM5),
    .HSIZEM5      (HSIZEM5),
    .HBURSTM5     (HBURSTM5),
    .HPROTM5      (HPROTM5),
    .HWDATAM5     (HWDATAM5),
    .HMASTERM5    (i_hmasterM5),
    .HMASTLOCKM5  (HMASTLOCKM5),
    .HREADYMUXM5  (HREADYMUXM5),
    .HAUSERM5     (HAUSERM5),
    .HWUSERM5     (HWUSERM5),
    .HRDATAM5     (HRDATAM5),
    .HREADYOUTM5  (HREADYOUTM5),
    .HRESPM5      (i_hrespM5),
    .HRUSERM5     (HRUSERM5),

    // Output port MI6 signals
    .HSELM6       (HSELM6),
    .HADDRM6      (HADDRM6),
    .HTRANSM6     (HTRANSM6),
    .HWRITEM6     (HWRITEM6),
    .HSIZEM6      (HSIZEM6),
    .HBURSTM6     (HBURSTM6),
    .HPROTM6      (HPROTM6),
    .HWDATAM6     (HWDATAM6),
    .HMASTERM6    (i_hmasterM6),
    .HMASTLOCKM6  (HMASTLOCKM6),
    .HREADYMUXM6  (HREADYMUXM6),
    .HAUSERM6     (HAUSERM6),
    .HWUSERM6     (HWUSERM6),
    .HRDATAM6     (HRDATAM6),
    .HREADYOUTM6  (HREADYOUTM6),
    .HRESPM6      (i_hrespM6),
    .HRUSERM6     (HRUSERM6),

    // Output port MI7 signals
    .HSELM7       (HSELM7),
    .HADDRM7      (HADDRM7),
    .HTRANSM7     (HTRANSM7),
    .HWRITEM7     (HWRITEM7),
    .HSIZEM7      (HSIZEM7),
    .HBURSTM7     (HBURSTM7),
    .HPROTM7      (HPROTM7),
    .HWDATAM7     (HWDATAM7),
    .HMASTERM7    (i_hmasterM7),
    .HMASTLOCKM7  (HMASTLOCKM7),
    .HREADYMUXM7  (HREADYMUXM7),
    .HAUSERM7     (HAUSERM7),
    .HWUSERM7     (HWUSERM7),
    .HRDATAM7     (HRDATAM7),
    .HREADYOUTM7  (HREADYOUTM7),
    .HRESPM7      (i_hrespM7),
    .HRUSERM7     (HRUSERM7),


    // Scan test dummy signals; not connected until scan insertion
    .SCANENABLE            (SCANENABLE),
    .SCANINHCLK            (SCANINHCLK),
    .SCANOUTHCLK           (SCANOUTHCLK)
  );


endmodule
