; Mini ERP: Sales and Inventory Management System
; Roger Rusdijanto Purnomo / TP075718 / APD2F2509CS(DA)
; Language: 32-bit NASM Assembly (Linux IA-32)
; Credentials:
;   ADMIN    username: admin   / password: 1234
;   CASHIER  username: cashier / password: 5678

bits 32
global _start

section .data

pn_maggi   db 'Maggi Goreng', 0
pn_teh     db 'Teh Ais',  0
pn_roti    db 'Roti Milo',  0

price_maggi    dd 5
price_teh      dd 2
price_roti     dd 3
cost_maggi     dd 3
cost_teh       dd 1
cost_roti      dd 2

admin_u     db 'admin',   0
admin_p     db '1234',    0
cash_u      db 'cashier', 0
cash_p      db '5678',    0

str_nl      db 10, 0
str_sep     db '----------------------------------------', 10, 0
str_inv     db 10, 'Invalid input!', 10, 0
str_eof     db 10, 'No more input. Exiting safely.', 10, 0

str_hdr     db 10
            db '', 10
            db '        KEDAI MAMAK MUNDUR          ', 10
            db '"Mini ERP: Sales and Inventory System"', 10                                 
            db '', 10, 0

str_lgn     db 10, ' SELECT YOUR ROLE: ', 10
            db '  1. Admin', 10
            db '  2. Cashier', 10
            db '  0. Exit System', 10
            db '', 10
            db 'Select Role [0-2]: ', 0
str_un      db 'Username : ', 0
str_pw      db 'Password : ', 0
str_lok     db 10, 'Login Successful! Welcome, ', 0
str_anm     db 'Admin!', 10, 0
str_cnm     db 'Cashier!', 10, 0
str_ler     db 10, 'Invalid credentials! Try again.', 10, 0

str_amn     db 10, 'ADMIN MENU', 10
            db '  1. Sales Module', 10
            db '  2. Inventory Module', 10
            db '  3. Finance Module', 10
            db '  4. Reports & Analysis', 10
            db '  0. Logout', 10
            db '', 10
            db 'Choice [0-4]: ', 0

str_cmn     db 10, 'CASHIER MENU', 10
            db '  1. Sales Module', 10
            db '  0. Logout', 10
            db '', 10
            db 'Choice [0-1]: ', 0

str_sh      db 10, 'SALES MODULE', 10, 0
str_ph      db 'Product List (Current Stock) ', 10, 0
str_p1      db '  1. Maggi Goreng  | Price: RM5 | Stock: ', 0
str_p2      db '  2. Teh Ais       | Price: RM2 | Stock: ', 0
str_p3      db '  3. Roti Milo     | Price: RM3 | Stock: ', 0
str_pb      db '  0. Back', 10, 0
str_sp      db 'Select Product [0-3]: ', 0
str_sq      db 'Quantity       : ', 0
str_ns      db 10, 'Insufficient stock! Available: ', 0
str_un2     db ' units', 10, 0

str_rh      db 10, '              SALES RECEIPT          ', 10, 0
str_rpd     db '  Product  : ', 0
str_rpr     db '  Price    : RM', 0
str_rqt     db '  Quantity : ', 0
str_rtt     db '  Total    : RM', 0
str_rrn     db '  Receipt# : RCP', 0
str_rft     db '', 10
            db '         Thank you! Come again!          ', 10
            db '', 10, 0

str_ih      db 10, ' INVENTORY MODULE ', 10, 0
str_im      db '  1. View All Stock', 10
            db '  2. Add Stock', 10
            db '  0. Back', 10
            db 'Choice [0-2]: ', 0
str_svh     db 'Current Stock Status: ', 10, 0
str_sb1     db '  Maggi Goreng  | Stock: ', 0
str_sb2     db '  Teh Ais   | Stock: ', 0
str_sb3     db '  Roti Milo   | Stock: ', 0
str_low     db '  LOW STOCK WARNING! (< 5 units)', 10, 0
str_sok     db '  [OK]', 10, 0
str_ap      db 'Select Product to Restock [1-3]: ', 0
str_aq      db 'Quantity to Add: ', 0
str_aok     db 10, 'Stock updated successfully!', 10, 0

str_fh      db 10, ' FINANCE MODULE ', 10, 0
str_frv     db '  Total Revenue : RM', 0
str_fcs     db '  Total Cost    : RM', 0
str_fpf     db '  Total Profit  : RM', 0
str_fdv     db '', 10, 0
str_fno     db '  No transactions recorded yet.', 10, 0

