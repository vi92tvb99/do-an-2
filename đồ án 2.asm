.data
	nhapngay: .asciiz "Nhap ngay DAY: "
	nhapthang: .asciiz "Nhap thang MONTH: "
	nhapnam: .asciiz "Nhap nam: "
	menu: .asciiz "----------Ban hay chon 1 trong cac thao tac duoi day -----\n"
	chon1: .asciiz "\t1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
	chon2: .asciiz "\t2. Chuyen doi chuoi TIME thành mot trong các dinh dang.\n"
	chon2_menu:	.asciiz "\t\tA. MM/DD/YYYY\n\t\tB. Month DD, YYYY\n\t\tC. DD Month, YYYY\n"
	chon3: .asciiz "\t3. Kiem tra nam trong chuoi TIME có phai là nam nhuan khong\n"
	chon4: .asciiz "\t4. Cho biet ngày vua nhap là ngày thu may trong tuan.\n"
	chon5: .asciiz "\t5. Cho biet ngày vua nhap là ngày thu may ke tu ngày 1/1/1.\n"
	chon6: .asciiz "\t6. Cho biet can chi cua nam vua nhap. Ví du nam 2019 là Ki Hoi\n"
	chon7: .asciiz "\t7. Cho biet khoang thoi gian giua chuoi TIME_1 và TIME_2\n"
	chon8: .asciiz "\t8. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi time\n"
	chon9: .asciiz "\t9. Nhap input tu file input.txt xuat ket qua toàn bo các chuc nang trên ra file output.txt\n"
	endmenu: .asciiz "---------------------------------------------------------\n"
	luachon: .asciiz "Lua chon: "
	ketqua: .asciiz "Ket qua: "
	khonghople: .asciiz "Không hop le.\n"
	namnhuan: .asciiz "Nam vua nhap la nam nhuan.\n"
	namkhongnhuan: .asciiz "Nam vua nhap la nam khong nhuan.\n"
	monday: .asciiz "Monday"
	kihoi: .asciiz "Ki hoi"
	nhaptime2:	.asciiz "Nhap Time_2:\n"
	Giap: 	.asciiz	"Giap"
	At: 	.asciiz	"At"
	Binh: 	.asciiz	"Binh"
	Dinh:	.asciiz	"Dinh"
	Mau:	.asciiz	"Mau"
	Ky:	.asciiz	"Ky"
	Canh:	.asciiz	"Canh"
	Tan:	.asciiz	"Tan"
	Nham:	.asciiz	"Nham"
	Quy:	.asciiz	"Quy"
	
	Ti:	.asciiz	"Ti"
	Suu:	.asciiz	"Suu"
	Dan:	.asciiz	"Dan"
	Meo:	.asciiz	"Meo"
	Thin:	.asciiz	"Thin"
	Ty:	.asciiz	"Ty"
	Ngo:	.asciiz	"Ngo" 
	Mui:	.asciiz	"Mui" 
	Than:	.asciiz	"Than" 	
	Dau:	.asciiz	"Dau" 
	Tuat:	.asciiz	"Tuat" 
	Hoi:	.asciiz	"Hoi"
	convert_time: .space 11
	daysOfWeek: .word cn, t2, t3, t4, t5, t6, t7
	sun: .asciiz " Sun"
	mon: .asciiz " Mon"
	tue: .asciiz " Tue"
	wed: .asciiz " Wed"
	thu: .asciiz " Thu"
	fri: .asciiz " Fri"
	sat: .asciiz " Sat"
	day: .word 0
	month: .word 0
	year: .word 0
	time: .space 16
	time2: .space 16
.text

#Hàm main
main:
	#Goi ham nhap time
	la $a0,time
	jal NhapTime

#Xuat menu
	li $v0,4
	la $a0,chon1
	syscall

	li $v0,4
	la $a0,chon2
	syscall

	li $v0,4
	la $a0,chon3
	syscall

	li $v0,4
	la $a0,chon4
	syscall

	li $v0,4
	la $a0,chon5
	syscall

	li $v0,4
	la $a0,chon6
	syscall

	li $v0,4
	la $a0,chon7
	syscall

	li $v0,4
	la $a0,chon8
	syscall

	li $v0,4
	la $a0,chon9
	syscall

	li $v0,4
	la $a0,endmenu
	syscall

