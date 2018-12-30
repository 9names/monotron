EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title "Monotron 32K"
Date "2018-12-29"
Rev "0.0.1"
Comp "https://github.com/thejpster/monotron"
Comment1 "Copyright (c) Jonathan 'theJPster' Pallant 2018"
Comment2 "CC BY-SA 4.0"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:+3.3V #PWR07
U 1 1 5C27D05D
P 1900 6400
F 0 "#PWR07" H 1900 6250 50  0001 C CNN
F 1 "+3.3V" H 1915 6573 50  0000 C CNN
F 2 "" H 1900 6400 50  0001 C CNN
F 3 "" H 1900 6400 50  0001 C CNN
	1    1900 6400
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR01
U 1 1 5C27D0AC
P 800 6450
F 0 "#PWR01" H 800 6300 50  0001 C CNN
F 1 "+5V" H 815 6623 50  0000 C CNN
F 2 "" H 800 6450 50  0001 C CNN
F 3 "" H 800 6450 50  0001 C CNN
	1    800  6450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5C27D110
P 1350 7400
F 0 "#PWR04" H 1350 7150 50  0001 C CNN
F 1 "GND" H 1355 7227 50  0000 C CNN
F 2 "" H 1350 7400 50  0001 C CNN
F 3 "" H 1350 7400 50  0001 C CNN
	1    1350 7400
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:TPS73633DBV U1
U 1 1 5C27DCBE
P 1350 6850
F 0 "U1" H 1350 7192 50  0000 C CNN
F 1 "TPS73633DBV" H 1350 7101 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 1350 7175 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/tps736.pdf" H 1350 6800 50  0001 C CNN
	1    1350 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  6750 800  6750
Wire Wire Line
	800  6750 800  6450
Wire Wire Line
	950  6850 800  6850
Wire Wire Line
	800  6850 800  6750
Connection ~ 800  6750
Wire Wire Line
	1350 7150 1350 7350
Wire Wire Line
	1900 6400 1900 6750
Wire Wire Line
	1900 6750 1750 6750
$Comp
L Device:C C1
U 1 1 5C27E14A
P 800 7150
F 0 "C1" H 915 7196 50  0000 L CNN
F 1 "1.0u" H 915 7105 50  0000 L CNN
F 2 "" H 838 7000 50  0001 C CNN
F 3 "~" H 800 7150 50  0001 C CNN
	1    800  7150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5C27E1A5
P 1850 7150
F 0 "C3" H 1965 7196 50  0000 L CNN
F 1 "0.01u" H 1965 7105 50  0000 L CNN
F 2 "" H 1888 7000 50  0001 C CNN
F 3 "~" H 1850 7150 50  0001 C CNN
	1    1850 7150
	1    0    0    -1  
$EndComp
Wire Wire Line
	800  7000 800  6850
Connection ~ 800  6850
Wire Wire Line
	800  7300 800  7350
Wire Wire Line
	800  7350 1350 7350
Connection ~ 1350 7350
Wire Wire Line
	1350 7350 1350 7400
Wire Wire Line
	1750 6850 1850 6850
Wire Wire Line
	1850 6850 1850 7000
Wire Wire Line
	1350 7350 1850 7350
Wire Wire Line
	1850 7350 1850 7300
$Comp
L power:GND #PWR014
U 1 1 5C27F4D6
P 4800 6250
F 0 "#PWR014" H 4800 6000 50  0001 C CNN
F 1 "GND" H 4805 6077 50  0000 C CNN
F 2 "" H 4800 6250 50  0001 C CNN
F 3 "" H 4800 6250 50  0001 C CNN
	1    4800 6250
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal Y1
U 1 1 5C28050B
P 2900 3700
F 0 "Y1" V 2854 3831 50  0000 L CNN
F 1 "16MHz" V 2945 3831 50  0000 L CNN
F 2 "" H 2900 3700 50  0001 C CNN
F 3 "~" H 2900 3700 50  0001 C CNN
	1    2900 3700
	0    1    1    0   
$EndComp
Wire Wire Line
	4800 5800 4800 5950
Wire Wire Line
	4900 5800 4900 5950
Wire Wire Line
	4900 5950 4800 5950
Wire Wire Line
	5000 5800 5000 5950
Wire Wire Line
	5000 5950 4900 5950
Connection ~ 4900 5950
Wire Wire Line
	5100 5800 5100 5950
Wire Wire Line
	5100 5950 5000 5950
Connection ~ 5000 5950
Wire Wire Line
	5300 5800 5300 5950
Wire Wire Line
	5300 5950 5100 5950
Connection ~ 5100 5950
Wire Wire Line
	2900 3550 2900 3500
Wire Wire Line
	2900 3500 3350 3500
Wire Wire Line
	3350 3500 3350 3600
Wire Wire Line
	3350 3600 3600 3600
Wire Wire Line
	3600 3800 3350 3800
Wire Wire Line
	3350 3800 3350 3900
Wire Wire Line
	3350 3900 2900 3900
Wire Wire Line
	2900 3900 2900 3850