str_xh      db 10, ' REPORTS & ANALYSIS ', 10, 0
str_xm      db '  1. Daily Sales Report', 10
            db '  2. Weekly Sales Analysis', 10
            db '  3. Monthly Sales Analysis', 10
            db '  4. Best-Selling Product', 10
            db '  0. Back', 10
            db 'Choice [0-4]: ', 0

str_dh      db 10, ' DAILY SALES REPORT ', 10, 0
str_dtc     db '  Total Transactions    : ', 0
str_dts     db '  Total Sales (RM)      : ', 0
str_dqh     db ' Units Sold Per Product ', 10, 0
str_dmg     db '    Maggi Goreng : ', 0
str_dteh    db '    Teh Ais  : ', 0
str_droti   db '    Roti Milo  : ', 0
str_dun     db ' units', 10, 0

str_wh      db 10, ' WEEKLY SALES ANALYSIS ', 10, 0
str_wi      db '  Enter sales amount for each of 7 days.', 10, 0
str_wd      db 'Day ', 0
str_wds     db ' Sales (RM): ', 0
str_wt      db '  Total Sales (7 days)   : RM', 0
str_wa      db '  Average Daily Sales    : RM', 0
str_whi     db '  Highest Sales          : Day ', 0
str_wlo     db '  Lowest  Sales          : Day ', 0
str_wrm     db '    RM', 0

str_mh      db 10, ' MONTHLY SALES ANALYSIS ', 10, 0
str_mi      db '  Enter weekly total for each of 4 weeks.', 10, 0
str_mw      db '  Week ', 0
str_mws     db '    Total (RM): ', 0
str_mt      db '  Total Monthly Sales    : RM', 0
str_ma      db '  Average Weekly Sales   : RM', 0
str_mb      db '  Best-Performing Week   : Week ', 0
str_mrm     db '    RM', 0

str_bh      db 10, ' BEST-SELLING PRODUCT ', 10, 0
str_bp      db '  Best Seller  : ', 0
str_bq      db '  Qty Sold     : ', 0
str_bu      db ' units', 10, 0
str_bn      db '  No sales data recorded yet.', 10, 0

str_pe      db 10, ' Press ENTER to continue...  ', 0

section .bss

ibuf    resb 64
nbuf    resb 24

stk1    resd 1
stk2    resd 1
stk3    resd 1

sld1    resd 1
sld2    resd 1
sld3    resd 1

trev    resd 1
tcst    resd 1
rcno    resd 1
tcnt    resd 1

sv_p    resd 1
spr     resd 1
sqt     resd 1
stt     resd 1

wd      resd 7
md      resd 4

wktot   resd 1
wkmax   resd 1
wkmaxi  resd 1
wkmin   resd 1
wkmini  resd 1

motot   resd 1
momax   resd 1
momaxi  resd 1

role    resd 1

section .text

; UTILITY PROCEDURES

print_str:
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov  ecx, edi
    xor  edx, edx
.ps_len:
    cmp  byte [edi + edx], 0
    je   .ps_wrt
    inc  edx
    jmp  .ps_len
.ps_wrt:
    test edx, edx
    jz   .ps_end
    mov  eax, 4
    mov  ebx, 1
    int  0x80
.ps_end:
    pop  edi
    pop  edx
    pop  ecx
    pop  ebx
    pop  eax
    ret

print_nl:
    push eax
    push ebx
    push ecx
    push edx
    mov  eax, 4
    mov  ebx, 1
    lea  ecx, [str_nl]
    mov  edx, 1
    int  0x80
    pop  edx
    pop  ecx
    pop  ebx
    pop  eax
    ret

print_num:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    lea  esi, [nbuf + 23]
    mov  byte [esi], 0
    dec  esi
    mov  ebx, 10
    xor  edi, edi

    test eax, eax
    jnz  .pn_loop
    mov  byte [esi], '0'
    dec  esi
    inc  edi
    jmp  .pn_print
.pn_loop:
    test eax, eax
    jz   .pn_print
    xor  edx, edx
    div  ebx
    add  dl, '0'
    mov  [esi], dl
    dec  esi
    inc  edi
    jmp  .pn_loop