NhapLuaChon:
	li $v0,4
	la $a0,luachon
	syscall

	li $v0,5
	syscall
	move $s0,$v0

	slt $t0,$s0,$0
	bne $t0,$0,NhapLuaChon

	slti $t0,$s0,10
	beq $t0,$0,NhapLuaChon

	beq $s0,1,XuatTime

	beq $s0,2,ChuyenDoi

	beq $s0,3,KiemTraNhuan

	beq $s0,4,NgayThuMay

	beq $s0,5,TinhFullNgay

	beq $s0,6,TinhCanChi

	beq $s0,7,TinhKhoangTime

	beq $s0,8,HaiNamNhuanGan

	beq $s0,9,NhapXuatInOut

#-----------Xuat time-------------
XuatTime:
	#Xuat ket qua
	li $v0,4
	la $a0,ketqua
	syscall

	li $v0,4
	la $a0,time
	syscall
	j KetThuc

#-----------Chuyen Doi-------------
ChuyenDoi:
	#Xuat lua chon
	li $v0,4
	la $a0,chon2_menu
	syscall

	li $v0,4
	la $a0,luachon
	syscall

	li $v0,12
	syscall	
	move $s0,$v0
	
	slti $t0,$s0,65
	bne $t0,$0,ChuyenDoi
	slti $t0,$s0,68
	beq $t0,$0,ChuyenDoi

	#Goi ham Convert
	la $a0,time
	move $a1,$s0
	jal Convert

	move $s0,$v0

	#Xuat ket qua
	li $v0,11
	li $a0,10
	syscall
	li $v0,4
	la $a0,ketqua
	syscall

	#Xuat chuoi
	li $v0,4
	move $a0,$s0
	syscall

	j KetThuc

#------------------Kiem Tra nam nhuan---------------
KiemTraNhuan:
	#Xuat ket qua
	li $v0,4
	la $a0,ketqua
	syscall

	#Goi ham LeapYear
	la $a0,time
	jal LeapYear

	move $t0,$v0
	bne $t0,$0,KiemTraNhuan_Nhuan
	
	li $v0,4
	la $a0,namkhongnhuan
	syscall

	j KetThuc

KiemTraNhuan_Nhuan:
	li $v0,4
	la $a0,namnhuan
	syscall

	j KetThuc

#-------------Ngay do la ngay thu may trong tuan ------------------
NgayThuMay:
	#Goi ham WeekDay
	la $a0,time
	jal WeekDay
	
	move $s0,$v0
	#Xuat ket qua
	li $v0,4
	la $a0,ketqua
	syscall

	li $v0,4
	move $a0,$s0
	syscall

	j KetThuc

#-----------------Tinh bao nhieu ngay ke tu 1/1/1 -------------------
TinhFullNgay:
	#Goi ham FullDate
	la $a0,time
	jal FullDate

	move $s0,$v0
	#Xuat chuoi ket qua
	li $v0,4
	la $a0,ketqua
	syscall

	#Xuat ket qua
	li $v0,1
	move $a0,$s0
	syscall

	j KetThuc

#--------------Tinh nam vua nhap la Can Chi gi ---------------
TinhCanChi:
	#Xuat chuoi Ket Qua
	li $v0,4
	la $a0,ketqua
	syscall

	#Goi ham Tinh Can Chi
	la $a0,time
	jal CanChi

	j KetThuc