$Comp
L power:GND #PWR08
U 1 1 5C283826
P 2250 4100
F 0 "#PWR08" H 2250 3850 50  0001 C CNN
F 1 "GND" H 2255 3927 50  0000 C CNN
F 2 "" H 2250 4100 50  0001 C CNN
F 3 "" H 2250 4100 50  0001 C CNN
	1    2250 4100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5C28386C
P 2500 3500
F 0 "C4" V 2350 3500 50  0000 C CNN
F 1 "10p" V 2650 3500 50  0000 C CNN
F 2 "" H 2538 3350 50  0001 C CNN
F 3 "~" H 2500 3500 50  0001 C CNN
	1    2500 3500
	0    1    1    0   
$EndComp
$Comp
L Device:C C5
U 1 1 5C283CFE
P 2500 3900
F 0 "C5" V 2350 3900 50  0000 C CNN
F 1 "10p" V 2650 3900 50  0000 C CNN
F 2 "" H 2538 3750 50  0001 C CNN
F 3 "~" H 2500 3900 50  0001 C CNN
	1    2500 3900
	0    1    1    0   
$EndComp
Wire Wire Line
	2250 3900 2250 4100
Wire Wire Line
	2250 3500 2250 3900
Connection ~ 2250 3900
$Comp
L Device:Crystal Y2
U 1 1 5C285D00
P 2950 4600
F 0 "Y2" V 2904 4731 50  0000 L CNN
F 1 "32kHz" V 2995 4731 50  0000 L CNN
F 2 "" H 2950 4600 50  0001 C CNN
F 3 "~" H 2950 4600 50  0001 C CNN
	1    2950 4600
	0    1    1    0   
$EndComp
$Comp
L Device:C C7
U 1 1 5C285D46
P 2650 4800
F 0 "C7" V 2500 4800 50  0000 C CNN
F 1 "24p" V 2800 4800 50  0000 C CNN
F 2 "" H 2688 4650 50  0001 C CNN
F 3 "~" H 2650 4800 50  0001 C CNN
	1    2650 4800
	0    1    1    0   
$EndComp
Wire Wire Line
	4800 5950 4800 6250
Connection ~ 4800 5950
$Comp
L Device:C C6
U 1 1 5C2864E4
P 2650 4350
F 0 "C6" V 2500 4350 50  0000 C CNN
F 1 "24p" V 2800 4350 50  0000 C CNN
F 2 "" H 2688 4200 50  0001 C CNN
F 3 "~" H 2650 4350 50  0001 C CNN
	1    2650 4350
	0    1    1    0   
$EndComp
Wire Wire Line
	4600 5800 4600 5950
Wire Wire Line
	4600 5950 2350 5950
Wire Wire Line
	2500 4350 2350 4350
Wire Wire Line
	2800 4350 2950 4350
Wire Wire Line
	2950 4350 2950 4450
Wire Wire Line
	3600 4500 3350 4500
Wire Wire Line
	3350 4500 3350 4350
Wire Wire Line
	3350 4350 2950 4350
Connection ~ 2950 4350
Wire Wire Line
	3600 4700 3350 4700
Wire Wire Line
	3350 4700 3350 4800
Wire Wire Line
	2950 4800 2950 4750
Wire Wire Line
	2350 4350 2350 4800
Wire Wire Line
	2500 4800 2350 4800
Connection ~ 2350 4800
Wire Wire Line
	2350 4800 2350 5950
Wire Wire Line
	2800 4800 2950 4800
Connection ~ 2950 4800
Wire Wire Line
	2950 4800 3350 4800
Wire Wire Line
	2250 3500 2350 3500
Wire Wire Line
	2250 3900 2350 3900
Connection ~ 2900 3900
Wire Wire Line
	2650 3900 2900 3900
Wire Wire Line
	2650 3500 2900 3500
Connection ~ 2900 3500
Wire Wire Line
	3600 4100 3600 4050
Text Label 3400 4200 0    50   ~ 0
~HIB
Text Label 3400 4050 0    50   ~ 0
~WAKE
Wire Wire Line
	3400 4200 3600 4200
Wire Wire Line
	3400 4050 3600 4050
$Comp
L power:+3.3V #PWR011
U 1 1 5C297C72
P 3250 5200
F 0 "#PWR011" H 3250 5050 50  0001 C CNN
F 1 "+3.3V" H 3265 5373 50  0000 C CNN
F 2 "" H 3250 5200 50  0001 C CNN
F 3 "" H 3250 5200 50  0001 C CNN
	1    3250 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 5000 3500 5000
Wire Wire Line
	3500 5000 3500 5350
Wire Wire Line
	3500 5350 3250 5350
Wire Wire Line
	3250 5350 3250 5200
$Comp
L power:GND #PWR012
U 1 1 5C2990D3
P 3500 1550
F 0 "#PWR012" H 3500 1300 50  0001 C CNN
F 1 "GND" H 3505 1377 50  0000 C CNN
F 2 "" H 3500 1550 50  0001 C CNN
F 3 "" H 3500 1550 50  0001 C CNN
	1    3500 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C11
U 1 1 5C299135
P 4400 1300
F 0 "C11" H 4350 1200 50  0000 R CNN
F 1 "2.2u" H 4350 1400 50  0000 R CNN
F 2 "" H 4438 1150 50  0001 C CNN
F 3 "~" H 4400 1300 50  0001 C CNN
	1    4400 1300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C10
