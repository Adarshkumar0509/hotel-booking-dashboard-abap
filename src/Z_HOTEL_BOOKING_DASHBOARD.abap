*&---------------------------------------------------------------------*
*& Program     : Z_HOTEL_BOOKING_DASHBOARD
*& Title       : Hotel Room Booking Analytics Dashboard (ALV Grid)
*& Author      : Adarsh Kumar | 2328063 | KIIT University | CSSE
*& Description : Enterprise hotel booking analytics using CL_GUI_ALV_GRID
*&               Features: occupancy tracking, revenue analytics, room-tier
*&               color coding, advanced analytics popup, Excel export,
*&               double-click drill-down, and clean 3-layer architecture.
*&
*& Tables Used : ZCUSTOM (simulated via inline data for demo)
*&               In real SAP system, map to hotel booking Z-tables or
*&               standard HR/SD tables as per system configuration.
*&
*& Architecture:
*&   Layer 1 - ZCL_HOTEL_DATA_FETCHER   : Data access (SELECT)
*&   Layer 2 - ZCL_HOTEL_BIZ_LOGIC      : Enrichment + analytics
*&   Layer 3 - ZCL_HOTEL_PRESENTER      : ALV field catalog + layout
*&   Handler  - ZCL_HOTEL_ALV_HANDLER   : Events (toolbar, click, drill)
*&---------------------------------------------------------------------*
PROGRAM z_hotel_booking_dashboard.

*======================================================================*
* TYPE DECLARATIONS
*======================================================================*
TYPES:
  " Raw booking record from DB join
  BEGIN OF ty_booking_raw,
    booking_id   TYPE char10,
    room_no      TYPE char6,
    room_type    TYPE char20,
    guest_name   TYPE char40,
    checkin_dt   TYPE d,
    checkout_dt  TYPE d,
    nights       TYPE i,
    rate_per_day TYPE p LENGTH 10 DECIMALS 2,
    currency     TYPE waers,
    status       TYPE char15,
    floor_no     TYPE i,
    amenities    TYPE char60,
  END OF ty_booking_raw,

  " Enriched display record for ALV
  BEGIN OF ty_booking_display,
    booking_id   TYPE char10,
    room_no      TYPE char6,
    room_type    TYPE char20,
    guest_name   TYPE char40,
    checkin_dt   TYPE d,
    checkout_dt  TYPE d,
    nights       TYPE i,
    rate_per_day TYPE p LENGTH 10 DECIMALS 2,
    currency     TYPE waers,
    status       TYPE char15,
    floor_no     TYPE i,
    amenities    TYPE char60,
    total_revenue TYPE p LENGTH 15 DECIMALS 2,
    occupancy_pct TYPE p LENGTH 5  DECIMALS 1,
    tier_icon    TYPE c LENGTH 1,
    rowcolor     TYPE c LENGTH 4,
  END OF ty_booking_display,

  " Analytics summary structure
  BEGIN OF ty_analytics,
    total_bookings    TYPE i,
    confirmed_count   TYPE i,
    checkedin_count   TYPE i,
    checkedout_count  TYPE i,
    cancelled_count   TYPE i,
    total_revenue     TYPE p LENGTH 20 DECIMALS 2,
    avg_rate          TYPE p LENGTH 10 DECIMALS 2,
    avg_nights        TYPE p LENGTH 5  DECIMALS 1,
    max_rate          TYPE p LENGTH 10 DECIMALS 2,
    min_rate          TYPE p LENGTH 10 DECIMALS 2,
    top_room_type     TYPE char20,
    top_room_count    TYPE i,
    suite_count       TYPE i,
    double_count      TYPE i,
    single_count      TYPE i,
    rev_per_night     TYPE p LENGTH 10 DECIMALS 2,
  END OF ty_analytics.

*======================================================================*
* CONSTANTS
*======================================================================*
CONSTANTS:
  c_rate_premium   TYPE p LENGTH 10 DECIMALS 2 VALUE '5000',
  c_rate_budget    TYPE p LENGTH 10 DECIMALS 2 VALUE '2000',
  c_btn_refresh    TYPE i VALUE 2001,
  c_btn_analytics  TYPE i VALUE 2002,
  c_btn_export     TYPE i VALUE 2003,
  c_prog_name      TYPE syst-repid VALUE 'Z_HOTEL_BOOKING_DASHBOARD',
  c_default_path   TYPE string VALUE 'C:\\Temp\\Hotel_Bookings.xls'.

*======================================================================*
* SELECTION SCREEN
*======================================================================*
SELECTION-SCREEN BEGIN OF BLOCK b_room WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: so_rtype FOR ('CHAR20')
                            NO INTERVALS DEFAULT 'SUITE' TO 'SINGLE' OPTION BT.
SELECTION-SCREEN END OF BLOCK b_room.

SELECTION-SCREEN BEGIN OF BLOCK b_date WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: so_cin FOR ('D')
                           DEFAULT '20240101' TO '20241231'.
SELECTION-SCREEN END OF BLOCK b_date.

SELECTION-SCREEN BEGIN OF BLOCK b_rate WITH FRAME TITLE TEXT-003.
  PARAMETERS: pa_rmin TYPE p DECIMALS 2 DEFAULT 0,
              pa_rmax TYPE p DECIMALS 2 DEFAULT 99999.
SELECTION-SCREEN END OF BLOCK b_rate.

SELECTION-SCREEN BEGIN OF BLOCK b_status WITH FRAME TITLE TEXT-004.
  PARAMETERS: pa_stat TYPE char15 DEFAULT 'ALL'.
SELECTION-SCREEN END OF BLOCK b_status.

SELECTION-SCREEN BEGIN OF BLOCK b_export WITH FRAME TITLE TEXT-005.
  PARAMETERS: pa_path TYPE string DEFAULT 'C:\\Temp\\Hotel_Bookings.xls'.
SELECTION-SCREEN END OF BLOCK b_export.