.pn_print:
    inc  esi
    mov  eax, 4
    mov  ebx, 1
    mov  ecx, esi
    mov  edx, edi
    int  0x80

    pop  edi
    pop  esi
    pop  edx
    pop  ecx
    pop  ebx
    pop  eax
    ret

print_num4:
    push eax
    push ebx
    push ecx
    push edx
    push esi

    lea  esi, [nbuf]
    mov  ebx, 10

    xor  edx, edx
    div  ebx
    add  dl, '0'
    mov  [esi + 3], dl

    xor  edx, edx
    div  ebx
    add  dl, '0'
    mov  [esi + 2], dl

    xor  edx, edx
    div  ebx
    add  dl, '0'
    mov  [esi + 1], dl

    add  al, '0'
    mov  [esi], al

    mov  eax, 4
    mov  ebx, 1
    mov  ecx, esi
    mov  edx, 4
    int  0x80

    pop  esi
    pop  edx
    pop  ecx
    pop  ebx
    pop  eax
    ret
    
; INPUT PROCEDURES
    
read_in:
    push ebx
    push ecx
    push edx
    push esi

    mov  eax, 3
    mov  ebx, 0
    lea  ecx, [ibuf]
    mov  edx, 63
    int  0x80

    cmp  eax, 0
    jg   .ri_has_input
    lea  edi, [str_eof]
    call print_str
    jmp  do_exit

.ri_has_input:
    mov  esi, eax
    lea  ecx, [ibuf]
    add  ecx, esi
    dec  ecx
    cmp  byte [ecx], 10
    jne  .ri_nt
    mov  byte [ecx], 0
    dec  esi
    jmp  .ri_done
.ri_nt:
    mov  byte [ecx + 1], 0
.ri_done:
    mov  eax, esi

    pop  esi
    pop  edx
    pop  ecx
    pop  ebx
    ret

to_num:
    push ebx
    push ecx
    push esi

    lea  esi, [ibuf]
    xor  eax, eax
    mov  ebx, 10
.tn_lp:
    movzx ecx, byte [esi]
    test  ecx, ecx
    jz    .tn_done
    cmp   ecx, '0'
    jl    .tn_done
    cmp   ecx, '9'
    jg    .tn_done
    sub   ecx, '0'
    imul  eax, ebx
    add   eax, ecx
    inc   esi
    jmp   .tn_lp
.tn_done:
    pop  esi
    pop  ecx
    pop  ebx
    ret

str_cmp:
    push ebx
    push ecx
    push edi
    push esi
.sc_lp:
    mov  bl, [edi]
    mov  cl, [esi]
    cmp  bl, cl
    jne  .sc_ne
    test bl, bl
    jz   .sc_eq
    inc  edi
    inc  esi
    jmp  .sc_lp
.sc_eq:
    xor  eax, eax
    pop  esi
    pop  edi
    pop  ecx
    pop  ebx
    ret
.sc_ne:
    mov  eax, 1
    pop  esi
    pop  edi
    pop  ecx
    pop  ebx
    ret

wait_enter:
    push edi
    lea  edi, [str_pe]
    call print_str
    pop  edi
    call read_in
    ret

init:
    mov  dword [stk1], 20
    mov  dword [stk2], 30
    mov  dword [stk3], 25
    mov  dword [sld1], 0
    mov  dword [sld2], 0
    mov  dword [sld3], 0
    mov  dword [trev], 0
    mov  dword [tcst], 0
    mov  dword [rcno], 1
    mov  dword [tcnt], 0
    mov  dword [role], 0

    lea  edi, [wd]
    xor  eax, eax
    mov  ecx, 7
.iw:
    mov  dword [edi], 0
    add  edi, 4
    loop .iw

    lea  edi, [md]
    mov  ecx, 4
.im:
    mov  dword [edi], 0
    add  edi, 4
    loop .im
    ret


; PROGRAM START

_start:
    call init
    lea  edi, [str_hdr]
    call print_str

login_loop:
    lea  edi, [str_lgn]
    call print_str
    call read_in
    call to_num

    cmp  eax, 0
    je   do_exit
    cmp  eax, 1
    je   login_admin
    cmp  eax, 2
    je   login_cash

    lea  edi, [str_inv]
    call print_str
    jmp  login_loop

login_admin:
    lea  edi, [str_un]
    call print_str
    call read_in

    lea  edi, [ibuf]
    lea  esi, [admin_u]
    call str_cmp
    test eax, eax
    jnz  .la_fail

    lea  edi, [str_pw]
    call print_str
    call read_in

    lea  edi, [ibuf]
    lea  esi, [admin_p]
    call str_cmp
    test eax, eax
    jnz  .la_fail

    lea  edi, [str_lok]
    call print_str
    lea  edi, [str_anm]
    call print_str
    mov  dword [role], 1
    jmp  menu_admin
.la_fail:
    lea  edi, [str_ler]
    call print_str
    jmp  login_loop

login_cash:
    lea  edi, [str_un]
    call print_str
    call read_in

    lea  edi, [ibuf]
    lea  esi, [cash_u]
    call str_cmp
    test eax, eax
    jnz  .lc_fail

    lea  edi, [str_pw]
    call print_str
    call read_in

    lea  edi, [ibuf]
    lea  esi, [cash_p]
    call str_cmp
    test eax, eax
    jnz  .lc_fail

    lea  edi, [str_lok]
    call print_str
    lea  edi, [str_cnm]
    call print_str
    mov  dword [role], 2
    jmp  menu_cash
.lc_fail:
    lea  edi, [str_ler]
    call print_str
    jmp  login_loop

menu_admin:
    lea  edi, [str_amn]
    call print_str
    call read_in
    call to_num

    cmp  eax, 0
    je   login_loop
    cmp  eax, 1
    je   .ma1
    cmp  eax, 2
    je   .ma2
    cmp  eax, 3
    je   .ma3
    cmp  eax, 4
    je   .ma4

    lea  edi, [str_inv]
    call print_str
    jmp  menu_admin
.ma1:
    call mod_sales
    jmp  menu_admin
.ma2:
    call mod_inv
    jmp  menu_admin
.ma3:
    call mod_fin
    jmp  menu_admin
.ma4:
    call mod_rpt
    jmp  menu_admin

menu_cash:
    lea  edi, [str_cmn]
    call print_str
    call read_in
    call to_num

    cmp  eax, 0
    je   login_loop
    cmp  eax, 1
    je   .mc1

    lea  edi, [str_inv]
    call print_str
    jmp  menu_cash
.mc1:
    call mod_sales
    jmp  menu_cash

; SALES MODULE

mod_sales:
    push ebx
.ms_top:
    lea  edi, [str_sh]
    call print_str
    lea  edi, [str_ph]
    call print_str

    lea  edi, [str_p1]
    call print_str
    mov  eax, [stk1]
    call print_num
    call print_nl

    lea  edi, [str_p2]
    call print_str
    mov  eax, [stk2]
    call print_num
    call print_nl

    lea  edi, [str_p3]
    call print_str
    mov  eax, [stk3]
    call print_num
    call print_nl

    lea  edi, [str_pb]
    call print_str
    lea  edi, [str_sp]
    call print_str
    call read_in
    call to_num

    cmp  eax, 0
    je   .ms_exit
    cmp  eax, 1
    je   .ms_p1
    cmp  eax, 2
    je   .ms_p2
    cmp  eax, 3
    je   .ms_p3
    lea  edi, [str_inv]
    call print_str
    jmp  .ms_top
.ms_p1:
    mov  dword [sv_p], 1
    mov  eax, [price_maggi]
    mov  [spr], eax
    jmp  .ms_qty
.ms_p2:
    mov  dword [sv_p], 2
    mov  eax, [price_teh]
    mov  [spr], eax
    jmp  .ms_qty
.ms_p3:
    mov  dword [sv_p], 3
    mov  eax, [price_roti]
    mov  [spr], eax
.ms_qty:
    lea  edi, [str_sq]
    call print_str
    call read_in
    call to_num

    test eax, eax
    jz   .ms_top
    mov  [sqt], eax

    mov  ebx, [sv_p]
    cmp  ebx, 1
    je   .ms_ck1
    cmp  ebx, 2
    je   .ms_ck2
    mov  eax, [stk3]
    jmp  .ms_ck
.ms_ck1:
    mov  eax, [stk1]
    jmp  .ms_ck
.ms_ck2:
    mov  eax, [stk2]
.ms_ck:
    cmp  eax, [sqt]
    jge  .ms_ok

    lea  edi, [str_ns]
    call print_str
    call print_num
    lea  edi, [str_un2]
    call print_str
    jmp  .ms_top