#--------------Tinh khoang thoi gian giua time_1 va time_2 --------------
TinhKhoangTime:
	#Xuat thong bao nhap time2
	li $v0,4
	la $a0,nhaptime2
	syscall

	#Goi ham nhap time2
	la $a0,time2
	jal NhapTime

	#Goi ham tinh FullTime
	la $a0,time
	jal FullDate

	#Luu FullTime1 vao $t1
	move $t1,$v0

	#Goi ham tinh FullTime
	la $a0,time2
	jal FullDate

	#Luu FullTime2 vao $t2
	move $t2,$v0

	#Tinh khoang cach giua TIME1 va TIME2
	slt $t0,$t1,$t2
	beq $t0,$0,Time1Lon
	sub $t0,$t2,$t1
	j XuatKhoangCachTime
Time1Lon:
	sub $t0,$t1,$t2
XuatKhoangCachTime:
	#Xuat chuoi ket qua
	li $v0,4
	la $a0,ketqua
	syscall

	#Xuat khoang cach
	li $v0,1
	move $a0,$t0
	syscall

	j KetThuc

#-------------Cho biet 2 nam nhuan gan nhat voi nam trong chuoi time -------- 
HaiNamNhuanGan:
	#Goi ham NamNhuanGan
	la $a0,time
	jal NamNhuanGan

	j KetThuc

#------------Nh?p input t? file input.txt xu?t k?t qu? toàn b? các ch?c n?ng trên ra file output.txt------
NhapXuatInOut:
	#Goi ham nhap xuat file
	jal NhapXuatFile

	j KetThuc

#---------------------------------Cac ham dung trong main -------------------------------

#---------------------Ham nhap time--------------------------
NhapTime:
#Dau thu tuc
	addi $sp,$sp,-20 #Khai bao stack
	#Back up
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $s1,16($sp)

	#Lay dia chi luu tru chuoi time
	move $s1,$a0

#Nhap ngay
NhapNgay:
	#Thong bao nhap ngay
	li $v0,4
	la $a0,nhapngay
	syscall
	
	#Nhap ngay
	li $v0,5
	syscall
	sw $v0,day

	#Kiem tra Day
	#>=0
	lw $s0,day
	slti $t0,$s0,0
	bne $t0,$0,DaySai
	#<=31
	slti $t0,$s0,32
	beq $t0,$0,DaySai
	
	#luu vao time
	li $t0,10
	div $s0,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,($s1)
	sb $t1,1($s1)
	li $t0,47
	sb $t0,2($s1)

	j NhapThang

DaySai:
	#Xuat thông bao nhap sai
	li $v0,4
	la $a0,khonghople
	syscall
	j NhapNgay

#Nhap thang
NhapThang:
	#Thong bao nhap thang
	li $v0,4
	la $a0,nhapthang
	syscall
	
	#Nhap thang
	li $v0,5
	syscall
	sw $v0,month

	#Kiem tra Month
	#>=0
	lw $s0,month
	slti $t0,$s0,0
	bne $t0,$0,MonthSai
	#<=12
	slti $t0,$s0,13
	beq $t0,$0,MonthSai
	
	#luu vao time
	li $t0,10
	div $s0,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,3($s1)
	sb $t1,4($s1)
	li $t0,47
	sb $t0,5($s1)

	j NhapNam
MonthSai:
	#Xuat thong bao nhap sai
	li $v0,4
	la $a0,khonghople
	syscall
	j NhapThang

#Nhap nam
NhapNam:
	#Thong bao nhap nam
	li $v0,4
	la $a0,nhapnam
	syscall
	
	#Nhap nam
	li $v0,5
	syscall
	sw $v0,year

	#Kiem tra Year
	#>=0
	lw $s0,year
	slti $t0,$s0,0
	bne $t0,$0,YearSai
	
	#luu vao time
	li $t0,1000
	div $s0,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	sb $t0,6($s1)
	li $t0,100
	div $t1,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	sb $t0,7($s1)
	li $t0,10
	div $t1,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,8($s1)
	sb $t1,9($s1)

	j CheckAll
YearSai:
	#Xuat thong bao nhap sai
	li $v0,4
	la $a0,khonghople
	syscall
	j NhapNam
CheckAll:
	#Thang 30 ngay
	lw $t1,month
	beq $t1,4,XuLy30
	beq $t1,6,XuLy30
	beq $t1,9,XuLy30
	beq $t1,11,XuLy30
	beq $t1,2,KiemTraThang2

	j EndNhap