U 1 1 5C299212
P 4100 1300
F 0 "C10" H 4050 1200 50  0000 R CNN
F 1 "1.0u" H 4050 1400 50  0000 R CNN
F 2 "" H 4138 1150 50  0001 C CNN
F 3 "~" H 4100 1300 50  0001 C CNN
	1    4100 1300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C9
U 1 1 5C29924A
P 3800 1300
F 0 "C9" H 3750 1200 50  0000 R CNN
F 1 "100n" H 3750 1400 50  0000 R CNN
F 2 "" H 3838 1150 50  0001 C CNN
F 3 "~" H 3800 1300 50  0001 C CNN
	1    3800 1300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C8
U 1 1 5C299280
P 3500 1300
F 0 "C8" H 3450 1200 50  0000 R CNN
F 1 "100n" H 3450 1400 50  0000 R CNN
F 2 "" H 3538 1150 50  0001 C CNN
F 3 "~" H 3500 1300 50  0001 C CNN
	1    3500 1300
	-1   0    0    1   
$EndComp
Wire Wire Line
	3500 1500 3500 1450
Wire Wire Line
	3500 1500 3800 1500
Wire Wire Line
	3800 1500 3800 1450
Wire Wire Line
	3800 1500 4100 1500
Wire Wire Line
	4100 1500 4100 1450
Connection ~ 3800 1500
Wire Wire Line
	4100 1500 4400 1500
Wire Wire Line
	4400 1500 4400 1450
Connection ~ 4100 1500
Wire Wire Line
	3500 1150 3500 1100
Wire Wire Line
	3500 1100 3800 1100
Wire Wire Line
	3800 1100 3800 1150
Wire Wire Line
	3800 1100 4100 1100
Wire Wire Line
	4100 1100 4100 1150
Connection ~ 3800 1100
Wire Wire Line
	4100 1100 4400 1100
Wire Wire Line
	4400 1100 4400 1150
Connection ~ 4100 1100
Wire Wire Line
	4400 1100 4700 1100
Wire Wire Line
	4700 1100 4700 1500
Connection ~ 4400 1100
Wire Wire Line
	4600 1600 4600 1500
Wire Wire Line
	4600 1500 4700 1500
Connection ~ 4700 1500
Wire Wire Line
	4700 1500 4700 1600
$Comp
L Device:C C12
U 1 1 5C2A4521
P 5500 1300
F 0 "C12" H 5450 1200 50  0000 R CNN
F 1 "10n" H 5450 1400 50  0000 R CNN
F 2 "" H 5538 1150 50  0001 C CNN
F 3 "~" H 5500 1300 50  0001 C CNN
	1    5500 1300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C13
U 1 1 5C2A45BD
P 5800 1300
F 0 "C13" H 5750 1200 50  0000 R CNN
F 1 "100n" H 5750 1400 50  0000 R CNN
F 2 "" H 5838 1150 50  0001 C CNN
F 3 "~" H 5800 1300 50  0001 C CNN
	1    5800 1300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C14
U 1 1 5C2A45F9
P 6100 1300
F 0 "C14" H 6050 1200 50  0000 R CNN
F 1 "10n" H 6050 1400 50  0000 R CNN
F 2 "" H 6138 1150 50  0001 C CNN
F 3 "~" H 6100 1300 50  0001 C CNN
	1    6100 1300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C15
U 1 1 5C2A4B83
P 6400 1300
F 0 "C15" H 6350 1200 50  0000 R CNN
F 1 "100n" H 6350 1400 50  0000 R CNN
F 2 "" H 6438 1150 50  0001 C CNN
F 3 "~" H 6400 1300 50  0001 C CNN
	1    6400 1300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C16
U 1 1 5C2A4BBF
P 6700 1300
F 0 "C16" H 6650 1200 50  0000 R CNN
F 1 "10n" H 6650 1400 50  0000 R CNN
F 2 "" H 6738 1150 50  0001 C CNN
F 3 "~" H 6700 1300 50  0001 C CNN
	1    6700 1300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C17
U 1 1 5C2A4C05
P 7000 1300
F 0 "C17" H 6950 1200 50  0000 R CNN
F 1 "1.0u" H 6950 1400 50  0000 R CNN
F 2 "" H 7038 1150 50  0001 C CNN
F 3 "~" H 7000 1300 50  0001 C CNN
	1    7000 1300
	-1   0    0    1   
$EndComp
Wire Wire Line
	4900 1600 4900 1500
Wire Wire Line
	4900 1100 5500 1100
Wire Wire Line
	5500 1100 5500 1150
Wire Wire Line
	5500 1100 5800 1100
Wire Wire Line
	5800 1100 5800 1150
Connection ~ 5500 1100
Wire Wire Line
	5800 1100 6100 1100
Wire Wire Line
	6100 1100 6100 1150
Connection ~ 5800 1100
Wire Wire Line
	6100 1100 6400 1100
Wire Wire Line
	6400 1100 6400 1150
Connection ~ 6100 1100
Wire Wire Line
	6400 1100 6700 1100
Wire Wire Line
	6700 1100 6700 1150
Connection ~ 6400 1100
Wire Wire Line
	6700 1100 7000 1100
