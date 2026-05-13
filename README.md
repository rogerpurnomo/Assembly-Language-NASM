# Assembly-Language-NASM

Kedai Mamak Mundur — Mini ERP System
**Mini ERP: Sales and Inventory Management System**  

PROJECT OVERVIEW

This is a terminal-based Mini ERP (Enterprise Resource Planning) system simulating a small food stall (kedai mamak) operation. It supports two user roles: **Admin** and **Cashier**, each with their own access level and menu. The system handles sales transactions, inventory management, financial summaries, and sales reports, all implemented from scratch in x86 assembly language without any high-level libraries.
The author uses jdoodle.com as the online compiler.

LOGIN CREDENTIALS
- ADMIN:
username = admin
password = 1234

- CASHIER:
username = cashier
password = 5678

FEATURES

Sales Module (Admin & Cashier)
- View product list with live stock levels
- Select product and quantity to process a sale
- Automatic stock deduction on successful transaction
- Insufficient stock warning with available quantity shown
- Auto-generated formatted receipt with unique receipt number (`RCP0001`, `RCP0002`, ...)

Inventory Module (Admin only)
- View current stock levels for all products
- Automatic LOW STOCK WARNING when any item falls below 5 units
- Restock any product by adding quantity directly

Finance Module (Admin only)
- View total revenue, total cost, and net profit
- All figures computed in real time from live transaction accumulators
- Graceful "no transactions yet" message if accessed before any sales

Reports & Analysis Module (Admin only)
- Daily Sales Report = transaction count, total sales, units sold per product
- Weekly Sales Analysis = 7 day input, total, average, highest and lowest sales day
- Monthly Sales Analysis = 4 week input, total, average, best-performing week
- Best-Selling Product = compares all three products and displays the top seller

PRODUCTS

1. Maggi Goreng | Price = RM 5 | Cost = RM 3 | 20 units (initial stock)
2. Teh Ais | Price = RM 2 | Cost = RM 1 | 30 units (initial stock)
3. Roti Milo | Price = RM 3 | Cost = RM 2 | 25 units (initial stock)

TECHNICAL HIGHLIGHTS

- No standard library = all I/O done via raw Linux system calls (`int 0x80`)
  - `sys_read` (syscall 3) for keyboard input
  - `sys_write` (syscall 4) for all output
  - `sys_exit` (syscall 1) for clean termination
- Custom string procedures = `print_str`, `print_num`, `print_num4`, `str_cmp` built from scratch
- ASCII integer conversion = `to_num` (string→int) and `print_num` (int→string) implemented manually
- Role-based access control = enforced at menu level via the `role` variable
- Safe EOF handling = `read_in` checks for zero-byte reads to prevent segmentation faults
- Scaled indexed addressing = used in weekly/monthly report loops (`[ecx + ebx*4]`)

`.data` section (static/read-only)
- Product names, prices, costs
- Login credentials
- All UI strings and menu text

`.bss` section (runtime variables)
- `ibuf` — 64-byte input buffer
- `stk1/2/3` — live stock levels
- `sld1/2/3` — units sold per product
- `trev`, `tcst`, `tcnt` — revenue, cost, transaction count
- `wd[7]`, `md[4]` — weekly and monthly sales arrays