XuLy30:
	lw $t1,day
	slti $t0,$t1,31
	bne $t0,$0,KiemTraThang2
	
	#Xuat thong bao loi
	li $v0,4
	la $a0,khonghople
	syscall

	j NhapNgay

KiemTraThang2:
	#Kiem tra nhuan
	la $a0,time
	jal LeapYear	
	move $t0,$v0

	bne $t0,$0,KiemTraThang2_Nhuan
	#Khong nhuan
	lw $t1,day
	slti $t0,$t1,29
	bne $t0,$0,EndNhap

	#Xuat thong bao loi
	li $v0,4
	la $a0,khonghople
	syscall

	j NhapNgay

KiemTraThang2_Nhuan:
	lw $t1,day
	slti $t0,$t1,30
	bne $t0,$0,EndNhap

	#Xuat thong bao loi
	li $v0,4
	la $a0,khonghople
	syscall

	j NhapNgay
EndNhap:
	#restore data
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $s1,16($sp)

	 #Tra lai stack
	addi $sp,$sp,20

	#Ket qua tra ve
	move $a0,$s1
	
	jr $ra
#-----------------Cuoi thu tuc---------------

#---------------------ham xuat chuoi ngay thang nam----------------
#--------------Dau thu tuc -------------
Date:

#--------------Cuoi thu tuc ------------


#--------------Ham Convert---------------
#--------Dau thu tuc ------------
Convert:
	li $t0,65
	beq $a1,$t0,Convert_A
	li $t0,66
	beq $a1,$t0,Convert_B
	li $t0,67
	beq $a1,$t0,Convert_C
Convert_A: #MM/DD/YYYY
	addi $sp,$sp, -8
	sw $ra,($sp)
	sw $t0,4($sp)
	
	la $a2,convert_time
	lb $t0, 0($a0)
	sw $t0,3($a2)	#[covert_time[3]=D1
	lb $t0,1($a0)
	sw $t0,4($a2)	#[covert_time[4]=D2
	lb $t0,3($a0)
	sw $t0,0($a2)	#[covert_time[0]=M1
	lb $t0,4($a0)
	sw $t0,1($a2)	#[covert_time[1]=M2
	li $t0,47
	sw $t0,2($a2)	#[covert_time[2]=' '
	li $t0,47
	sw $t0,5($a2)	#[covert_time[5]=','
	lb $t0,6($a0)
	sw $t0,6($a2)	#[covert_time[7]=Y1
	lb $t0,7($a0)
	sw $t0,7($a2)	#[covert_time[8]=Y2
	lb $t0,8($a0)
	sw $t0,8($a2)	#[covert_time[9]=Y3
	lb $t0,9($a0)
	sw $t0,9($a2)	#[covert_time[10]=Y4
	
	move $v0,$a2
	
	lw $ra,($sp)
	lw $t0,4($sp)
	addi $sp,$sp, 8
	jr $ra

Convert_B: #MM DD,YYYY
	addi $sp,$sp, -8
	sw $ra,($sp)
	sw $t0,4($sp)
	
	la $a2,convert_time
	lb $t0, 0($a0)
	sw $t0,3($a2)	#[covert_time[3]=D1
	lb $t0,1($a0)
	sw $t0,4($a2)	#[covert_time[4]=D2
	lb $t0,3($a0)
	sw $t0,0($a2)	#[covert_time[0]=M1
	lb $t0,4($a0)
	sw $t0,1($a2)	#[covert_time[1]=M2
	li $t0,32
	sw $t0,2($a2)	#[covert_time[2]=' '
	li $t0,44
	sw $t0,5($a2)	#[covert_time[5]=','
	li $t0,32
	sw $t0,6($a2)	#[covert_time[6]=' '
	lb $t0,6($a0)
	sw $t0,7($a2)	#[covert_time[7]=Y1
	lb $t0,7($a0)
	sw $t0,8($a2)	#[covert_time[8]=Y2
	lb $t0,8($a0)
	sw $t0,9($a2)	#[covert_time[9]=Y3
	lb $t0,9($a0)
	sw $t0,10($a2)	#[covert_time[10]=Y4
	
	move $v0,$a2
	
	lw $ra,($sp)
	lw $t0,4($sp)
	addi $sp,$sp, 8
	jr $ra
	