Wire Wire Line
	7000 1100 7000 1150
Connection ~ 6700 1100
Wire Wire Line
	5500 1450 5500 1500
Wire Wire Line
	5500 1500 5800 1500
Wire Wire Line
	5800 1500 5800 1450
Wire Wire Line
	5800 1500 6100 1500
Wire Wire Line
	6100 1500 6100 1450
Connection ~ 5800 1500
Wire Wire Line
	6100 1500 6400 1500
Wire Wire Line
	6400 1500 6400 1450
Connection ~ 6100 1500
Wire Wire Line
	6400 1500 6700 1500
Wire Wire Line
	6700 1500 6700 1450
Connection ~ 6400 1500
Wire Wire Line
	6700 1500 7000 1500
Wire Wire Line
	7000 1500 7000 1450
Connection ~ 6700 1500
Wire Wire Line
	7000 1500 7300 1500
Wire Wire Line
	7300 1500 7300 1550
Connection ~ 7000 1500
$Comp
L power:GND #PWR017
U 1 1 5C2C086E
P 7300 1550
F 0 "#PWR017" H 7300 1300 50  0001 C CNN
F 1 "GND" H 7305 1377 50  0000 C CNN
F 2 "" H 7300 1550 50  0001 C CNN
F 3 "" H 7300 1550 50  0001 C CNN
	1    7300 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 1600 5000 1500
Wire Wire Line
	5000 1500 4900 1500
Connection ~ 4900 1500
Wire Wire Line
	4900 1500 4900 1100
Wire Wire Line
	5000 1500 5100 1500
Wire Wire Line
	5100 1500 5100 1600
Connection ~ 5000 1500
Wire Wire Line
	5100 1500 5200 1500
Wire Wire Line
	5200 1500 5200 1600
Connection ~ 5100 1500
Wire Wire Line
	5200 1500 5400 1500
Wire Wire Line
	5400 1500 5400 1600
Connection ~ 5200 1500
$Comp
L power:+3.3V #PWR015
U 1 1 5C2CB8E6
P 4900 950
F 0 "#PWR015" H 4900 800 50  0001 C CNN
F 1 "+3.3V" H 4915 1123 50  0000 C CNN
F 2 "" H 4900 950 50  0001 C CNN
F 3 "" H 4900 950 50  0001 C CNN
	1    4900 950 
	1    0    0    -1  
$EndComp
$Comp
L power:+1V2 #PWR013
U 1 1 5C2CB9E3
P 4700 850
F 0 "#PWR013" H 4700 700 50  0001 C CNN
F 1 "+1V2" H 4700 1000 50  0000 C CNN
F 2 "" H 4700 850 50  0001 C CNN
F 3 "" H 4700 850 50  0001 C CNN
	1    4700 850 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 950  4900 1100
Connection ~ 4900 1100
Connection ~ 4700 1100
Wire Wire Line
	4700 850  4700 1100
$Comp
L power:+5V #PWR06
U 1 1 5C2DBC6A
P 1550 4950
F 0 "#PWR06" H 1550 4800 50  0001 C CNN
F 1 "+5V" H 1565 5123 50  0000 C CNN
F 2 "" H 1550 4950 50  0001 C CNN
F 3 "" H 1550 4950 50  0001 C CNN
	1    1550 4950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5C2DBD0A
P 950 5850
F 0 "#PWR03" H 950 5600 50  0001 C CNN
F 1 "GND" H 955 5677 50  0000 C CNN
F 2 "" H 950 5850 50  0001 C CNN
F 3 "" H 950 5850 50  0001 C CNN
	1    950  5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  5700 950  5750
$Comp
L Device:C C2
U 1 1 5C2E6794
P 1550 5350
F 0 "C2" H 1665 5396 50  0000 L CNN
F 1 "47u" H 1665 5305 50  0000 L CNN
F 2 "" H 1588 5200 50  0001 C CNN
F 3 "~" H 1550 5350 50  0001 C CNN
	1    1550 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  5750 1550 5750
Wire Wire Line
	1550 5750 1550 5500
Wire Wire Line
	1550 5200 1550 5100
Wire Wire Line
	1250 5100 1550 5100
Wire Wire Line
	1550 4950 1550 5100
Connection ~ 1550 5100
Text Notes 650  4800 0    50   ~ 0
Power Input
NoConn ~ 1350 5500
NoConn ~ 1350 5400
NoConn ~ 1350 5300
Wire Wire Line
	1250 5300 1350 5300
Wire Wire Line
	1250 5400 1350 5400
Wire Wire Line
	1250 5500 1350 5500
$Comp
L Connector:USB_A J1
U 1 1 5C30D332
P 950 3900
F 0 "J1" H 700 4300 50  0000 C CNN
F 1 "USB_A" H 900 4300 50  0000 C CNN
F 2 "" H 1100 3850 50  0001 C CNN
F 3 " ~" H 1100 3850 50  0001 C CNN
	1    950  3900
	1    0    0    -1  