.ms_ok:
    mov  eax, [spr]
    imul eax, [sqt]
    mov  [stt], eax

    mov  ebx, [sv_p]
    cmp  ebx, 1
    je   .ms_us1
    cmp  ebx, 2
    je   .ms_us2

    mov  eax, [stk3]
    sub  eax, [sqt]
    mov  [stk3], eax
    mov  eax, [sld3]
    add  eax, [sqt]
    mov  [sld3], eax
    mov  eax, [cost_roti]
    jmp  .ms_uf
.ms_us1:
    mov  eax, [stk1]
    sub  eax, [sqt]
    mov  [stk1], eax
    mov  eax, [sld1]
    add  eax, [sqt]
    mov  [sld1], eax
    mov  eax, [cost_maggi]
    jmp  .ms_uf
.ms_us2:
    mov  eax, [stk2]
    sub  eax, [sqt]
    mov  [stk2], eax
    mov  eax, [sld2]
    add  eax, [sqt]
    mov  [sld2], eax
    mov  eax, [cost_teh]
.ms_uf:
    imul eax, [sqt]
    add  [tcst], eax

    mov  eax, [stt]
    add  [trev], eax
    inc  dword [tcnt]

    call print_rcpt
    inc  dword [rcno]

    call wait_enter
    jmp  .ms_top
.ms_exit:
    pop  ebx
    ret

print_rcpt:
    lea  edi, [str_rh]
    call print_str
    lea  edi, [str_sep]
    call print_str

    lea  edi, [str_rpd]
    call print_str
    mov  eax, [sv_p]
    cmp  eax, 1
    je   .pr_maggi
    cmp  eax, 2
    je   .pr_teh
    lea  edi, [pn_roti]
    jmp  .pr_nm
.pr_maggi:
    lea  edi, [pn_maggi]
    jmp  .pr_nm
.pr_teh:
    lea  edi, [pn_teh]
.pr_nm:
    call print_str
    call print_nl

    lea  edi, [str_rpr]
    call print_str
    mov  eax, [spr]
    call print_num
    call print_nl

    lea  edi, [str_rqt]
    call print_str
    mov  eax, [sqt]
    call print_num
    call print_nl

    lea  edi, [str_rtt]
    call print_str
    mov  eax, [stt]
    call print_num
    call print_nl

    lea  edi, [str_rrn]
    call print_str
    mov  eax, [rcno]
    call print_num4
    call print_nl

    lea  edi, [str_sep]
    call print_str
    lea  edi, [str_rft]
    call print_str
    ret

; INVENTORY MODULE

mod_inv:
    push ebx
.mi_top:
    lea  edi, [str_ih]
    call print_str
    lea  edi, [str_im]
    call print_str
    call read_in
    call to_num

    cmp  eax, 0
    je   .mi_exit
    cmp  eax, 1
    je   .mi_view
    cmp  eax, 2
    je   .mi_add
    lea  edi, [str_inv]
    call print_str
    jmp  .mi_top
.mi_view:
    lea  edi, [str_svh]
    call print_str

    lea  edi, [str_sb1]
    call print_str
    mov  eax, [stk1]
    call print_num
    cmp  dword [stk1], 5
    jl   .mi_maggi_low
    lea  edi, [str_sok]
    call print_str
    jmp  .mi_teh
.mi_maggi_low:
    lea  edi, [str_low]
    call print_str
.mi_teh:
    lea  edi, [str_sb2]
    call print_str
    mov  eax, [stk2]
    call print_num
    cmp  dword [stk2], 5
    jl   .mi_teh_low
    lea  edi, [str_sok]
    call print_str
    jmp  .mi_roti
.mi_teh_low:
    lea  edi, [str_low]
    call print_str
.mi_roti:
    lea  edi, [str_sb3]
    call print_str
    mov  eax, [stk3]
    call print_num
    cmp  dword [stk3], 5
    jl   .mi_roti_low
    lea  edi, [str_sok]
    call print_str
    jmp  .mi_vdone
.mi_roti_low:
    lea  edi, [str_low]
    call print_str
.mi_vdone:
    call wait_enter
    jmp  .mi_top
.mi_add:
    lea  edi, [str_ap]
    call print_str
    call read_in
    call to_num

    cmp  eax, 1
    jl   .mi_aerr
    cmp  eax, 3
    jg   .mi_aerr
    mov  ebx, eax

    lea  edi, [str_aq]
    call print_str
    call read_in
    call to_num

    test eax, eax
    jz   .mi_top

    cmp  ebx, 1
    je   .mi_a1
    cmp  ebx, 2
    je   .mi_a2
    add  [stk3], eax
    jmp  .mi_adone