Convert_C:
	addi $sp,$sp, -8
	sw $ra,($sp)
	sw $t0,4($sp)
	
	la $a2,convert_time
	lb $t0, 0($a0)
	sw $t0,0($a2)	#[covert_time[3]=D1
	lb $t0,1($a0)
	sw $t0,1($a2)	#[covert_time[4]=D2
	lb $t0,3($a0)
	sw $t0,3($a2)	#[covert_time[0]=M1
	lb $t0,4($a0)
	sw $t0,4($a2)	#[covert_time[1]=M2
	li $t0,32
	sw $t0,2($a2)	#[covert_time[2]=' '
	li $t0,44
	sw $t0,5($a2)	#[covert_time[5]=','
	li $t0,32
	sw $t0,6($a2)	#[covert_time[6]=' '
	lb $t0,6($a0)
	sw $t0,7($a2)	#[covert_time[7]=Y1
	lb $t0,7($a0)
	sw $t0,8($a2)	#[covert_time[8]=Y2
	lb $t0,8($a0)
	sw $t0,9($a2)	#[covert_time[9]=Y3
	lb $t0,9($a0)
	sw $t0,10($a2)	#[covert_time[10]=Y4
	
	move $v0,$a2
	
	lw $ra,($sp)
	lw $t0,4($sp)
	addi $sp,$sp, 8
	jr $ra
#-----------Cuoi thu tuc---------

#----------------------------Ham tra ve ngay ----------------
#--------dau thu tuc ----------
Day:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	lb $t0, 0($a0)
	addi $t0, $t0, -48
	li $t1, 10
	mult $t0, $t1
	mflo $t0
	lb  $t1, 1($a0)
	addi $t1, $t1, -48
	add $t0, $t0, $t1
	move $v0, $t0
	
	lw $ra, 8($sp)
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 12
	jr $ra
#----------------- Cuoi thu tuc ----------

#----------------------------------------Ham tra ve thang -------------------
Month:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, 3($a0)
	jal Day
	move $v0, $v0

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

#---------------------------------- Ham tra ve nam ----------------------
#---------------Dau thu tuc ----------
Year:
	addi  $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	la $a0, 6($a0)
	jal Day
	move $t0, $v0
	
	li $t1, 100
	mult $t0, $t1
	mflo $t0

	la $a0, 2($a0)
	jal Day
	add $t0, $t0, $v0

	move $v0, $t0

	lw $ra, 8($sp)
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra
#----------------Cuoi thu tuc -------------

#--------------------------Ham kiem tra nam nhuan --------------------------
#--------Dau thu tuc ------------
LeapYear:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)
		
	jal Year
	move $t0, $v0
	
	li $t1, 400
	div $t0, $t1
	mfhi $t1
	beq $t1, $0, true	# nam chia het cho 100
	
	li $t1, 4
	div $t0, $t1
	mfhi $t1
	bne  $t1, $0, false	# nam khong chia het cho 4	
	
	li $t1, 100
	div $t0, $t1
	mfhi $t1
	beq $t1, $0, false	# nam chia het cho 4 va khong chia het cho 100
	
	
true:
	li $v0, 1
	j break
false:
	li $v0, 0
	j break
break:
	
	lw $ra, 8($sp)
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	
	addi $sp, $sp, 12

	jr $ra

#-----------------Cuoi thu tuc---------------

#---------------------------------ham GetTime ------------------
#------------------Dau thu tuc ---------
GetTime:
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $t0, 8($sp)
	sw $t1, 4($sp)
	sw $t2, 0($sp)

	jal Year
	move $t0, $v0

	la $a0, ($a1)
	jal Year
	move $t1, $v0

	sub $v0, $t1, $t0

	slt $t0, $v0, $0
	beq $t0, $0, EOG
	li $t0, -1
	mult $v0, $t0
	mflo $v0