$EndComp
Text Notes 650  3400 0    50   ~ 0
USB Host Port
$Comp
L power:+5V #PWR05
U 1 1 5C31E1F9
P 1550 3600
F 0 "#PWR05" H 1550 3450 50  0001 C CNN
F 1 "+5V" H 1565 3773 50  0000 C CNN
F 2 "" H 1550 3600 50  0001 C CNN
F 3 "" H 1550 3600 50  0001 C CNN
	1    1550 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 3700 1550 3700
Wire Wire Line
	1550 3700 1550 3600
$Comp
L power:GND #PWR02
U 1 1 5C322833
P 850 4400
F 0 "#PWR02" H 850 4150 50  0001 C CNN
F 1 "GND" H 855 4227 50  0000 C CNN
F 2 "" H 850 4400 50  0001 C CNN
F 3 "" H 850 4400 50  0001 C CNN
	1    850  4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	850  4300 850  4350
Wire Wire Line
	950  4300 950  4350
Wire Wire Line
	950  4350 850  4350
Connection ~ 850  4350
Wire Wire Line
	850  4350 850  4400
Wire Wire Line
	1250 3900 1700 3900
Wire Wire Line
	1250 4000 1700 4000
Text Label 1350 3900 0    50   ~ 0
PD5_USB_DP
Text Label 1350 4000 0    50   ~ 0
PD4_USB_DM
Text Label 6500 5100 0    50   ~ 0
PD5_USB_DP
$Comp
L Connector:DB9_Male J4
U 1 1 5C348A1D
P 5700 7050
F 0 "J4" H 5880 7096 50  0000 L CNN
F 1 "DB9_Male" H 5880 7005 50  0000 L CNN
F 2 "" H 5700 7050 50  0001 C CNN
F 3 " ~" H 5700 7050 50  0001 C CNN
	1    5700 7050
	1    0    0    -1  
$EndComp
$Comp
L Connector:SD_Card J3
U 1 1 5C348AF3
P 1550 1100
F 0 "J3" H 1550 1765 50  0000 C CNN
F 1 "SD_Card" H 1550 1674 50  0000 C CNN
F 2 "" H 1550 1100 50  0001 C CNN
F 3 "http://portal.fciconnect.com/Comergent//fci/drawing/10067847.pdf" H 1550 1100 50  0001 C CNN
	1    1550 1100
	-1   0    0    1   
$EndComp
Text Notes 5900 6600 0    50   ~ 0
Atari Joystick
Text Label 6500 5200 0    50   ~ 0
PD6_LEFT
Text Label 6500 5300 0    50   ~ 0
PD7_RIGHT
Text Label 6500 4900 0    50   ~ 0
PD3_VGA_BLU
Text Label 6500 4800 0    50   ~ 0
PD2
Text Label 6500 4700 0    50   ~ 0
PD1
Text Label 6500 4600 0    50   ~ 0
PD0
Text Label 6500 4400 0    50   ~ 0
PC7_DOWN
Text Label 6500 4300 0    50   ~ 0
PC6_UP
Text Label 6500 4200 0    50   ~ 0
PC5_U1CTS
Text Label 6500 4100 0    50   ~ 0
PC4_U1RTS
Text Label 6500 4000 0    50   ~ 0
PC3
Text Label 6500 3900 0    50   ~ 0
PC2
Text Label 6500 3800 0    50   ~ 0
PC1
Text Label 6500 3700 0    50   ~ 0
PC0
Text Label 6500 3500 0    50   ~ 0
PB7_VGA_GRN
Text Label 6500 3400 0    50   ~ 0
PB6
Text Label 6500 3300 0    50   ~ 0
PB5_VGA_VSYNC
Text Label 6500 3200 0    50   ~ 0
PB4_VGA_HSYNC
Text Label 6500 3100 0    50   ~ 0
PB3
Text Label 6500 3000 0    50   ~ 0
PB2
Text Label 6500 2900 0    50   ~ 0
PB1_U1TX
Text Label 6500 2800 0    50   ~ 0
PB0_U1RX
Text Label 6500 2600 0    50   ~ 0
PA7
Text Label 6500 2500 0    50   ~ 0
PA6
Text Label 6500 2400 0    50   ~ 0
PA5_SD_MOSI
Text Label 6500 2300 0    50   ~ 0
PA4_SD_MISO
Text Label 6500 2200 0    50   ~ 0
PA3_SD_CS
Text Label 6500 2100 0    50   ~ 0
PA2_SD_CLK
Text Label 6500 2000 0    50   ~ 0
PA1
Text Label 6500 1900 0    50   ~ 0
PA0
Wire Wire Line
	6400 2100 6800 2100
Wire Wire Line
	6400 2200 6800 2200
Wire Wire Line
	6400 2300 6800 2300
Wire Wire Line
	6400 2400 6800 2400
Wire Wire Line
	6400 2500 6800 2500
Wire Wire Line
	6400 2600 6800 2600
Wire Wire Line
	6400 3000 6800 3000
Wire Wire Line
	6400 3100 6800 3100
Wire Wire Line
	6400 3200 6800 3200
Wire Wire Line
	6400 3300 6800 3300
Wire Wire Line
	6400 3400 6800 3400
Wire Wire Line
	6400 3700 6800 3700
Wire Wire Line
	6400 3800 6800 3800
Wire Wire Line
	6400 3900 6800 3900
Wire Wire Line
	6400 4000 6800 4000