.mi_a1:
    add  [stk1], eax
    jmp  .mi_adone
.mi_a2:
    add  [stk2], eax
.mi_adone:
    lea  edi, [str_aok]
    call print_str
    jmp  .mi_top
.mi_aerr:
    lea  edi, [str_inv]
    call print_str
    jmp  .mi_top
.mi_exit:
    pop  ebx
    ret

; FINANCE MODULE

mod_fin:
    lea  edi, [str_fh]
    call print_str

    cmp  dword [tcnt], 0
    jne  .mf_show
    lea  edi, [str_fno]
    call print_str
    call wait_enter
    ret
.mf_show:
    lea  edi, [str_frv]
    call print_str
    mov  eax, [trev]
    call print_num
    call print_nl

    lea  edi, [str_fcs]
    call print_str
    mov  eax, [tcst]
    call print_num
    call print_nl

    lea  edi, [str_sep]
    call print_str

    lea  edi, [str_fpf]
    call print_str
    mov  eax, [trev]
    sub  eax, [tcst]
    call print_num
    call print_nl

    call wait_enter
    ret

; REPORTS & ANALYSIS MODULE

mod_rpt:
.mr_top:
    lea  edi, [str_xh]
    call print_str
    lea  edi, [str_xm]
    call print_str
    call read_in
    call to_num

    cmp  eax, 0
    je   .mr_exit
    cmp  eax, 1
    je   .mr1
    cmp  eax, 2
    je   .mr2
    cmp  eax, 3
    je   .mr3
    cmp  eax, 4
    je   .mr4
    lea  edi, [str_inv]
    call print_str
    jmp  .mr_top
.mr1:
    call rpt_daily
    jmp  .mr_top
.mr2:
    call rpt_weekly
    jmp  .mr_top
.mr3:
    call rpt_monthly
    jmp  .mr_top
.mr4:
    call rpt_best
    jmp  .mr_top
.mr_exit:
    ret

rpt_daily:
    lea  edi, [str_dh]
    call print_str
    lea  edi, [str_sep]
    call print_str

    lea  edi, [str_dtc]
    call print_str
    mov  eax, [tcnt]
    call print_num
    call print_nl

    lea  edi, [str_dts]
    call print_str
    mov  eax, [trev]
    call print_num
    call print_nl

    lea  edi, [str_sep]
    call print_str
    lea  edi, [str_dqh]
    call print_str

    lea  edi, [str_dmg]
    call print_str
    mov  eax, [sld1]
    call print_num
    lea  edi, [str_dun]
    call print_str

    lea  edi, [str_dteh]
    call print_str
    mov  eax, [sld2]
    call print_num
    lea  edi, [str_dun]
    call print_str

    lea  edi, [str_droti]
    call print_str
    mov  eax, [sld3]
    call print_num
    lea  edi, [str_dun]
    call print_str

    call wait_enter
    ret

rpt_weekly:
    push ebx
    lea  edi, [str_wh]
    call print_str
    lea  edi, [str_wi]
    call print_str

    xor  ebx, ebx
.rw_in:
    cmp  ebx, 7
    jge  .rw_calc

    lea  edi, [str_wd]
    call print_str
    mov  eax, ebx
    inc  eax
    call print_num
    lea  edi, [str_wds]
    call print_str
    call read_in
    call to_num

    lea  ecx, [wd]
    mov  [ecx + ebx*4], eax
    
    call print_nl

    inc  ebx
    jmp  .rw_in
.rw_calc:
    lea  ecx, [wd]
    mov  eax, [ecx]
    mov  [wktot], eax
    mov  [wkmax], eax
    mov  [wkmin], eax
    xor  eax, eax
    mov  [wkmaxi], eax
    mov  [wkmini], eax

    mov  ebx, 1
.rw_sum:
    cmp  ebx, 7
    jge  .rw_print

    lea  ecx, [wd]
    mov  eax, [ecx + ebx*4]
    add  [wktot], eax

    cmp  eax, [wkmax]
    jle  .rw_chkmin
    mov  [wkmax], eax
    mov  [wkmaxi], ebx