EOG:
	
	lw $ra, 12($sp)
	lw $t0, 8($sp)
	lw $t1, 4($sp)
	lw $t2, 0($sp)

	addi $sp, $sp, 16

	jr $ra
#----------------Cuoi thu tuc ---------

#-----------------------------Ham WeekDay -------------------
#----------Dau thu tuc ----------
WeekDay:
	addi $sp, $sp, -32
	sw $ra, 28($sp)
	sw $a0, 24($sp)
	sw $t0, 20($sp)
	sw $t1, 16($sp)
	sw $t2, 12($sp)
	sw $t3, 8($sp)
	sw $t4, 4($sp)
	sw $s0, 0($sp)
	
	
	jal Year
	move $t2, $v0

	lw $a0, 24($sp)
	jal Day
	move $t0, $v0
	
	lw $a0, 24($sp)
	jal Month
	move $t1, $v0

	li $t3, 3
	slt $t3, $t1, $t3
	beq $t3, $0, congthuc
	addi $t1, $t1, 12
	addi $t2, $t2, -1
	j 	congthuc
congthuc:
	move $s0, $t0	# $s0 = ngay
	
	li $t4, 2
	mult $t1, $t4	# thang * 2
	mflo $t0		# $t0 = thang * 2

	add $s0, $s0, $t0	# $s0 = ngay + 2* thang

	addi $t1, $t1, 1	# $t1 = thang + 1

	li $t4, 3		
	mult $t1, $t4	# (thang + 1) * 3
	mflo $t1		# $t1 = (thang + 1) * 3

	li $t4, 5
	div $t1, $t4	# ((thang + 1) * 3) div 5
	mflo $t1		# $t1 = ((thang + 1) * 3) div 5

	add $s0, $s0, $t1  	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5
	
	add $s0, $s0, $t2	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5 + nam
	li $t4, 4
	div $t2, $t4	# nam div 4
	mflo $t2	# $t2 = nam div 4
	
	add $s0, $s0, $t2 	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5 + nam + nam div 4

	li $t4, 7
	div $s0, $t4
	mfhi $s0	# $s0 = (ngay + 2* thang + ((thang + 1) * 3) div 5 + nam + nam div 4) mod 7

	sll $s0, $s0, 2
	la $t0, daysOfWeek
	add $t0, $t0, $s0
	lw $t0, ($t0)
	jr $t0

cn:	
	la $v0, sun
	j  EOW
t2:
	la $v0, mon
	j EOW
t3:
	la $v0, tue
	j EOW
t4:
	la $v0, wed
	j EOW
t5:
	la $v0, thu
	j EOW
t6:
	la $v0, fri
	j EOW
t7:
	la $v0, sat
	j EOW
EOW:
	lw $ra, 28($sp)
	lw $a0, 24($sp)
	lw $t0, 20($sp)
	lw $t1, 16($sp)
	lw $t2, 12($sp)
	lw $t3, 8($sp)
	lw $t4, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 32
	
	jr $ra
#----------Cuoi thu tuc ----------