Wire Wire Line
	6400 4100 6800 4100
Wire Wire Line
	6400 4200 6800 4200
Wire Wire Line
	6400 4300 6800 4300
Wire Wire Line
	6400 4400 6800 4400
Wire Wire Line
	6400 4600 6800 4600
Wire Wire Line
	6400 4700 6800 4700
Wire Wire Line
	6400 4800 6800 4800
Wire Wire Line
	6400 4900 6800 4900
Text Label 6500 5000 0    50   ~ 0
PD4_USB_DM
Wire Wire Line
	6400 5000 6800 5000
Wire Wire Line
	6400 5100 6800 5100
Wire Wire Line
	6400 5200 6800 5200
Wire Wire Line
	6400 5300 6800 5300
Text Label 3400 1900 0    50   ~ 0
PE0
Text Label 3400 2000 0    50   ~ 0
PE1
Text Label 3400 2100 0    50   ~ 0
PE2
Text Label 3400 2200 0    50   ~ 0
PE3
Text Label 3050 2300 0    50   ~ 0
PE4_AUD_L
Text Label 3050 2400 0    50   ~ 0
PE5_AUD_R
Wire Wire Line
	3400 1900 3600 1900
Wire Wire Line
	3400 2000 3600 2000
Wire Wire Line
	3400 2100 3600 2100
Wire Wire Line
	3400 2200 3600 2200
Wire Wire Line
	3600 2600 3400 2600
Wire Wire Line
	3600 2800 3400 2800
Wire Wire Line
	3600 2900 3400 2900
Text Label 3400 2600 0    50   ~ 0
PF0
Text Label 3050 2700 0    50   ~ 0
PF1_VGA_RED
Text Label 3400 2800 0    50   ~ 0
PF2
Text Label 3400 2900 0    50   ~ 0
PF3
Text Label 3050 3000 0    50   ~ 0
PF4_FIRE
Text Label 3400 3300 0    50   ~ 0
~RST
Wire Wire Line
	3400 3300 3600 3300
Wire Wire Line
	5400 7450 4950 7450
Wire Wire Line
	5400 7350 4950 7350
Wire Wire Line
	5400 7250 4950 7250
Wire Wire Line
	5400 7050 4950 7050
Wire Wire Line
	5400 6850 4950 6850
Text Label 5000 7450 0    50   ~ 0
PC6_UP
Text Label 5000 7350 0    50   ~ 0
PF4_FIRE
Text Label 5000 7250 0    50   ~ 0
PC7_DOWN
Text Label 5000 7050 0    50   ~ 0
PD6_LEFT
Text Label 5000 6850 0    50   ~ 0
PD7_RIGHT
$Comp
L power:GND #PWR016
U 1 1 5C51AB4B
P 4600 7100
F 0 "#PWR016" H 4600 6850 50  0001 C CNN
F 1 "GND" H 4605 6927 50  0000 C CNN
F 2 "" H 4600 7100 50  0001 C CNN
F 3 "" H 4600 7100 50  0001 C CNN
	1    4600 7100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 6950 4600 7100
Wire Wire Line
	4600 6950 5400 6950
$Sheet
S 9400 5200 550  950 
U 5C526519
F0 "Monotron RS232 Level Shifter" 50
F1 "monotron_rs232_level_shifter.sch" 50
F2 "DTE_RX" O L 9400 5450 50 
F3 "DTE_TX" I L 9400 5600 50 
F4 "DTE_RTS" I L 9400 5750 50 
F5 "DTE_CTS" O L 9400 5900 50 
$EndSheet
Wire Wire Line
	8750 5400 9150 5400
Wire Wire Line
	9150 5400 9150 5450
Wire Wire Line
	9150 5450 9400 5450
Wire Wire Line
	8750 5500 9050 5500
Wire Wire Line
	9050 5500 9050 5600
Wire Wire Line
	9050 5600 9400 5600
Wire Wire Line
	8750 5600 8950 5600
Wire Wire Line
	8950 5600 8950 5750
Wire Wire Line
	8950 5750 9400 5750
Wire Wire Line
	8250 5300 7950 5300
Wire Wire Line
	8750 5700 8850 5700
Wire Wire Line
	8850 5700 8850 5900
Wire Wire Line
	8850 5900 9400 5900
Wire Wire Line
	7950 5300 7950 5200
$Comp
L power:+3.3V #PWR018
U 1 1 5C5A73D9
P 7950 5200
F 0 "#PWR018" H 7950 5050 50  0001 C CNN
F 1 "+3.3V" H 7965 5373 50  0000 C CNN
F 2 "" H 7950 5200 50  0001 C CNN
F 3 "" H 7950 5200 50  0001 C CNN
	1    7950 5200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR019
U 1 1 5C5E6C50
P 8250 5950
F 0 "#PWR019" H 8250 5700 50  0001 C CNN
F 1 "GND" H 8255 5777 50  0000 C CNN
F 2 "" H 8250 5950 50  0001 C CNN
F 3 "" H 8250 5950 50  0001 C CNN
	1    8250 5950
	1    0    0    -1  