.rw_chkmin:
    cmp  eax, [wkmin]
    jge  .rw_next
    mov  [wkmin], eax
    mov  [wkmini], ebx
.rw_next:
    inc  ebx
    jmp  .rw_sum
.rw_print:
    lea  edi, [str_sep]
    call print_str

    lea  edi, [str_wt]
    call print_str
    mov  eax, [wktot]
    call print_num
    call print_nl

    lea  edi, [str_wa]
    call print_str
    mov  eax, [wktot]
    xor  edx, edx
    mov  ebx, 7
    div  ebx
    call print_num
    call print_nl

    lea  edi, [str_whi]
    call print_str
    mov  eax, [wkmaxi]
    inc  eax
    call print_num
    lea  edi, [str_wrm]
    call print_str
    mov  eax, [wkmax]
    call print_num
    call print_nl

    lea  edi, [str_wlo]
    call print_str
    mov  eax, [wkmini]
    inc  eax
    call print_num
    lea  edi, [str_wrm]
    call print_str
    mov  eax, [wkmin]
    call print_num
    call print_nl

    call wait_enter
    pop  ebx
    ret

rpt_monthly:
    push ebx
    lea  edi, [str_mh]
    call print_str
    lea  edi, [str_mi]
    call print_str

    xor  ebx, ebx
.rm_in:
    cmp  ebx, 4
    jge  .rm_calc

    lea  edi, [str_mw]
    call print_str
    mov  eax, ebx
    inc  eax
    call print_num
    lea  edi, [str_mws]
    call print_str
    call read_in
    call to_num

    lea  ecx, [md]
    mov  [ecx + ebx*4], eax
    
    call print_nl

    inc  ebx
    jmp  .rm_in
.rm_calc:
    lea  ecx, [md]
    mov  eax, [ecx]
    mov  [motot], eax
    mov  [momax], eax
    xor  eax, eax
    mov  [momaxi], eax

    mov  ebx, 1
.rm_sum:
    cmp  ebx, 4
    jge  .rm_print

    lea  ecx, [md]
    mov  eax, [ecx + ebx*4]
    add  [motot], eax

    cmp  eax, [momax]
    jle  .rm_next
    mov  [momax], eax
    mov  [momaxi], ebx
.rm_next:
    inc  ebx
    jmp  .rm_sum
.rm_print:
    lea  edi, [str_sep]
    call print_str

    lea  edi, [str_mt]
    call print_str
    mov  eax, [motot]
    call print_num
    call print_nl

    lea  edi, [str_ma]
    call print_str
    mov  eax, [motot]
    xor  edx, edx
    mov  ebx, 4
    div  ebx
    call print_num
    call print_nl

    lea  edi, [str_mb]
    call print_str
    mov  eax, [momaxi]
    inc  eax
    call print_num
    lea  edi, [str_mrm]
    call print_str
    mov  eax, [momax]
    call print_num
    call print_nl

    call wait_enter
    pop  ebx
    ret

rpt_best:
    push ebx
    lea  edi, [str_bh]
    call print_str
    lea  edi, [str_sep]
    call print_str

    mov  eax, [sld1]
    add  eax, [sld2]
    add  eax, [sld3]
    test eax, eax
    jnz  .rb_data

    lea  edi, [str_bn]
    call print_str
    call wait_enter
    pop  ebx
    ret
.rb_data:
    mov  eax, [sld1]
    mov  ebx, 1

    cmp  dword [sld2], eax
    jle  .rb_cmp3
    mov  eax, [sld2]
    mov  ebx, 2
.rb_cmp3:
    cmp  dword [sld3], eax
    jle  .rb_found
    mov  eax, [sld3]
    mov  ebx, 3
.rb_found:
    push eax

    lea  edi, [str_bp]
    call print_str
    cmp  ebx, 1
    je   .rb_maggi
    cmp  ebx, 2
    je   .rb_teh
    lea  edi, [pn_roti]
    jmp  .rb_nm
.rb_maggi:
    lea  edi, [pn_maggi]
    jmp  .rb_nm
.rb_teh:
    lea  edi, [pn_teh]
.rb_nm:
    call print_str
    call print_nl

    lea  edi, [str_bq]
    call print_str
    pop  eax
    call print_num
    lea  edi, [str_bu]
    call print_str

    call wait_enter
    pop  ebx
    ret

; EXIT

do_exit:
    call print_nl
    mov  eax, 1
    xor  ebx, ebx
    int  0x80