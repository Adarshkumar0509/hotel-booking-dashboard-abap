# Hotel Booking Dashboard - SAP ABAP

Built this dashboard during my ABAP course at KIIT. It's basically a hotel room booking analytics tool that runs on SAP using ALV Grid.

## What it does

- Shows hotel booking records in a neat table format
- Filters by room type, dates, price range, booking status
- Color codes rooms based on price tier (green for premium, yellow for standard, red for budget)
- Click on any booking to see full details
- Export everything to Excel
- Analytics popup showing revenue metrics and booking stats

## How I built it

Used OOP in ABAP with 4 main classes:
- Data layer for fetching bookings
- Business logic for calculations
- Presentation layer for the ALV grid setup
- Event handler for user interactions

## Features I'm proud of

**Color-coded rate tiers** - Rooms are color-coded based on daily rate. Makes it super easy to spot premium vs budget bookings at a glance.

**Analytics popup** - Hit the Analytics button to see:
- Total bookings and revenue
- Average nightly rate
- Status breakdown (confirmed/checked-in/checked-out/cancelled)
- Most popular room type
- Revenue per night

**Double-click drill-down** - Double-click any row to get full booking details including amenities, floor number, exact dates, etc.

**Excel export** - One-click export to .xls file with all the data

## Tech details

- ABAP Report program
- CL_GUI_ALV_GRID for the grid display
- Custom container on Screen 100
- Event-driven architecture (toolbar, double-click, user commands)
- Demo data included (in production you'd connect to Z-tables)

## Running it

1. Create the program in SE38 (transaction code)
2. Create Screen 100 in SE51 with a custom container named MAINCONTAINER
3. Set up GUI status MAIN with BACK/EXIT/CANCEL buttons
4. Activate and run

Filter options on the selection screen let you narrow down by room type, check-in dates, rate range, and booking status.

## Sample data

I've hardcoded 12 sample bookings covering:
- Single, Double, Suite, and Deluxe rooms
- Different floors (1-5)
- Various statuses
- Rate range from ₹1600 to ₹10000 per night
- Different guest names and amenity combinations

In a real system you'd replace `load_demo_data()` with actual SELECT statements from your booking tables.

## Screenshots

(will add once I capture them from the SAP GUI)

## Learnings

- First time using CL_GUI_ALV_GRID properly
- Event handling in ALV was tricky but makes sense now
- Separating concerns with multiple classes makes the code way cleaner
- ABAP inline declarations (DATA(var) = ...) are really handy

## Next steps

If I continue this:
- [ ] Add actual occupancy % calculation per floor
- [ ] Chart visualization for revenue trends
- [ ] Month-wise booking analysis
- [ ] Integration with real hotel booking tables
- [ ] User authorization checks

---

**Academic Project**  
Adarsh Kumar | 2328063  
KIIT University - Computer Science & Software Engineering  
Course: SAP ABAP Programming