$EndComp
Text Label 7800 5700 0    50   ~ 0
PC5_U1CTS
Text Label 7800 5600 0    50   ~ 0
PC4_U1RTS
Text Label 7800 5500 0    50   ~ 0
PB1_U1TX
Text Label 7800 5400 0    50   ~ 0
PB0_U1RX
NoConn ~ 2450 1500
NoConn ~ 2450 700 
Wire Wire Line
	2450 800  2850 800 
Wire Wire Line
	2450 1000 2850 1000
Wire Wire Line
	2450 1300 2850 1300
Wire Wire Line
	2450 1400 2850 1400
Text Label 2500 1400 0    50   ~ 0
PA3_SD_CS
Text Label 2500 1300 0    50   ~ 0
PA5_SD_MOSI
Text Label 2500 1000 0    50   ~ 0
PA2_SD_CLK
Text Label 2500 800  0    50   ~ 0
PA4_SD_MISO
$Comp
L power:GND #PWR09
U 1 1 5C71A54F
P 3050 1550
F 0 "#PWR09" H 3050 1300 50  0001 C CNN
F 1 "GND" H 3055 1377 50  0000 C CNN
F 2 "" H 3050 1550 50  0001 C CNN
F 3 "" H 3050 1550 50  0001 C CNN
	1    3050 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 1500 3500 1550
Connection ~ 3500 1500
$Comp
L power:+3.3V #PWR010
U 1 1 5C733FCB
P 3250 750
F 0 "#PWR010" H 3250 600 50  0001 C CNN
F 1 "+3.3V" H 3265 923 50  0000 C CNN
F 2 "" H 3250 750 50  0001 C CNN
F 3 "" H 3250 750 50  0001 C CNN
	1    3250 750 
	1    0    0    -1  
$EndComp
NoConn ~ 650  900 
NoConn ~ 650  1000
NoConn ~ 650  1200
NoConn ~ 650  1300
Wire Wire Line
	7750 5400 8250 5400
Wire Wire Line
	7750 5500 8250 5500
Wire Wire Line
	7750 5600 8250 5600
Wire Wire Line
	7750 5700 8250 5700
NoConn ~ 5400 6650
NoConn ~ 5400 7150
$Comp
L power:GND #PWR021
U 1 1 5C7F7B88
P 8750 5950
F 0 "#PWR021" H 8750 5700 50  0001 C CNN
F 1 "GND" H 8755 5777 50  0000 C CNN
F 2 "" H 8750 5950 50  0001 C CNN
F 3 "" H 8750 5950 50  0001 C CNN
	1    8750 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8750 5800 8750 5950
Wire Wire Line
	8250 5950 8250 5800
$Comp
L power:VCC #PWR022
U 1 1 5C812E3A
P 9050 5200
F 0 "#PWR022" H 9050 5050 50  0001 C CNN
F 1 "VCC" H 9067 5373 50  0000 C CNN
F 2 "" H 9050 5200 50  0001 C CNN
F 3 "" H 9050 5200 50  0001 C CNN
	1    9050 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8750 5300 9050 5300
Wire Wire Line
	9050 5300 9050 5200
$Sheet
S 9400 850  1000 900 
U 5C821310
F0 "Monotron I/O Expansion" 50
F1 "monotron_ps2.sch" 50
F2 "UART_MCU_TO_IO" I L 9400 1100 50 
F3 "UART_IO_TO_MCU" O L 9400 1000 50 
$EndSheet
$Comp
L Connector:DB15_Female_HighDensity_MountingHoles J6
U 1 1 5CA569BB
P 9150 3900
F 0 "J6" H 9150 4767 50  0000 C CNN
F 1 "DB15_Female_HighDensity_MountingHoles" H 9150 4676 50  0000 C CNN
F 2 "" H 8200 4300 50  0001 C CNN
F 3 " ~" H 8200 4300 50  0001 C CNN
	1    9150 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 1000 7800 1900
Wire Wire Line
	7800 1900 6400 1900
Wire Wire Line
	7800 1000 9400 1000
Wire Wire Line
	6400 2000 7900 2000
Wire Wire Line
	7900 2000 7900 1100
Wire Wire Line
	7900 1100 9400 1100
Wire Wire Line
	8850 3500 8650 3500
Wire Wire Line
	8850 3700 8650 3700
Wire Wire Line
	8850 3900 8650 3900
$Comp
L Device:R R1
U 1 1 5CAEE786
P 8500 3500
F 0 "R1" V 8400 3500 50  0000 C CNN
F 1 "330" V 8500 3500 50  0000 C CNN
F 2 "" V 8430 3500 50  0001 C CNN
F 3 "~" H 8500 3500 50  0001 C CNN
	1    8500 3500
	0    1    1    0   
$EndComp
$Comp
L Device:R R2
U 1 1 5CAEE811
P 8500 3700
F 0 "R2" V 8400 3700 50  0000 C CNN
F 1 "330" V 8500 3700 50  0000 C CNN
F 2 "" V 8430 3700 50  0001 C CNN
F 3 "~" H 8500 3700 50  0001 C CNN
	1    8500 3700
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 5CAEE85F
P 8500 3900
F 0 "R3" V 8400 3900 50  0000 C CNN
F 1 "330" V 8500 3900 50  0000 C CNN
F 2 "" V 8430 3900 50  0001 C CNN
F 3 "~" H 8500 3900 50  0001 C CNN
	1    8500 3900
	0    1    1    0   
$EndComp
Text Label 7850 3500 0    50   ~ 0
PF1_VGA_RED
Text Label 7850 3700 0    50   ~ 0
PB7_VGA_GRN
Text Label 7850 3900 0    50   ~ 0
PD3_VGA_BLU
Wire Wire Line
	9450 3900 9850 3900
Wire Wire Line
	9450 4100 9850 4100
Text Label 9500 4100 0    50   ~ 0
PB5_VGA_VSYNC
Text Label 9500 3900 0    50   ~ 0
PB4_VGA_HSYNC
Wire Wire Line
	8850 3400 8700 3400
Wire Wire Line
	8700 3400 8700 3600
Wire Wire Line
	8850 3600 8700 3600
Connection ~ 8700 3600
Wire Wire Line
	8700 3600 8700 3800
Wire Wire Line
	8850 3800 8700 3800
Connection ~ 8700 3800
Wire Wire Line
	8700 3800 8700 4300
Wire Wire Line
	8850 4300 8700 4300
Connection ~ 8700 4300
Wire Wire Line
	8700 4300 8700 4500
NoConn ~ 8850 4200
NoConn ~ 8850 4100
NoConn ~ 8850 4000
NoConn ~ 9450 3500
NoConn ~ 9450 3700
NoConn ~ 9450 4300
$Comp
L power:GND #PWR020
U 1 1 5CBBCC77
P 8700 4500
F 0 "#PWR020" H 8700 4250 50  0001 C CNN
F 1 "GND" H 8705 4327 50  0000 C CNN
F 2 "" H 8700 4500 50  0001 C CNN
F 3 "" H 8700 4500 50  0001 C CNN
	1    8700 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 5CBBD185
P 9150 4600
F 0 "#PWR023" H 9150 4350 50  0001 C CNN
F 1 "GND" H 9155 4427 50  0000 C CNN
F 2 "" H 9150 4600 50  0001 C CNN
F 3 "" H 9150 4600 50  0001 C CNN
	1    9150 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 2700 3600 2700
Wire Wire Line
	7850 3500 8350 3500
Wire Wire Line
	7850 3900 8350 3900
Wire Wire Line
	7850 3700 8350 3700
Wire Wire Line
	6400 3500 7000 3500
Wire Wire Line
	3050 2300 3600 2300
Wire Wire Line
	3050 2400 3600 2400
Wire Wire Line
	3050 3000 3600 3000
Wire Wire Line
	6400 2800 6800 2800
Wire Wire Line
	6400 2900 6800 2900
NoConn ~ 6800 4600
NoConn ~ 6800 4700
NoConn ~ 6800 4800
NoConn ~ 6800 3700
NoConn ~ 6800 3800
NoConn ~ 6800 3900
NoConn ~ 6800 4000
NoConn ~ 6800 3000
NoConn ~ 6800 3100
NoConn ~ 6800 3400
NoConn ~ 6800 2500
NoConn ~ 6800 2600
NoConn ~ 3400 2600
NoConn ~ 3400 2200
NoConn ~ 3400 2100
NoConn ~ 3400 2000
NoConn ~ 3400 1900
NoConn ~ 3400 2800
NoConn ~ 3400 2900
NoConn ~ 5400 6750
Wire Wire Line
	3250 1100 3250 750 
Wire Wire Line
	2450 1100 3250 1100
Wire Wire Line
	3050 900  3050 1200
Wire Wire Line
	2450 900  3050 900 
Wire Wire Line
	2450 1200 3050 1200
Connection ~ 3050 1200
Wire Wire Line
	3050 1200 3050 1550
$Comp
L Connector:USB_B_Micro J2
U 1 1 5C2DBB12
P 950 5300
F 0 "J2" H 700 5700 50  0000 C CNN
F 1 "USB_B_Micro" H 1000 5700 50  0000 C CNN
F 2 "" H 1100 5250 50  0001 C CNN
F 3 "~" H 1100 5250 50  0001 C CNN
	1    950  5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  5750 950  5850
Connection ~ 950  5750
NoConn ~ 850  5700
$Comp
L MCU_Texas:TM4C1231H6PM U2
U 1 1 5CE3D20A
P 5000 3700
F 0 "U2" H 3800 1650 50  0000 C CNN
F 1 "TM4C1231H6PM" H 5900 1700 50  0000 C CNN
F 2 "Package_QFP:LQFP-64_10x10mm_P0.5mm" H 6200 1600 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/tm4c1231h6pm.pdf" H 5000 3900 50  0001 C CNN
	1    5000 3700
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J5
U 1 1 5CE8C75D
P 8450 5500
F 0 "J5" H 8500 5917 50  0000 C CNN
F 1 "Conn_02x06_Odd_Even" H 8500 5826 50  0000 C CNN
F 2 "" H 8450 5500 50  0001 C CNN
F 3 "~" H 8450 5500 50  0001 C CNN
	1    8450 5500
	1    0    0    -1  
$EndComp
Text Notes 8900 2500 0    50   ~ 10
TODO! AUDIO OUTPUT GOES HERE
$EndSCHEMATC