#----------Ham FullDate -----------
#------Dau thu tuc -----------
FullDate:# su dung cong thuc year*365+year/4-year/100+year/400+(153*month - 457)/5 + day -306
	addi 	$sp, $sp, -28
	sw	$a0, 24($sp)
	sw	$ra, 20($sp)
	sw	$t0, 16($sp)	#bien ngay
	sw	$t1, 12($sp)	#bien thang
	sw	$t2, 8($sp)	#bien nam
	sw	$t3, 4($sp)	#bien tam
	sw	$s0, 0($sp) #bien ket qua
	
	jal	Day
	move	$t0, $v0

	jal	Month
	move	$t1, $v0

	lw	$a0, 24($sp)
	jal	Year
	move	$t2, $v0

	
	move	$s0, $t2	# $s0 = year
	
	li	$t3, 365
	mult	$s0, $t3
	mflo	$s0		# $s0 = year*365

	li	$t3, 4
	div	$t2, $t3
	mflo	$t3		# $t3 = year/4
	
	add	$s0, $s0, $t3	# $s0 = year*365+year/4
	
	li	$t3, -100
	div	$t2, $t3
	mflo	$t3		# $t3 = -year/100
	
	add	$s0, $s0, $t3	# $s0 = year*365+year/4-year/100

	li	$t3, 400
	div	$t2, $t3
	mflo	$t3		# $t3 = year/400
	
	add	$s0, $s0, $t3	# $s0 = year*365+year/4-year/100+year/400
	
	li	$t3, 153
	mult	$t1, $t3
	mflo	$t1 		# $t1 = 153*month
	addi	$t1, $t1, -457	# $t1 = 153*month - 457

	li	$t3, 5
	div	$t1, $t3
	mflo	$t1		# $t1 = (153*month - 457)/5

	add	$s0, $s0, $t1	# $s0 = year*365+year/4-year/100+year/400+(153*month - 457)/5
	add	$s0, $s0, $t0	# $s0 = year*365+year/4-year/100+year/400+(153*month - 457)/5 + day

	addi 	$s0, $s0, -306	# $s0 = year*365+year/4-year/100+year/400+(153*month - 457)/5 + day

	move	$v0, $s0
	
	#tra lai stack
	lw	$a0, 24($sp)
	lw	$ra, 20($sp)
	lw	$t0, 16($sp)
	lw	$t1, 12($sp)
	lw	$t2, 8($sp)
	lw	$t3, 4($sp)
	lw	$s0, 0($sp)
	
	addi 	$sp, $sp, 28

	jr	$ra
#------Cuoi thu tuc ---------

#-------------Ham NamNhuanGan ---------
#--------Dau thu tuc -------
NamNhuanGan:
	# keu goi luu vao stack $v0 $v1 lan luot la 4($sp) va 0 $(sp)
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $a0, 8($sp)

	# 4$sp va 0$sp de luu 2 nam xuat	

	jal Year #lay nam 
	addi $v0, $v0, 1 #bat dau chay i , i ban dau = year+1
	sw $v0, 4($sp)		# luu i vao
NamNhuanGanLoop:
	lw $a0, 4($sp)		# lay i
	jal LeapYear #kiem tra nhuan khong
	bne $v0, $zero, NamNhuanGanNhuan #neu la nam nhuan thi nhay den vong lap tiep

	lw $t0, 4($sp)	# khong nhuan thi load tu sp4 vao t0 va tro lai vong lap
	addi $t0, $t0, 1	# i++
	sw $t0, 4($sp)		# luu i vao
	j NamNhuanGanLoop
NamNhuanGanNhuan:
	lw $a0, 4($sp)		# lay i
	addi $a0, $a0, 4	# i += 4 (nam nhuan thu 2 = nam nhuan thu 1 + 4
	sw $a0, 0($sp) #luu nam nhuan thu 2 vao
	jal LeapYear	#kiem tra co nhuan khong
	bne $v0, $zero, NamNhuanGanExit

NamNhuanGanExit:
	# tra stack stack
	lw $ra, 12($sp)
	lw $v0, 4($sp)
	lw $v1, 0($sp)
	addi $sp, $sp, 16
	jr $ra
#-----------Cuoi thu tuc--------

#------------Ham CanChi ----------
#--------Dau thu tuc -------
CanChi:
CAN:
	addi $sp, $sp, -16
	sw $ra, 12($sp)

	jal Year
	sw $v0, 8($sp)		# save Year(TIME)
  
	lw $a0, 8($sp)		# get Year(TIME)
  
	addi $t0, $zero, 10 	# Gan bien tam t0 = 10
	
	addi $v0,$v0,6		#Year=Year+6
	div $v0, $t0		
	mfhi $v0		# $v0 = (Year +6) mod 10

