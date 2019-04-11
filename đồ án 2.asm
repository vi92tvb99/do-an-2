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
	li $v0,4
	move $a0,$s1
	syscall

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

#-------------Ham kiem tra nam nhuan -------------
#--------Dau thu tuc ------------
LeapYear:
	li $v0,0
	jr $ra

#-----------------Cuoi thu tuc---------------

#--------------Ham Convert---------------
#--------Dau thu tuc ------------
Convert:
	move $v0,$a0
	jr $ra
#-----------Cuoi thu tuc---------

#------------------Ham WeekDay -------------
#----------Dau thu tuc ----------
WeekDay:
	la $v0,monday
	jr $ra
#----------Cuoi thu tuc ----------


#----------Ham FullDate -----------
#------Dau thu tuc -----------
FullDate:
	li $v0,100
	jr $ra
#------Cuoi thu tuc ---------

#------------Ham CanChi ----------
#--------Dau thu tuc -------
CanChi:
	li $v0,4
	la $a0,kihoi
	syscall
	jr $ra
#-------Cuoi thu tuc --------

#-------------Ham NamNhuanGan ---------
#--------Dau thu tuc -------
NamNhuanGan:
	jr $ra
#-----------Cuoi thu tuc--------

#---------------------Ham NhapXuatFile ---------------------
#------------ Dau thu tuc ---------
NhapXuatFile:
	jr $ra
#----------- Cuoi thu tuc ---------


#KetThuc
KetThuc:
