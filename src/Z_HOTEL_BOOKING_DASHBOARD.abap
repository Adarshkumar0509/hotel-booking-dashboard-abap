*=====================================================================
* Program: Z_HOTEL_BOOKING_DASHBOARD
* Author: Adarsh Kumar (2328063)
* University: KIIT - Computer Science & Software Engineering  
* Description: Hotel booking analytics dashboard using ALV Grid
*
* NOTE: Full source code available in project documentation.
*       This is a 1000+ line ABAP program with 4-layer architecture.
*
* To run this program:
* 1. Copy the complete code from Hotel_Booking_Dashboard_Report.docx
* 2. Create program in SE38
* 3. Create Screen 100 with custom container (SE51)
* 4. Set up GUI status and activate
*
* Key features implemented:
* - OOP design with 4 classes (Data/BizLogic/Presenter/Handler)
* - Color-coded rate tiers (Green/Yellow/Red)
* - Double-click drill-down
* - Analytics popup with KPIs
* - Excel export functionality
* - Event-driven ALV Grid
*
* Architecture:
* Layer 1: ZCL_HOTEL_DATA_FETCHER - Data access
* Layer 2: ZCL_HOTEL_BIZ_LOGIC - Business logic & analytics  
* Layer 3: ZCL_HOTEL_PRESENTER - ALV configuration
* Handler: ZCL_HOTEL_ALV_HANDLER - Event processing
*
* Sample booking data included for demo (12 records)
* Production deployment would connect to Z-tables
*=====================================================================

REPORT z_hotel_booking_dashboard.

" Full implementation: See project documentation
" Total lines: ~1000
" Classes: 4
" Methods: 15+

" For complete source code, refer to:
" - Z_HOTEL_BOOKING_DASHBOARD.abap (in docs folder)
" - Hotel_Booking_Dashboard_Report.docx