CAN_NEXT:
	addi $t0, $zero,9	
	bne $v0, $t0, CAN_Giap
	la $v0, Quy
	j CAN_end
CAN_Giap:
	addi $t0, $zero,0	
	bne $v0, $t0, CAN_At
	la $v0, Giap
	j CAN_end
CAN_At:
	addi $t0, $zero,1	
	bne $v0, $t0, CAN_Binh
	la $v0, At
	j CAN_end
CAN_Binh:
	addi $t0, $zero,2	
	bne $v0, $t0, CAN_Dinh
	la $v0, Binh
	j CAN_end
CAN_Dinh:
	addi $t0, $zero,3	
	bne $v0, $t0, CAN_Mau
	la $v0, Dinh
	j CAN_end
CAN_Mau:
	addi $t0, $zero,4	
	bne $v0, $t0, CAN_Ky
	la $v0, Mau
	j CAN_end
CAN_Ky:
	addi $t0, $zero,5	
	bne $v0, $t0, CAN_Canh
	la $v0, Ky
	j CAN_end
CAN_Canh:
	addi $t0, $zero,6	
	bne $v0, $t0, CAN_Tan
	la $v0, Canh
	j CAN_end
CAN_Tan:
	addi $t0, $zero,7	
	bne $v0, $t0, CAN_Nham
	la $v0, Tan
	j CAN_end
CAN_Nham:
	addi $t0, $zero,8	
	bne $v0, $t0, CAN_Tan
	la $v0, Nham
	j CAN_end
Nham_Quy:
	la $v0, Quy 
CAN_end:
 	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra	
#---------------------------------------------------
CHI:
	addi $sp, $sp, -16
	sw $ra, 12($sp)

	jal Year
	sw $v0, 8($sp)		# save Year(TIME)

	lw $a0, 8($sp)		# get Year(TIME)

	addi $t0, $zero, 12 	# Gan bien tam t0 = 12
	
	addi $v0,$v0,8		#Year=Year+8
	div $v0, $t0		
	mfhi $v0		# $v0 = (Year +8) mod 12
CHI_NEXT:
	addi $t0, $zero,11	
	bne $v0, $t0, CHI_ti
	la $v0, Hoi
	j CHI_end
CHI_ti:
	addi $t0, $zero,0	
	bne $v0, $t0, CHI_suu
	la $v0, Ti
	j CAN_end
CHI_suu:
	addi $t0, $zero,1	
	bne $v0, $t0, CHI_dan
	la $v0, Suu
	j CHI_end
CHI_dan:
	addi $t0, $zero,2	
	bne $v0, $t0, CHI_meo
	la $v0, Dan
	j CHI_end
CHI_meo:
	addi $t0, $zero,3	
	bne $v0, $t0, CHI_thin
	la $v0, Meo
	j CHI_end
CHI_thin:
	addi $t0, $zero,4	
	bne $v0, $t0, CHI_ty
	la $v0, Thin
	j CHI_end
CHI_ty:
	addi $t0, $zero,5	
	bne $v0, $t0, CHI_ngo
	la $v0, Ty
	j CHI_end
CHI_ngo:
	addi $t0, $zero,6	
	bne $v0, $t0, CHI_mui
	la $v0, Ngo
	j CHI_end
CHI_mui:
	addi $t0, $zero,7	
	bne $v0, $t0, CHI_than
	la $v0, Mui
	j CHI_end
CHI_than:
	addi $t0, $zero,8	
	bne $v0, $t0, CHI_dau
	la $v0, Than
	j CHI_end
CHI_dau:
	addi $t0, $zero,8	
	bne $v0, $t0, CHI_tuat
	la $v0, Nham
	j CHI_end
CHI_tuat:
	la $v0, Tuat
	j CHI_end

CHI_end:
 	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra
#-------Cuoi thu tuc --------

#---------------------Ham NhapXuatFile ---------------------
#------------ Dau thu tuc ---------
NhapXuatFile:
	jr $ra
#----------- Cuoi thu tuc ---------


#KetThuc
KetThuc:
