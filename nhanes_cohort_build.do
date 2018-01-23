clear
fdause "/Users/sbasu/Data/NHANES/1999-2000/DEMO.xpt"
sort seqn
save nhanesnutr9900, replace
clear	
fdause "/Users/sbasu/Data/NHANES/1999-2000/BMX.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear	
fdause "/Users/sbasu/Data/NHANES/1999-2000/BPQ.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear	
fdause "/Users/sbasu/Data/NHANES/1999-2000/BPX.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear	
fdause "/Users/sbasu/Data/NHANES/1999-2000/MCQ.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear	
fdause "/Users/sbasu/Data/NHANES/1999-2000/LAB10.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear
fdause "/Users/sbasu/Data/NHANES/1999-2000/LAB10AM.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear
fdause "/Users/sbasu/Data/NHANES/1999-2000/LAB13.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear
fdause "/Users/sbasu/Data/NHANES/1999-2000/LAB13AM.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear
fdause "/Users/sbasu/Data/NHANES/1999-2000/DIQ.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear
fdause "/Users/sbasu/Data/NHANES/1999-2000/SMQ.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
clear
fdause "/Users/sbasu/Data/NHANES/1999-2000/LAB16.xpt"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
fdause "/Users/sbasu/Data/NHANES/1999-2000/LAB18.xpt",  clear	
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
fdause "/Users/sbasu/Data/NHANES/1999-2000/SMQ.xpt",  clear	
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
fdause "/Users/sbasu/Data/NHANES/1999-2000/DRXTOT.XPT",  clear	
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace


import sasxport "/Users/sbasu/Data/NHANES/1999-2000/RXQ_RX.xpt", clear
sort seqn
save nhanesdrug9900, replace
import sasxport "/Users/sbasu/Data/NHANES/1999-2000/RXQ_DRUG.xpt", clear
sort rxddrgid
merge m:m rxddrgid using nhanesdrug9900

*med list
g byte acei = regexm(rxddrug, "PRIL$")
g byte ace2 = regexm(rxddrug, "^BENAZEPRIL")
replace ace2 = 0 if acei==1
g byte arb = regexm(rxddrug, "SARTAN$")
g byte bb = regexm(rxddrug, "OLOL$")
g byte bb2 = regexm(rxddrug, "CARVEDILOL$")
g byte bb3 = regexm(rxddrug, "SOTALOL")
g byte ccb = regexm(rxddrug,"DIPINE$")
g byte ccb2 = regexm(rxddrug,"DILTIAZEM")
g byte ccb3 = regexm(rxddrug,"PAMIL$")
g byte ccb4 = regexm(rxddrug,"^AMLODIPINE")
replace ccb4 = 0 if ccb==1
g byte thi = regexm(rxddrug,"^HYDROCHLOROTHIAZIDE")
g byte thi2 = regexm(rxddrug,"THIAZIDE$")
replace thi2 = 0 if thi==1
g byte oth = regexm(rxddrug,"HYDRALAZINE")
g byte oth2 = regexm(rxddrug,"TRIAMTERENE")
g byte oth3 = regexm(rxddrug,"ANTIHYPERTENSIVE AGENT")
g byte oth4 = regexm(rxddrug,"CLONIDINE")

g bpmeds = acei+ace2+arb+bb+bb2+bb3+ccb+ccb2+ccb3+ccb4+thi+thi2+oth+oth2+oth3+oth4
g statin = regexm(rxddrug,"STATIN$")
g oraldmrx = regexm(rxddrug,"METFORMIN$") | regexm(rxddrug,"^METFORMIN") | regexm(rxddrug,"GLIPIZIDE$") | regexm(rxddrug,"^GLIPIZIDE") | regexm(rxddrug,"^GLITAZONE") | regexm(rxddrug,"GLITAZONE$")
g anticoag = regexm(rxddrug,"WARFARIN$") | regexm(rxddrug,"^WARFARIN") | regexm(rxddrug,"COUMADIN$") | regexm(rxddrug,"^COUMADIN")
g asa = regexm(rxddrug,"ASPIRIN$") | regexm(rxddrug,"^ASPIRIN") 

sort seqn
collapse (max) bpmeds statin oraldmrx anticoag asa, by(seqn) cw
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace
use "/Users/sbasu/Data/NHANES/Linked NDI/NHANES_1999_2000_MORT_2011_PUBLIC.dta"
sort seqn
merge seqn using nhanesnutr9900
drop _merge
sort seqn
save nhanesnutr9900, replace



fdause "/Users/sbasu/Data/NHANES/1999-2000/DRXIFF.XPT",  clear	
 
 * kcals by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., kcal11 = milks and milk drinks
  g kcal11 = drxikcal if (drdifdcd>=11000000 & drdifdcd<12000000)
  g kcal12 = drxikcal if (drdifdcd>=12000000 & drdifdcd<13000000)
  g kcal13 = drxikcal if (drdifdcd>=13000000 & drdifdcd<14000000)
  g kcal14 = drxikcal if (drdifdcd>=14000000 & drdifdcd<15000000)

  g kcal20 = drxikcal if (drdifdcd>=20000000 & drdifdcd<21000000)
  g kcal21 = drxikcal if (drdifdcd>=21000000 & drdifdcd<22000000)
  g kcal22 = drxikcal if (drdifdcd>=22000000 & drdifdcd<23000000)
  g kcal23 = drxikcal if (drdifdcd>=23000000 & drdifdcd<24000000)
  g kcal24 = drxikcal if (drdifdcd>=24000000 & drdifdcd<25000000)
  g kcal25 = drxikcal if (drdifdcd>=25000000 & drdifdcd<26000000)
  g kcal26 = drxikcal if (drdifdcd>=26000000 & drdifdcd<27000000)
  g kcal27 = drxikcal if (drdifdcd>=27000000 & drdifdcd<28000000)
  g kcal28 = drxikcal if (drdifdcd>=28000000 & drdifdcd<29000000)

  g kcal31 = drxikcal if (drdifdcd>=31000000 & drdifdcd<32000000)
  g kcal32 = drxikcal if (drdifdcd>=32000000 & drdifdcd<33000000)
  g kcal33 = drxikcal if (drdifdcd>=33000000 & drdifdcd<34000000)
  g kcal35 = drxikcal if (drdifdcd>=34000000 & drdifdcd<35000000)

  g kcal41 = drxikcal if (drdifdcd>=41000000 & drdifdcd<42000000)
  g kcal42 = drxikcal if (drdifdcd>=42000000 & drdifdcd<43000000)
  g kcal43 = drxikcal if (drdifdcd>=43000000 & drdifdcd<44000000)
  g kcal44 = drxikcal if (drdifdcd>=44000000 & drdifdcd<45000000)

  g kcal50 = drxikcal if (drdifdcd>=50000000 & drdifdcd<51000000)
  g kcal51 = drxikcal if (drdifdcd>=51000000 & drdifdcd<52000000)
  g kcal52 = drxikcal if (drdifdcd>=52000000 & drdifdcd<53000000)
  g kcal53 = drxikcal if (drdifdcd>=53000000 & drdifdcd<54000000)
  g kcal54 = drxikcal if (drdifdcd>=54000000 & drdifdcd<55000000)
  g kcal55 = drxikcal if (drdifdcd>=55000000 & drdifdcd<56000000)
  g kcal56 = drxikcal if (drdifdcd>=56000000 & drdifdcd<57000000)
  g kcal57 = drxikcal if (drdifdcd>=57000000 & drdifdcd<58000000)
  g kcal58 = drxikcal if (drdifdcd>=58000000 & drdifdcd<59000000)
  g kcal59 = drxikcal if (drdifdcd>=59000000 & drdifdcd<60000000)

  g kcal61 = drxikcal if (drdifdcd>=61000000 & drdifdcd<62000000)
  g kcal62 = drxikcal if (drdifdcd>=62000000 & drdifdcd<63000000)
  g kcal63 = drxikcal if (drdifdcd>=63000000 & drdifdcd<64000000)
  g kcal64 = drxikcal if (drdifdcd>=64000000 & drdifdcd<65000000)
  g kcal67 = drxikcal if (drdifdcd>=67000000 & drdifdcd<68000000)

  g kcal71 = drxikcal if (drdifdcd>=71000000 & drdifdcd<72000000)
  g kcal72 = drxikcal if (drdifdcd>=72000000 & drdifdcd<73000000)
  g kcal73 = drxikcal if (drdifdcd>=73000000 & drdifdcd<74000000)
  g kcal74 = drxikcal if (drdifdcd>=74000000 & drdifdcd<75000000)
  g kcal75 = drxikcal if (drdifdcd>=75000000 & drdifdcd<76000000)
  g kcal76 = drxikcal if (drdifdcd>=76000000 & drdifdcd<77000000)
  g kcal77 = drxikcal if (drdifdcd>=77000000 & drdifdcd<78000000)
  g kcal78 = drxikcal if (drdifdcd>=78000000 & drdifdcd<79000000)

  g kcal81 = drxikcal if (drdifdcd>=81000000 & drdifdcd<82000000)
  g kcal82 = drxikcal if (drdifdcd>=82000000 & drdifdcd<83000000)
  g kcal83 = drxikcal if (drdifdcd>=83000000 & drdifdcd<84000000)

  g kcal91 = drxikcal if (drdifdcd>=91000000 & drdifdcd<92000000)
  g kcal92 = drxikcal if (drdifdcd>=92000000 & drdifdcd<93000000)
  g kcal93 = drxikcal if (drdifdcd>=93000000 & drdifdcd<94000000)
  g kcal94 = drxikcal if (drdifdcd>=94000000 & drdifdcd<95000000)
  g kcal95 = drxikcal if (drdifdcd>=95000000 & drdifdcd<96000000)

  
  
 * grams by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., gram11 = milks and milk drinks
  g gram11 = drxigrms if (drdifdcd>=11000000 & drdifdcd<12000000)
  g gram12 = drxigrms if (drdifdcd>=12000000 & drdifdcd<13000000)
  g gram13 = drxigrms if (drdifdcd>=13000000 & drdifdcd<14000000)
  g gram14 = drxigrms if (drdifdcd>=14000000 & drdifdcd<15000000)

  g gram20 = drxigrms if (drdifdcd>=20000000 & drdifdcd<21000000)
  g gram21 = drxigrms if (drdifdcd>=21000000 & drdifdcd<22000000)
  g gram22 = drxigrms if (drdifdcd>=22000000 & drdifdcd<23000000)
  g gram23 = drxigrms if (drdifdcd>=23000000 & drdifdcd<24000000)
  g gram24 = drxigrms if (drdifdcd>=24000000 & drdifdcd<25000000)
  g gram25 = drxigrms if (drdifdcd>=25000000 & drdifdcd<26000000)
  g gram26 = drxigrms if (drdifdcd>=26000000 & drdifdcd<27000000)
  g gram27 = drxigrms if (drdifdcd>=27000000 & drdifdcd<28000000)
  g gram28 = drxigrms if (drdifdcd>=28000000 & drdifdcd<29000000)

  g gram31 = drxigrms if (drdifdcd>=31000000 & drdifdcd<32000000)
  g gram32 = drxigrms if (drdifdcd>=32000000 & drdifdcd<33000000)
  g gram33 = drxigrms if (drdifdcd>=33000000 & drdifdcd<34000000)
  g gram35 = drxigrms if (drdifdcd>=34000000 & drdifdcd<35000000)

  g gram41 = drxigrms if (drdifdcd>=41000000 & drdifdcd<42000000)
  g gram42 = drxigrms if (drdifdcd>=42000000 & drdifdcd<43000000)
  g gram43 = drxigrms if (drdifdcd>=43000000 & drdifdcd<44000000)
  g gram44 = drxigrms if (drdifdcd>=44000000 & drdifdcd<45000000)

  g gram50 = drxigrms if (drdifdcd>=50000000 & drdifdcd<51000000)
  g gram51 = drxigrms if (drdifdcd>=51000000 & drdifdcd<52000000)
  g gram52 = drxigrms if (drdifdcd>=52000000 & drdifdcd<53000000)
  g gram53 = drxigrms if (drdifdcd>=53000000 & drdifdcd<54000000)
  g gram54 = drxigrms if (drdifdcd>=54000000 & drdifdcd<55000000)
  g gram55 = drxigrms if (drdifdcd>=55000000 & drdifdcd<56000000)
  g gram56 = drxigrms if (drdifdcd>=56000000 & drdifdcd<57000000)
  g gram57 = drxigrms if (drdifdcd>=57000000 & drdifdcd<58000000)
  g gram58 = drxigrms if (drdifdcd>=58000000 & drdifdcd<59000000)
  g gram59 = drxigrms if (drdifdcd>=59000000 & drdifdcd<60000000)

  g gram61 = drxigrms if (drdifdcd>=61000000 & drdifdcd<62000000)
  g gram62 = drxigrms if (drdifdcd>=62000000 & drdifdcd<63000000)
  g gram63 = drxigrms if (drdifdcd>=63000000 & drdifdcd<64000000)
  g gram64 = drxigrms if (drdifdcd>=64000000 & drdifdcd<65000000)
  g gram67 = drxigrms if (drdifdcd>=67000000 & drdifdcd<68000000)

  g gram71 = drxigrms if (drdifdcd>=71000000 & drdifdcd<72000000)
  g gram72 = drxigrms if (drdifdcd>=72000000 & drdifdcd<73000000)
  g gram73 = drxigrms if (drdifdcd>=73000000 & drdifdcd<74000000)
  g gram74 = drxigrms if (drdifdcd>=74000000 & drdifdcd<75000000)
  g gram75 = drxigrms if (drdifdcd>=75000000 & drdifdcd<76000000)
  g gram76 = drxigrms if (drdifdcd>=76000000 & drdifdcd<77000000)
  g gram77 = drxigrms if (drdifdcd>=77000000 & drdifdcd<78000000)
  g gram78 = drxigrms if (drdifdcd>=78000000 & drdifdcd<79000000)

  g gram81 = drxigrms if (drdifdcd>=81000000 & drdifdcd<82000000)
  g gram82 = drxigrms if (drdifdcd>=82000000 & drdifdcd<83000000)
  g gram83 = drxigrms if (drdifdcd>=83000000 & drdifdcd<84000000)

  g gram91 = drxigrms if (drdifdcd>=91000000 & drdifdcd<92000000)
  g gram92 = drxigrms if (drdifdcd>=92000000 & drdifdcd<93000000)
  g gram93 = drxigrms if (drdifdcd>=93000000 & drdifdcd<94000000)
  g gram94 = drxigrms if (drdifdcd>=94000000 & drdifdcd<95000000)
  g gram95 = drxigrms if (drdifdcd>=95000000 & drdifdcd<96000000)

  

 collapse (sum) kcal11 kcal12 kcal13 kcal14 kcal20 kcal21 kcal22 kcal23 kcal24 kcal25 kcal26 kcal27 kcal28 kcal31 kcal32 kcal33 kcal35 kcal41 kcal42 kcal43 kcal44 kcal50 kcal51 kcal52 kcal53 kcal54 kcal55 kcal56 kcal57 kcal58 kcal59 kcal61 kcal62 kcal63 kcal64 kcal67 kcal71 kcal72 kcal73 kcal74 kcal75 kcal76 kcal77 kcal78 kcal81 kcal82 kcal83 kcal91 kcal92 kcal93 kcal94 kcal95 gram11 gram12 gram13 gram14 gram20 gram21 gram22 gram23 gram24 gram25 gram26 gram27 gram28 gram31 gram32 gram33 gram35 gram41 gram42 gram43 gram44 gram50 gram51 gram52 gram53 gram54 gram55 gram56 gram57 gram58 gram59 gram61 gram62 gram63 gram64 gram67 gram71 gram72 gram73 gram74 gram75 gram76 gram77 gram78 gram81 gram82 gram83 gram91 gram92 gram93 gram94 gram95, by(seqn) 
 
 sort seqn
merge seqn using nhanesnutr9900
drop _merge

 
save nhanesnutr9900, replace





* age, in yrs
g age = ridageyr

* sex, 0 = male, 1 = female
g sex =  riagendr-1

* black, 0 = white, 1 = black
g black = 0 if ridreth1==3
replace black = 1 if ridreth1==4

* hisp, 0 = nonhisp, 1 = hisp
g hisp = 1 if ridreth1<3
replace hisp = 0 if ridreth1>=3


* sbp and dbp, in mmhg

foreach i in bpxsy1 bpxsy2 bpxsy3 bpxsy4 {
    replace `i' =. if `i'==0
}

gen n_sbp= !missing(bpxsy1)+ !missing(bpxsy2)+ !missing(bpxsy3)+ !missing(bpxsy4)

egen sbp = rowmean(bpxsy1 bpxsy2 bpxsy3 bpxsy4)


* dm is diabetes status, by L a1c or fbg or self-report or meds
g a1c = lbxgh
gen dm =1 if ((lbxgh>=6.5) | (lbxglu>=126)) | (diq010==1) | (diq050==1)
replace dm = 0 if dm!=1 


* egfr by CKD-EPI equation
g screat = lbxscr
g ualbcr = urxuma/urxucr*1000
g egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age) if sex==0 & black==0
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018 if sex==1 & black==0
replace egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.159 if sex==0 & black==1
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018*1.159 if sex==1 & black==1

* tob is current smoker, 1 = current 
g tob = 1 if smq040<=2
replace tob = 0 if (smq040==. | smq040==3)

* totchol and ldl are total and ldl cholesterol, in mg/dl
g hdl = lbdhdl
g totchol = lbxtc

*MI or stroke history
g cvdhx =1  if (mcq160e==1)|(mcq160f==1)
replace cvdhx = 0 if cvdhx!=1

g cvddeath = 1 if mortstat==1 & (ucod_leading=="001" | ucod_leading=="005")
replace cvddeath = 0 if cvddeath!=1



  
  
cd "/Users/sbasu/Data/NHANES"
export delimited using "nhanesnutr9900", replace



clear
fdause "/Users/sbasu/Data/NHANES/2001-2002/DEMO_B.xpt"
sort seqn
save nhanesnutr0102, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2001-2002/BMX_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2001-2002/BPQ_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2001-2002/BPX_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2001-2002/MCQ_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2001-2002/L10_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear
fdause "/Users/sbasu/Data/NHANES/2001-2002/L10AM_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear
fdause "/Users/sbasu/Data/NHANES/2001-2002/L13_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear
fdause "/Users/sbasu/Data/NHANES/2001-2002/L13AM_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear
fdause "/Users/sbasu/Data/NHANES/2001-2002/DIQ_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear
fdause "/Users/sbasu/Data/NHANES/2001-2002/SMQ_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
clear
fdause "/Users/sbasu/Data/NHANES/2001-2002/L16_B.xpt"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
fdause "/Users/sbasu/Data/NHANES/2001-2002/L40_B.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
fdause "/Users/sbasu/Data/NHANES/2001-2002/SMQ_B.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace
fdause "/Users/sbasu/Data/NHANES/2001-2002/DRXTOT_B.XPT",  clear	
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace



import sasxport "/Users/sbasu/Data/NHANES/2001-2002/RXQ_RX_B.xpt", clear
sort seqn
save nhanesdrug0102, replace
import sasxport "/Users/sbasu/Data/NHANES/2001-2002/RXQ_DRUG.xpt", clear
merge m:m rxddrgid using nhanesdrug0102
drop _merge
sort seqn
save nhanesdrug0102, replace

merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace


*med list
g byte acei = regexm(rxddrug, "PRIL$")
g byte ace2 = regexm(rxddrug, "^BENAZEPRIL")
replace ace2 = 0 if acei==1
g byte arb = regexm(rxddrug, "SARTAN$")
g byte bb = regexm(rxddrug, "OLOL$")
g byte bb2 = regexm(rxddrug, "CARVEDILOL$")
g byte bb3 = regexm(rxddrug, "SOTALOL")
g byte ccb = regexm(rxddrug,"DIPINE$")
g byte ccb2 = regexm(rxddrug,"DILTIAZEM")
g byte ccb3 = regexm(rxddrug,"PAMIL$")
g byte ccb4 = regexm(rxddrug,"^AMLODIPINE")
replace ccb4 = 0 if ccb==1
g byte thi = regexm(rxddrug,"^HYDROCHLOROTHIAZIDE")
g byte thi2 = regexm(rxddrug,"THIAZIDE$")
replace thi2 = 0 if thi==1
g byte oth = regexm(rxddrug,"HYDRALAZINE")
g byte oth2 = regexm(rxddrug,"TRIAMTERENE")
g byte oth3 = regexm(rxddrug,"ANTIHYPERTENSIVE AGENT")
g byte oth4 = regexm(rxddrug,"CLONIDINE")

g bpmeds = acei+ace2+arb+bb+bb2+bb3+ccb+ccb2+ccb3+ccb4+thi+thi2+oth+oth2+oth3+oth4
g statin = regexm(rxddrug,"STATIN$")
g oraldmrx = regexm(rxddrug,"METFORMIN$") | regexm(rxddrug,"^METFORMIN") | regexm(rxddrug,"GLIPIZIDE$") | regexm(rxddrug,"^GLIPIZIDE") | regexm(rxddrug,"^GLITAZONE") | regexm(rxddrug,"GLITAZONE$")
g anticoag = regexm(rxddrug,"WARFARIN$") | regexm(rxddrug,"^WARFARIN") | regexm(rxddrug,"COUMADIN$") | regexm(rxddrug,"^COUMADIN")
g asa = regexm(rxddrug,"ASPIRIN$") | regexm(rxddrug,"^ASPIRIN") 

sort seqn
collapse (max) bpmeds statin oraldmrx anticoag asa, by(seqn) cw
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace

use "/Users/sbasu/Data/NHANES/Linked NDI/NHANES_2001_2002_MORT_2011_PUBLIC.dta"
sort seqn
merge seqn using nhanesnutr0102
drop _merge
sort seqn
save nhanesnutr0102, replace


fdause "/Users/sbasu/Data/NHANES/2001-2002/DRXIFF_B.XPT",  clear	

 * kcals by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., kcal11 = milks and milk drinks
  g kcal11 = drxikcal if (drdifdcd>=11000000 & drdifdcd<12000000)
  g kcal12 = drxikcal if (drdifdcd>=12000000 & drdifdcd<13000000)
  g kcal13 = drxikcal if (drdifdcd>=13000000 & drdifdcd<14000000)
  g kcal14 = drxikcal if (drdifdcd>=14000000 & drdifdcd<15000000)

  g kcal20 = drxikcal if (drdifdcd>=20000000 & drdifdcd<21000000)
  g kcal21 = drxikcal if (drdifdcd>=21000000 & drdifdcd<22000000)
  g kcal22 = drxikcal if (drdifdcd>=22000000 & drdifdcd<23000000)
  g kcal23 = drxikcal if (drdifdcd>=23000000 & drdifdcd<24000000)
  g kcal24 = drxikcal if (drdifdcd>=24000000 & drdifdcd<25000000)
  g kcal25 = drxikcal if (drdifdcd>=25000000 & drdifdcd<26000000)
  g kcal26 = drxikcal if (drdifdcd>=26000000 & drdifdcd<27000000)
  g kcal27 = drxikcal if (drdifdcd>=27000000 & drdifdcd<28000000)
  g kcal28 = drxikcal if (drdifdcd>=28000000 & drdifdcd<29000000)

  g kcal31 = drxikcal if (drdifdcd>=31000000 & drdifdcd<32000000)
  g kcal32 = drxikcal if (drdifdcd>=32000000 & drdifdcd<33000000)
  g kcal33 = drxikcal if (drdifdcd>=33000000 & drdifdcd<34000000)
  g kcal35 = drxikcal if (drdifdcd>=34000000 & drdifdcd<35000000)

  g kcal41 = drxikcal if (drdifdcd>=41000000 & drdifdcd<42000000)
  g kcal42 = drxikcal if (drdifdcd>=42000000 & drdifdcd<43000000)
  g kcal43 = drxikcal if (drdifdcd>=43000000 & drdifdcd<44000000)
  g kcal44 = drxikcal if (drdifdcd>=44000000 & drdifdcd<45000000)

  g kcal50 = drxikcal if (drdifdcd>=50000000 & drdifdcd<51000000)
  g kcal51 = drxikcal if (drdifdcd>=51000000 & drdifdcd<52000000)
  g kcal52 = drxikcal if (drdifdcd>=52000000 & drdifdcd<53000000)
  g kcal53 = drxikcal if (drdifdcd>=53000000 & drdifdcd<54000000)
  g kcal54 = drxikcal if (drdifdcd>=54000000 & drdifdcd<55000000)
  g kcal55 = drxikcal if (drdifdcd>=55000000 & drdifdcd<56000000)
  g kcal56 = drxikcal if (drdifdcd>=56000000 & drdifdcd<57000000)
  g kcal57 = drxikcal if (drdifdcd>=57000000 & drdifdcd<58000000)
  g kcal58 = drxikcal if (drdifdcd>=58000000 & drdifdcd<59000000)
  g kcal59 = drxikcal if (drdifdcd>=59000000 & drdifdcd<60000000)

  g kcal61 = drxikcal if (drdifdcd>=61000000 & drdifdcd<62000000)
  g kcal62 = drxikcal if (drdifdcd>=62000000 & drdifdcd<63000000)
  g kcal63 = drxikcal if (drdifdcd>=63000000 & drdifdcd<64000000)
  g kcal64 = drxikcal if (drdifdcd>=64000000 & drdifdcd<65000000)
  g kcal67 = drxikcal if (drdifdcd>=67000000 & drdifdcd<68000000)

  g kcal71 = drxikcal if (drdifdcd>=71000000 & drdifdcd<72000000)
  g kcal72 = drxikcal if (drdifdcd>=72000000 & drdifdcd<73000000)
  g kcal73 = drxikcal if (drdifdcd>=73000000 & drdifdcd<74000000)
  g kcal74 = drxikcal if (drdifdcd>=74000000 & drdifdcd<75000000)
  g kcal75 = drxikcal if (drdifdcd>=75000000 & drdifdcd<76000000)
  g kcal76 = drxikcal if (drdifdcd>=76000000 & drdifdcd<77000000)
  g kcal77 = drxikcal if (drdifdcd>=77000000 & drdifdcd<78000000)
  g kcal78 = drxikcal if (drdifdcd>=78000000 & drdifdcd<79000000)

  g kcal81 = drxikcal if (drdifdcd>=81000000 & drdifdcd<82000000)
  g kcal82 = drxikcal if (drdifdcd>=82000000 & drdifdcd<83000000)
  g kcal83 = drxikcal if (drdifdcd>=83000000 & drdifdcd<84000000)

  g kcal91 = drxikcal if (drdifdcd>=91000000 & drdifdcd<92000000)
  g kcal92 = drxikcal if (drdifdcd>=92000000 & drdifdcd<93000000)
  g kcal93 = drxikcal if (drdifdcd>=93000000 & drdifdcd<94000000)
  g kcal94 = drxikcal if (drdifdcd>=94000000 & drdifdcd<95000000)
  g kcal95 = drxikcal if (drdifdcd>=95000000 & drdifdcd<96000000)

  
  
 * grams by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., gram11 = milks and milk drinks
  g gram11 = drxigrms if (drdifdcd>=11000000 & drdifdcd<12000000)
  g gram12 = drxigrms if (drdifdcd>=12000000 & drdifdcd<13000000)
  g gram13 = drxigrms if (drdifdcd>=13000000 & drdifdcd<14000000)
  g gram14 = drxigrms if (drdifdcd>=14000000 & drdifdcd<15000000)

  g gram20 = drxigrms if (drdifdcd>=20000000 & drdifdcd<21000000)
  g gram21 = drxigrms if (drdifdcd>=21000000 & drdifdcd<22000000)
  g gram22 = drxigrms if (drdifdcd>=22000000 & drdifdcd<23000000)
  g gram23 = drxigrms if (drdifdcd>=23000000 & drdifdcd<24000000)
  g gram24 = drxigrms if (drdifdcd>=24000000 & drdifdcd<25000000)
  g gram25 = drxigrms if (drdifdcd>=25000000 & drdifdcd<26000000)
  g gram26 = drxigrms if (drdifdcd>=26000000 & drdifdcd<27000000)
  g gram27 = drxigrms if (drdifdcd>=27000000 & drdifdcd<28000000)
  g gram28 = drxigrms if (drdifdcd>=28000000 & drdifdcd<29000000)

  g gram31 = drxigrms if (drdifdcd>=31000000 & drdifdcd<32000000)
  g gram32 = drxigrms if (drdifdcd>=32000000 & drdifdcd<33000000)
  g gram33 = drxigrms if (drdifdcd>=33000000 & drdifdcd<34000000)
  g gram35 = drxigrms if (drdifdcd>=34000000 & drdifdcd<35000000)

  g gram41 = drxigrms if (drdifdcd>=41000000 & drdifdcd<42000000)
  g gram42 = drxigrms if (drdifdcd>=42000000 & drdifdcd<43000000)
  g gram43 = drxigrms if (drdifdcd>=43000000 & drdifdcd<44000000)
  g gram44 = drxigrms if (drdifdcd>=44000000 & drdifdcd<45000000)

  g gram50 = drxigrms if (drdifdcd>=50000000 & drdifdcd<51000000)
  g gram51 = drxigrms if (drdifdcd>=51000000 & drdifdcd<52000000)
  g gram52 = drxigrms if (drdifdcd>=52000000 & drdifdcd<53000000)
  g gram53 = drxigrms if (drdifdcd>=53000000 & drdifdcd<54000000)
  g gram54 = drxigrms if (drdifdcd>=54000000 & drdifdcd<55000000)
  g gram55 = drxigrms if (drdifdcd>=55000000 & drdifdcd<56000000)
  g gram56 = drxigrms if (drdifdcd>=56000000 & drdifdcd<57000000)
  g gram57 = drxigrms if (drdifdcd>=57000000 & drdifdcd<58000000)
  g gram58 = drxigrms if (drdifdcd>=58000000 & drdifdcd<59000000)
  g gram59 = drxigrms if (drdifdcd>=59000000 & drdifdcd<60000000)

  g gram61 = drxigrms if (drdifdcd>=61000000 & drdifdcd<62000000)
  g gram62 = drxigrms if (drdifdcd>=62000000 & drdifdcd<63000000)
  g gram63 = drxigrms if (drdifdcd>=63000000 & drdifdcd<64000000)
  g gram64 = drxigrms if (drdifdcd>=64000000 & drdifdcd<65000000)
  g gram67 = drxigrms if (drdifdcd>=67000000 & drdifdcd<68000000)

  g gram71 = drxigrms if (drdifdcd>=71000000 & drdifdcd<72000000)
  g gram72 = drxigrms if (drdifdcd>=72000000 & drdifdcd<73000000)
  g gram73 = drxigrms if (drdifdcd>=73000000 & drdifdcd<74000000)
  g gram74 = drxigrms if (drdifdcd>=74000000 & drdifdcd<75000000)
  g gram75 = drxigrms if (drdifdcd>=75000000 & drdifdcd<76000000)
  g gram76 = drxigrms if (drdifdcd>=76000000 & drdifdcd<77000000)
  g gram77 = drxigrms if (drdifdcd>=77000000 & drdifdcd<78000000)
  g gram78 = drxigrms if (drdifdcd>=78000000 & drdifdcd<79000000)

  g gram81 = drxigrms if (drdifdcd>=81000000 & drdifdcd<82000000)
  g gram82 = drxigrms if (drdifdcd>=82000000 & drdifdcd<83000000)
  g gram83 = drxigrms if (drdifdcd>=83000000 & drdifdcd<84000000)

  g gram91 = drxigrms if (drdifdcd>=91000000 & drdifdcd<92000000)
  g gram92 = drxigrms if (drdifdcd>=92000000 & drdifdcd<93000000)
  g gram93 = drxigrms if (drdifdcd>=93000000 & drdifdcd<94000000)
  g gram94 = drxigrms if (drdifdcd>=94000000 & drdifdcd<95000000)
  g gram95 = drxigrms if (drdifdcd>=95000000 & drdifdcd<96000000)

  

 collapse (sum) kcal11 kcal12 kcal13 kcal14 kcal20 kcal21 kcal22 kcal23 kcal24 kcal25 kcal26 kcal27 kcal28 kcal31 kcal32 kcal33 kcal35 kcal41 kcal42 kcal43 kcal44 kcal50 kcal51 kcal52 kcal53 kcal54 kcal55 kcal56 kcal57 kcal58 kcal59 kcal61 kcal62 kcal63 kcal64 kcal67 kcal71 kcal72 kcal73 kcal74 kcal75 kcal76 kcal77 kcal78 kcal81 kcal82 kcal83 kcal91 kcal92 kcal93 kcal94 kcal95 gram11 gram12 gram13 gram14 gram20 gram21 gram22 gram23 gram24 gram25 gram26 gram27 gram28 gram31 gram32 gram33 gram35 gram41 gram42 gram43 gram44 gram50 gram51 gram52 gram53 gram54 gram55 gram56 gram57 gram58 gram59 gram61 gram62 gram63 gram64 gram67 gram71 gram72 gram73 gram74 gram75 gram76 gram77 gram78 gram81 gram82 gram83 gram91 gram92 gram93 gram94 gram95, by(seqn) 
  sort seqn
merge seqn using nhanesnutr0102
drop _merge
 sort seqn
save nhanesnutr0102, replace








* age, in yrs
g age = ridageyr

* sex, 0 = male, 1 = female
g sex =  riagendr-1

* black, 0 = white, 1 = black
g black = 0 if ridreth1==3
replace black = 1 if ridreth1==4

* hisp, 0 = nonhisp, 1 = hisp
g hisp = 1 if ridreth1<3
replace hisp = 0 if ridreth1>=3


* sbp and dbp, in mmhg

foreach i in bpxsy1 bpxsy2 bpxsy3 bpxsy4 {
    replace `i' =. if `i'==0
}

gen n_sbp= !missing(bpxsy1)+ !missing(bpxsy2)+ !missing(bpxsy3)+ !missing(bpxsy4)

egen sbp = rowmean(bpxsy1 bpxsy2 bpxsy3 bpxsy4)


* dm is diabetes status, by L a1c or fbg or self-report or meds
g a1c = lbxgh
gen dm =1 if ((lbxgh>=6.5) | (lbxglu>=126)) | (diq010==1) | (diq050==1)
replace dm = 0 if dm!=1 


* egfr by CKD-EPI equation
g screat = lbdscr
g ualbcr = urxuma/urxucr*1000
g egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age) if sex==0 & black==0
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018 if sex==1 & black==0
replace egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.159 if sex==0 & black==1
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018*1.159 if sex==1 & black==1

* tob is current smoker, 1 = current 
g tob = 1 if smq040<=2
replace tob = 0 if (smq040==. | smq040==3)

* totchol and ldl are total and ldl cholesterol, in mg/dl
g hdl = lbdhdl
g totchol = lbxtc

*MI or stroke history
g cvdhx =1  if (mcq160e==1)|(mcq160f==1)
replace cvdhx = 0 if cvdhx!=1


g cvddeath = 1 if mortstat==1 & (ucod_leading=="001" | ucod_leading=="005")
replace cvddeath = 0 if cvddeath!=1
 
 
cd "/Users/sbasu/Data/NHANES"
export delimited using "nhanesnutr0102", replace





clear
fdause "/Users/sbasu/Data/NHANES/2003-2004/DEMO_C.xpt"
sort seqn
save nhanesnutr0304, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2003-2004/BMX_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2003-2004/BPQ_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2003-2004/BPX_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2003-2004/MCQ_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2003-2004/L10_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear
fdause "/Users/sbasu/Data/NHANES/2003-2004/L10AM_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear
fdause "/Users/sbasu/Data/NHANES/2003-2004/L13_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear
fdause "/Users/sbasu/Data/NHANES/2003-2004/L13AM_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear
fdause "/Users/sbasu/Data/NHANES/2003-2004/DIQ_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear
fdause "/Users/sbasu/Data/NHANES/2003-2004/SMQ_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
clear
fdause "/Users/sbasu/Data/NHANES/2003-2004/L16_C.xpt"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
fdause "/Users/sbasu/Data/NHANES/2003-2004/L40_C.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace
fdause "/Users/sbasu/Data/NHANES/2003-2004/SMQ_C.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace

fdause "/Users/sbasu/Data/NHANES/2003-2004/DR1TOT_C.XPT",  clear	
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace


import sasxport "/Users/sbasu/Data/NHANES/2003-2004/RXQ_RX_C.xpt", clear
sort seqn
save nhanesdrug0304, replace
import sasxport "/Users/sbasu/Data/NHANES/2003-2004/RXQ_DRUG.xpt", clear
merge m:m rxddrgid using nhanesdrug0304
drop _merge


*med list
g byte acei = regexm(rxddrug, "PRIL$")
g byte ace2 = regexm(rxddrug, "^BENAZEPRIL")
replace ace2 = 0 if acei==1
g byte arb = regexm(rxddrug, "SARTAN$")
g byte bb = regexm(rxddrug, "OLOL$")
g byte bb2 = regexm(rxddrug, "CARVEDILOL$")
g byte bb3 = regexm(rxddrug, "SOTALOL")
g byte ccb = regexm(rxddrug,"DIPINE$")
g byte ccb2 = regexm(rxddrug,"DILTIAZEM")
g byte ccb3 = regexm(rxddrug,"PAMIL$")
g byte ccb4 = regexm(rxddrug,"^AMLODIPINE")
replace ccb4 = 0 if ccb==1
g byte thi = regexm(rxddrug,"^HYDROCHLOROTHIAZIDE")
g byte thi2 = regexm(rxddrug,"THIAZIDE$")
replace thi2 = 0 if thi==1
g byte oth = regexm(rxddrug,"HYDRALAZINE")
g byte oth2 = regexm(rxddrug,"TRIAMTERENE")
g byte oth3 = regexm(rxddrug,"ANTIHYPERTENSIVE AGENT")
g byte oth4 = regexm(rxddrug,"CLONIDINE")

g bpmeds = acei+ace2+arb+bb+bb2+bb3+ccb+ccb2+ccb3+ccb4+thi+thi2+oth+oth2+oth3+oth4
g statin = regexm(rxddrug,"STATIN$")
g oraldmrx = regexm(rxddrug,"METFORMIN$") | regexm(rxddrug,"^METFORMIN") | regexm(rxddrug,"GLIPIZIDE$") | regexm(rxddrug,"^GLIPIZIDE") | regexm(rxddrug,"^GLITAZONE") | regexm(rxddrug,"GLITAZONE$")
g anticoag = regexm(rxddrug,"WARFARIN$") | regexm(rxddrug,"^WARFARIN") | regexm(rxddrug,"COUMADIN$") | regexm(rxddrug,"^COUMADIN")
g asa = regexm(rxddrug,"ASPIRIN$") | regexm(rxddrug,"^ASPIRIN") 

sort seqn
collapse (max) bpmeds statin oraldmrx anticoag asa, by(seqn) cw
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn

save nhanesnutr0304, replace

use "/Users/sbasu/Data/NHANES/Linked NDI/NHANES_2003_2004_MORT_2011_PUBLIC.dta"
sort seqn
merge seqn using nhanesnutr0304
drop _merge
sort seqn
save nhanesnutr0304, replace



fdause "/Users/sbasu/Data/NHANES/2003-2004/DR1IFF_C.XPT",  clear	

 * kcals by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., kcal11 = milks and milk drinks
  g kcal11 = dr1ikcal if (dr1ifdcd>=11000000 & dr1ifdcd<12000000)
  g kcal12 = dr1ikcal if (dr1ifdcd>=12000000 & dr1ifdcd<13000000)
  g kcal13 = dr1ikcal if (dr1ifdcd>=13000000 & dr1ifdcd<14000000)
  g kcal14 = dr1ikcal if (dr1ifdcd>=14000000 & dr1ifdcd<15000000)

  g kcal20 = dr1ikcal if (dr1ifdcd>=20000000 & dr1ifdcd<21000000)
  g kcal21 = dr1ikcal if (dr1ifdcd>=21000000 & dr1ifdcd<22000000)
  g kcal22 = dr1ikcal if (dr1ifdcd>=22000000 & dr1ifdcd<23000000)
  g kcal23 = dr1ikcal if (dr1ifdcd>=23000000 & dr1ifdcd<24000000)
  g kcal24 = dr1ikcal if (dr1ifdcd>=24000000 & dr1ifdcd<25000000)
  g kcal25 = dr1ikcal if (dr1ifdcd>=25000000 & dr1ifdcd<26000000)
  g kcal26 = dr1ikcal if (dr1ifdcd>=26000000 & dr1ifdcd<27000000)
  g kcal27 = dr1ikcal if (dr1ifdcd>=27000000 & dr1ifdcd<28000000)
  g kcal28 = dr1ikcal if (dr1ifdcd>=28000000 & dr1ifdcd<29000000)

  g kcal31 = dr1ikcal if (dr1ifdcd>=31000000 & dr1ifdcd<32000000)
  g kcal32 = dr1ikcal if (dr1ifdcd>=32000000 & dr1ifdcd<33000000)
  g kcal33 = dr1ikcal if (dr1ifdcd>=33000000 & dr1ifdcd<34000000)
  g kcal35 = dr1ikcal if (dr1ifdcd>=34000000 & dr1ifdcd<35000000)

  g kcal41 = dr1ikcal if (dr1ifdcd>=41000000 & dr1ifdcd<42000000)
  g kcal42 = dr1ikcal if (dr1ifdcd>=42000000 & dr1ifdcd<43000000)
  g kcal43 = dr1ikcal if (dr1ifdcd>=43000000 & dr1ifdcd<44000000)
  g kcal44 = dr1ikcal if (dr1ifdcd>=44000000 & dr1ifdcd<45000000)

  g kcal50 = dr1ikcal if (dr1ifdcd>=50000000 & dr1ifdcd<51000000)
  g kcal51 = dr1ikcal if (dr1ifdcd>=51000000 & dr1ifdcd<52000000)
  g kcal52 = dr1ikcal if (dr1ifdcd>=52000000 & dr1ifdcd<53000000)
  g kcal53 = dr1ikcal if (dr1ifdcd>=53000000 & dr1ifdcd<54000000)
  g kcal54 = dr1ikcal if (dr1ifdcd>=54000000 & dr1ifdcd<55000000)
  g kcal55 = dr1ikcal if (dr1ifdcd>=55000000 & dr1ifdcd<56000000)
  g kcal56 = dr1ikcal if (dr1ifdcd>=56000000 & dr1ifdcd<57000000)
  g kcal57 = dr1ikcal if (dr1ifdcd>=57000000 & dr1ifdcd<58000000)
  g kcal58 = dr1ikcal if (dr1ifdcd>=58000000 & dr1ifdcd<59000000)
  g kcal59 = dr1ikcal if (dr1ifdcd>=59000000 & dr1ifdcd<60000000)

  g kcal61 = dr1ikcal if (dr1ifdcd>=61000000 & dr1ifdcd<62000000)
  g kcal62 = dr1ikcal if (dr1ifdcd>=62000000 & dr1ifdcd<63000000)
  g kcal63 = dr1ikcal if (dr1ifdcd>=63000000 & dr1ifdcd<64000000)
  g kcal64 = dr1ikcal if (dr1ifdcd>=64000000 & dr1ifdcd<65000000)
  g kcal67 = dr1ikcal if (dr1ifdcd>=67000000 & dr1ifdcd<68000000)

  g kcal71 = dr1ikcal if (dr1ifdcd>=71000000 & dr1ifdcd<72000000)
  g kcal72 = dr1ikcal if (dr1ifdcd>=72000000 & dr1ifdcd<73000000)
  g kcal73 = dr1ikcal if (dr1ifdcd>=73000000 & dr1ifdcd<74000000)
  g kcal74 = dr1ikcal if (dr1ifdcd>=74000000 & dr1ifdcd<75000000)
  g kcal75 = dr1ikcal if (dr1ifdcd>=75000000 & dr1ifdcd<76000000)
  g kcal76 = dr1ikcal if (dr1ifdcd>=76000000 & dr1ifdcd<77000000)
  g kcal77 = dr1ikcal if (dr1ifdcd>=77000000 & dr1ifdcd<78000000)
  g kcal78 = dr1ikcal if (dr1ifdcd>=78000000 & dr1ifdcd<79000000)

  g kcal81 = dr1ikcal if (dr1ifdcd>=81000000 & dr1ifdcd<82000000)
  g kcal82 = dr1ikcal if (dr1ifdcd>=82000000 & dr1ifdcd<83000000)
  g kcal83 = dr1ikcal if (dr1ifdcd>=83000000 & dr1ifdcd<84000000)

  g kcal91 = dr1ikcal if (dr1ifdcd>=91000000 & dr1ifdcd<92000000)
  g kcal92 = dr1ikcal if (dr1ifdcd>=92000000 & dr1ifdcd<93000000)
  g kcal93 = dr1ikcal if (dr1ifdcd>=93000000 & dr1ifdcd<94000000)
  g kcal94 = dr1ikcal if (dr1ifdcd>=94000000 & dr1ifdcd<95000000)
  g kcal95 = dr1ikcal if (dr1ifdcd>=95000000 & dr1ifdcd<96000000)

  
  
 * grams by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., gram11 = milks and milk drinks
  g gram11 = dr1igrms if (dr1ifdcd>=11000000 & dr1ifdcd<12000000)
  g gram12 = dr1igrms if (dr1ifdcd>=12000000 & dr1ifdcd<13000000)
  g gram13 = dr1igrms if (dr1ifdcd>=13000000 & dr1ifdcd<14000000)
  g gram14 = dr1igrms if (dr1ifdcd>=14000000 & dr1ifdcd<15000000)

  g gram20 = dr1igrms if (dr1ifdcd>=20000000 & dr1ifdcd<21000000)
  g gram21 = dr1igrms if (dr1ifdcd>=21000000 & dr1ifdcd<22000000)
  g gram22 = dr1igrms if (dr1ifdcd>=22000000 & dr1ifdcd<23000000)
  g gram23 = dr1igrms if (dr1ifdcd>=23000000 & dr1ifdcd<24000000)
  g gram24 = dr1igrms if (dr1ifdcd>=24000000 & dr1ifdcd<25000000)
  g gram25 = dr1igrms if (dr1ifdcd>=25000000 & dr1ifdcd<26000000)
  g gram26 = dr1igrms if (dr1ifdcd>=26000000 & dr1ifdcd<27000000)
  g gram27 = dr1igrms if (dr1ifdcd>=27000000 & dr1ifdcd<28000000)
  g gram28 = dr1igrms if (dr1ifdcd>=28000000 & dr1ifdcd<29000000)

  g gram31 = dr1igrms if (dr1ifdcd>=31000000 & dr1ifdcd<32000000)
  g gram32 = dr1igrms if (dr1ifdcd>=32000000 & dr1ifdcd<33000000)
  g gram33 = dr1igrms if (dr1ifdcd>=33000000 & dr1ifdcd<34000000)
  g gram35 = dr1igrms if (dr1ifdcd>=34000000 & dr1ifdcd<35000000)

  g gram41 = dr1igrms if (dr1ifdcd>=41000000 & dr1ifdcd<42000000)
  g gram42 = dr1igrms if (dr1ifdcd>=42000000 & dr1ifdcd<43000000)
  g gram43 = dr1igrms if (dr1ifdcd>=43000000 & dr1ifdcd<44000000)
  g gram44 = dr1igrms if (dr1ifdcd>=44000000 & dr1ifdcd<45000000)

  g gram50 = dr1igrms if (dr1ifdcd>=50000000 & dr1ifdcd<51000000)
  g gram51 = dr1igrms if (dr1ifdcd>=51000000 & dr1ifdcd<52000000)
  g gram52 = dr1igrms if (dr1ifdcd>=52000000 & dr1ifdcd<53000000)
  g gram53 = dr1igrms if (dr1ifdcd>=53000000 & dr1ifdcd<54000000)
  g gram54 = dr1igrms if (dr1ifdcd>=54000000 & dr1ifdcd<55000000)
  g gram55 = dr1igrms if (dr1ifdcd>=55000000 & dr1ifdcd<56000000)
  g gram56 = dr1igrms if (dr1ifdcd>=56000000 & dr1ifdcd<57000000)
  g gram57 = dr1igrms if (dr1ifdcd>=57000000 & dr1ifdcd<58000000)
  g gram58 = dr1igrms if (dr1ifdcd>=58000000 & dr1ifdcd<59000000)
  g gram59 = dr1igrms if (dr1ifdcd>=59000000 & dr1ifdcd<60000000)

  g gram61 = dr1igrms if (dr1ifdcd>=61000000 & dr1ifdcd<62000000)
  g gram62 = dr1igrms if (dr1ifdcd>=62000000 & dr1ifdcd<63000000)
  g gram63 = dr1igrms if (dr1ifdcd>=63000000 & dr1ifdcd<64000000)
  g gram64 = dr1igrms if (dr1ifdcd>=64000000 & dr1ifdcd<65000000)
  g gram67 = dr1igrms if (dr1ifdcd>=67000000 & dr1ifdcd<68000000)

  g gram71 = dr1igrms if (dr1ifdcd>=71000000 & dr1ifdcd<72000000)
  g gram72 = dr1igrms if (dr1ifdcd>=72000000 & dr1ifdcd<73000000)
  g gram73 = dr1igrms if (dr1ifdcd>=73000000 & dr1ifdcd<74000000)
  g gram74 = dr1igrms if (dr1ifdcd>=74000000 & dr1ifdcd<75000000)
  g gram75 = dr1igrms if (dr1ifdcd>=75000000 & dr1ifdcd<76000000)
  g gram76 = dr1igrms if (dr1ifdcd>=76000000 & dr1ifdcd<77000000)
  g gram77 = dr1igrms if (dr1ifdcd>=77000000 & dr1ifdcd<78000000)
  g gram78 = dr1igrms if (dr1ifdcd>=78000000 & dr1ifdcd<79000000)

  g gram81 = dr1igrms if (dr1ifdcd>=81000000 & dr1ifdcd<82000000)
  g gram82 = dr1igrms if (dr1ifdcd>=82000000 & dr1ifdcd<83000000)
  g gram83 = dr1igrms if (dr1ifdcd>=83000000 & dr1ifdcd<84000000)

  g gram91 = dr1igrms if (dr1ifdcd>=91000000 & dr1ifdcd<92000000)
  g gram92 = dr1igrms if (dr1ifdcd>=92000000 & dr1ifdcd<93000000)
  g gram93 = dr1igrms if (dr1ifdcd>=93000000 & dr1ifdcd<94000000)
  g gram94 = dr1igrms if (dr1ifdcd>=94000000 & dr1ifdcd<95000000)
  g gram95 = dr1igrms if (dr1ifdcd>=95000000 & dr1ifdcd<96000000)

  

 collapse (sum) kcal11 kcal12 kcal13 kcal14 kcal20 kcal21 kcal22 kcal23 kcal24 kcal25 kcal26 kcal27 kcal28 kcal31 kcal32 kcal33 kcal35 kcal41 kcal42 kcal43 kcal44 kcal50 kcal51 kcal52 kcal53 kcal54 kcal55 kcal56 kcal57 kcal58 kcal59 kcal61 kcal62 kcal63 kcal64 kcal67 kcal71 kcal72 kcal73 kcal74 kcal75 kcal76 kcal77 kcal78 kcal81 kcal82 kcal83 kcal91 kcal92 kcal93 kcal94 kcal95 gram11 gram12 gram13 gram14 gram20 gram21 gram22 gram23 gram24 gram25 gram26 gram27 gram28 gram31 gram32 gram33 gram35 gram41 gram42 gram43 gram44 gram50 gram51 gram52 gram53 gram54 gram55 gram56 gram57 gram58 gram59 gram61 gram62 gram63 gram64 gram67 gram71 gram72 gram73 gram74 gram75 gram76 gram77 gram78 gram81 gram82 gram83 gram91 gram92 gram93 gram94 gram95, by(seqn) 
  sort seqn
merge seqn using nhanesnutr0304
drop _merge
 sort seqn
save nhanesnutr0304, replace




* age, in yrs
g age = ridageyr

* sex, 0 = male, 1 = female
g sex =  riagendr-1

* black, 0 = white, 1 = black
g black = 0 if ridreth1==3
replace black = 1 if ridreth1==4

* hisp, 0 = nonhisp, 1 = hisp
g hisp = 1 if ridreth1<3
replace hisp = 0 if ridreth1>=3


* sbp and dbp, in mmhg

foreach i in bpxsy1 bpxsy2 bpxsy3 bpxsy4 {
    replace `i' =. if `i'==0
}

gen n_sbp= !missing(bpxsy1)+ !missing(bpxsy2)+ !missing(bpxsy3)+ !missing(bpxsy4)

egen sbp = rowmean(bpxsy1 bpxsy2 bpxsy3 bpxsy4)


* dm is diabetes status, by L a1c or fbg or self-report or meds
g a1c = lbxgh
gen dm =1 if ((lbxgh>=6.5) | (lbxglu>=126)) | (diq010==1) | (diq050==1)
replace dm = 0 if dm!=1 


* egfr by CKD-EPI equation
g screat = lbxscr
g ualbcr = urxuma/urxucr*1000
g egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age) if sex==0 & black==0
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018 if sex==1 & black==0
replace egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.159 if sex==0 & black==1
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018*1.159 if sex==1 & black==1

* tob is current smoker, 1 = current 
g tob = 1 if smq040<=2
replace tob = 0 if (smq040==. | smq040==3)

* totchol and ldl are total and ldl cholesterol, in mg/dl
g hdl = lbdhdd
g totchol = lbxtc

*MI or stroke history
g cvdhx =1  if (mcq160e==1)|(mcq160f==1)
replace cvdhx = 0 if cvdhx!=1

g cvddeath = 1 if mortstat==1 & (ucod_leading=="001" | ucod_leading=="005")
replace cvddeath = 0 if cvddeath!=1
 
 
cd "/Users/sbasu/Data/NHANES"
export delimited using "nhanesnutr0304", replace





clear
fdause "/Users/sbasu/Data/NHANES/2005-2006/DEMO_D.xpt"
sort seqn
save nhanesnutr0506, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2005-2006/BMX_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2005-2006/BPQ_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2005-2006/BPX_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2005-2006/MCQ_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2005-2006/ALB_CR_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear
fdause "/Users/sbasu/Data/NHANES/2005-2006/BIOPRO_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear
fdause "/Users/sbasu/Data/NHANES/2005-2006/GHB_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear
fdause "/Users/sbasu/Data/NHANES/2005-2006/GLU_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear
fdause "/Users/sbasu/Data/NHANES/2005-2006/DIQ_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear
fdause "/Users/sbasu/Data/NHANES/2005-2006/SMQ_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
clear
fdause "/Users/sbasu/Data/NHANES/2005-2006/HDL_D.xpt"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
fdause "/Users/sbasu/Data/NHANES/2005-2006/TCHOL_D.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace
fdause "/Users/sbasu/Data/NHANES/2005-2006/SMQ_D.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace


fdause "/Users/sbasu/Data/NHANES/2005-2006/DR1TOT_D.XPT",  clear	
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace



import sasxport "/Users/sbasu/Data/NHANES/2005-2006/RXQ_RX_D.xpt", clear
sort seqn
save nhanesdrug0506, replace
import sasxport "/Users/sbasu/Data/NHANES/2005-2006/RXQ_DRUG.xpt", clear
merge m:m rxddrgid using nhanesdrug0506
drop _merge


*med list
g byte acei = regexm(rxddrug, "PRIL$")
g byte ace2 = regexm(rxddrug, "^BENAZEPRIL")
replace ace2 = 0 if acei==1
g byte arb = regexm(rxddrug, "SARTAN$")
g byte bb = regexm(rxddrug, "OLOL$")
g byte bb2 = regexm(rxddrug, "CARVEDILOL$")
g byte bb3 = regexm(rxddrug, "SOTALOL")
g byte ccb = regexm(rxddrug,"DIPINE$")
g byte ccb2 = regexm(rxddrug,"DILTIAZEM")
g byte ccb3 = regexm(rxddrug,"PAMIL$")
g byte ccb4 = regexm(rxddrug,"^AMLODIPINE")
replace ccb4 = 0 if ccb==1
g byte thi = regexm(rxddrug,"^HYDROCHLOROTHIAZIDE")
g byte thi2 = regexm(rxddrug,"THIAZIDE$")
replace thi2 = 0 if thi==1
g byte oth = regexm(rxddrug,"HYDRALAZINE")
g byte oth2 = regexm(rxddrug,"TRIAMTERENE")
g byte oth3 = regexm(rxddrug,"ANTIHYPERTENSIVE AGENT")
g byte oth4 = regexm(rxddrug,"CLONIDINE")

g bpmeds = acei+ace2+arb+bb+bb2+bb3+ccb+ccb2+ccb3+ccb4+thi+thi2+oth+oth2+oth3+oth4
g statin = regexm(rxddrug,"STATIN$")
g oraldmrx = regexm(rxddrug,"METFORMIN$") | regexm(rxddrug,"^METFORMIN") | regexm(rxddrug,"GLIPIZIDE$") | regexm(rxddrug,"^GLIPIZIDE") | regexm(rxddrug,"^GLITAZONE") | regexm(rxddrug,"GLITAZONE$")
g anticoag = regexm(rxddrug,"WARFARIN$") | regexm(rxddrug,"^WARFARIN") | regexm(rxddrug,"COUMADIN$") | regexm(rxddrug,"^COUMADIN")
g asa = regexm(rxddrug,"ASPIRIN$") | regexm(rxddrug,"^ASPIRIN") 

sort seqn
collapse (max) bpmeds statin oraldmrx anticoag asa, by(seqn) cw
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn

save nhanesnutr0506, replace


use "/Users/sbasu/Data/NHANES/Linked NDI/NHANES_2005_2006_MORT_2011_PUBLIC.dta"
sort seqn
merge seqn using nhanesnutr0506
drop _merge
sort seqn
save nhanesnutr0506, replace



fdause "/Users/sbasu/Data/NHANES/2005-2006/DR1IFF_D.XPT",  clear	


* kcals by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., kcal11 = milks and milk drinks
  g kcal11 = dr1ikcal if (dr1ifdcd>=11000000 & dr1ifdcd<12000000)
  g kcal12 = dr1ikcal if (dr1ifdcd>=12000000 & dr1ifdcd<13000000)
  g kcal13 = dr1ikcal if (dr1ifdcd>=13000000 & dr1ifdcd<14000000)
  g kcal14 = dr1ikcal if (dr1ifdcd>=14000000 & dr1ifdcd<15000000)

  g kcal20 = dr1ikcal if (dr1ifdcd>=20000000 & dr1ifdcd<21000000)
  g kcal21 = dr1ikcal if (dr1ifdcd>=21000000 & dr1ifdcd<22000000)
  g kcal22 = dr1ikcal if (dr1ifdcd>=22000000 & dr1ifdcd<23000000)
  g kcal23 = dr1ikcal if (dr1ifdcd>=23000000 & dr1ifdcd<24000000)
  g kcal24 = dr1ikcal if (dr1ifdcd>=24000000 & dr1ifdcd<25000000)
  g kcal25 = dr1ikcal if (dr1ifdcd>=25000000 & dr1ifdcd<26000000)
  g kcal26 = dr1ikcal if (dr1ifdcd>=26000000 & dr1ifdcd<27000000)
  g kcal27 = dr1ikcal if (dr1ifdcd>=27000000 & dr1ifdcd<28000000)
  g kcal28 = dr1ikcal if (dr1ifdcd>=28000000 & dr1ifdcd<29000000)

  g kcal31 = dr1ikcal if (dr1ifdcd>=31000000 & dr1ifdcd<32000000)
  g kcal32 = dr1ikcal if (dr1ifdcd>=32000000 & dr1ifdcd<33000000)
  g kcal33 = dr1ikcal if (dr1ifdcd>=33000000 & dr1ifdcd<34000000)
  g kcal35 = dr1ikcal if (dr1ifdcd>=34000000 & dr1ifdcd<35000000)

  g kcal41 = dr1ikcal if (dr1ifdcd>=41000000 & dr1ifdcd<42000000)
  g kcal42 = dr1ikcal if (dr1ifdcd>=42000000 & dr1ifdcd<43000000)
  g kcal43 = dr1ikcal if (dr1ifdcd>=43000000 & dr1ifdcd<44000000)
  g kcal44 = dr1ikcal if (dr1ifdcd>=44000000 & dr1ifdcd<45000000)

  g kcal50 = dr1ikcal if (dr1ifdcd>=50000000 & dr1ifdcd<51000000)
  g kcal51 = dr1ikcal if (dr1ifdcd>=51000000 & dr1ifdcd<52000000)
  g kcal52 = dr1ikcal if (dr1ifdcd>=52000000 & dr1ifdcd<53000000)
  g kcal53 = dr1ikcal if (dr1ifdcd>=53000000 & dr1ifdcd<54000000)
  g kcal54 = dr1ikcal if (dr1ifdcd>=54000000 & dr1ifdcd<55000000)
  g kcal55 = dr1ikcal if (dr1ifdcd>=55000000 & dr1ifdcd<56000000)
  g kcal56 = dr1ikcal if (dr1ifdcd>=56000000 & dr1ifdcd<57000000)
  g kcal57 = dr1ikcal if (dr1ifdcd>=57000000 & dr1ifdcd<58000000)
  g kcal58 = dr1ikcal if (dr1ifdcd>=58000000 & dr1ifdcd<59000000)
  g kcal59 = dr1ikcal if (dr1ifdcd>=59000000 & dr1ifdcd<60000000)

  g kcal61 = dr1ikcal if (dr1ifdcd>=61000000 & dr1ifdcd<62000000)
  g kcal62 = dr1ikcal if (dr1ifdcd>=62000000 & dr1ifdcd<63000000)
  g kcal63 = dr1ikcal if (dr1ifdcd>=63000000 & dr1ifdcd<64000000)
  g kcal64 = dr1ikcal if (dr1ifdcd>=64000000 & dr1ifdcd<65000000)
  g kcal67 = dr1ikcal if (dr1ifdcd>=67000000 & dr1ifdcd<68000000)

  g kcal71 = dr1ikcal if (dr1ifdcd>=71000000 & dr1ifdcd<72000000)
  g kcal72 = dr1ikcal if (dr1ifdcd>=72000000 & dr1ifdcd<73000000)
  g kcal73 = dr1ikcal if (dr1ifdcd>=73000000 & dr1ifdcd<74000000)
  g kcal74 = dr1ikcal if (dr1ifdcd>=74000000 & dr1ifdcd<75000000)
  g kcal75 = dr1ikcal if (dr1ifdcd>=75000000 & dr1ifdcd<76000000)
  g kcal76 = dr1ikcal if (dr1ifdcd>=76000000 & dr1ifdcd<77000000)
  g kcal77 = dr1ikcal if (dr1ifdcd>=77000000 & dr1ifdcd<78000000)
  g kcal78 = dr1ikcal if (dr1ifdcd>=78000000 & dr1ifdcd<79000000)

  g kcal81 = dr1ikcal if (dr1ifdcd>=81000000 & dr1ifdcd<82000000)
  g kcal82 = dr1ikcal if (dr1ifdcd>=82000000 & dr1ifdcd<83000000)
  g kcal83 = dr1ikcal if (dr1ifdcd>=83000000 & dr1ifdcd<84000000)

  g kcal91 = dr1ikcal if (dr1ifdcd>=91000000 & dr1ifdcd<92000000)
  g kcal92 = dr1ikcal if (dr1ifdcd>=92000000 & dr1ifdcd<93000000)
  g kcal93 = dr1ikcal if (dr1ifdcd>=93000000 & dr1ifdcd<94000000)
  g kcal94 = dr1ikcal if (dr1ifdcd>=94000000 & dr1ifdcd<95000000)
  g kcal95 = dr1ikcal if (dr1ifdcd>=95000000 & dr1ifdcd<96000000)

  
  
 * grams by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., gram11 = milks and milk drinks
  g gram11 = dr1igrms if (dr1ifdcd>=11000000 & dr1ifdcd<12000000)
  g gram12 = dr1igrms if (dr1ifdcd>=12000000 & dr1ifdcd<13000000)
  g gram13 = dr1igrms if (dr1ifdcd>=13000000 & dr1ifdcd<14000000)
  g gram14 = dr1igrms if (dr1ifdcd>=14000000 & dr1ifdcd<15000000)

  g gram20 = dr1igrms if (dr1ifdcd>=20000000 & dr1ifdcd<21000000)
  g gram21 = dr1igrms if (dr1ifdcd>=21000000 & dr1ifdcd<22000000)
  g gram22 = dr1igrms if (dr1ifdcd>=22000000 & dr1ifdcd<23000000)
  g gram23 = dr1igrms if (dr1ifdcd>=23000000 & dr1ifdcd<24000000)
  g gram24 = dr1igrms if (dr1ifdcd>=24000000 & dr1ifdcd<25000000)
  g gram25 = dr1igrms if (dr1ifdcd>=25000000 & dr1ifdcd<26000000)
  g gram26 = dr1igrms if (dr1ifdcd>=26000000 & dr1ifdcd<27000000)
  g gram27 = dr1igrms if (dr1ifdcd>=27000000 & dr1ifdcd<28000000)
  g gram28 = dr1igrms if (dr1ifdcd>=28000000 & dr1ifdcd<29000000)

  g gram31 = dr1igrms if (dr1ifdcd>=31000000 & dr1ifdcd<32000000)
  g gram32 = dr1igrms if (dr1ifdcd>=32000000 & dr1ifdcd<33000000)
  g gram33 = dr1igrms if (dr1ifdcd>=33000000 & dr1ifdcd<34000000)
  g gram35 = dr1igrms if (dr1ifdcd>=34000000 & dr1ifdcd<35000000)

  g gram41 = dr1igrms if (dr1ifdcd>=41000000 & dr1ifdcd<42000000)
  g gram42 = dr1igrms if (dr1ifdcd>=42000000 & dr1ifdcd<43000000)
  g gram43 = dr1igrms if (dr1ifdcd>=43000000 & dr1ifdcd<44000000)
  g gram44 = dr1igrms if (dr1ifdcd>=44000000 & dr1ifdcd<45000000)

  g gram50 = dr1igrms if (dr1ifdcd>=50000000 & dr1ifdcd<51000000)
  g gram51 = dr1igrms if (dr1ifdcd>=51000000 & dr1ifdcd<52000000)
  g gram52 = dr1igrms if (dr1ifdcd>=52000000 & dr1ifdcd<53000000)
  g gram53 = dr1igrms if (dr1ifdcd>=53000000 & dr1ifdcd<54000000)
  g gram54 = dr1igrms if (dr1ifdcd>=54000000 & dr1ifdcd<55000000)
  g gram55 = dr1igrms if (dr1ifdcd>=55000000 & dr1ifdcd<56000000)
  g gram56 = dr1igrms if (dr1ifdcd>=56000000 & dr1ifdcd<57000000)
  g gram57 = dr1igrms if (dr1ifdcd>=57000000 & dr1ifdcd<58000000)
  g gram58 = dr1igrms if (dr1ifdcd>=58000000 & dr1ifdcd<59000000)
  g gram59 = dr1igrms if (dr1ifdcd>=59000000 & dr1ifdcd<60000000)

  g gram61 = dr1igrms if (dr1ifdcd>=61000000 & dr1ifdcd<62000000)
  g gram62 = dr1igrms if (dr1ifdcd>=62000000 & dr1ifdcd<63000000)
  g gram63 = dr1igrms if (dr1ifdcd>=63000000 & dr1ifdcd<64000000)
  g gram64 = dr1igrms if (dr1ifdcd>=64000000 & dr1ifdcd<65000000)
  g gram67 = dr1igrms if (dr1ifdcd>=67000000 & dr1ifdcd<68000000)

  g gram71 = dr1igrms if (dr1ifdcd>=71000000 & dr1ifdcd<72000000)
  g gram72 = dr1igrms if (dr1ifdcd>=72000000 & dr1ifdcd<73000000)
  g gram73 = dr1igrms if (dr1ifdcd>=73000000 & dr1ifdcd<74000000)
  g gram74 = dr1igrms if (dr1ifdcd>=74000000 & dr1ifdcd<75000000)
  g gram75 = dr1igrms if (dr1ifdcd>=75000000 & dr1ifdcd<76000000)
  g gram76 = dr1igrms if (dr1ifdcd>=76000000 & dr1ifdcd<77000000)
  g gram77 = dr1igrms if (dr1ifdcd>=77000000 & dr1ifdcd<78000000)
  g gram78 = dr1igrms if (dr1ifdcd>=78000000 & dr1ifdcd<79000000)

  g gram81 = dr1igrms if (dr1ifdcd>=81000000 & dr1ifdcd<82000000)
  g gram82 = dr1igrms if (dr1ifdcd>=82000000 & dr1ifdcd<83000000)
  g gram83 = dr1igrms if (dr1ifdcd>=83000000 & dr1ifdcd<84000000)

  g gram91 = dr1igrms if (dr1ifdcd>=91000000 & dr1ifdcd<92000000)
  g gram92 = dr1igrms if (dr1ifdcd>=92000000 & dr1ifdcd<93000000)
  g gram93 = dr1igrms if (dr1ifdcd>=93000000 & dr1ifdcd<94000000)
  g gram94 = dr1igrms if (dr1ifdcd>=94000000 & dr1ifdcd<95000000)
  g gram95 = dr1igrms if (dr1ifdcd>=95000000 & dr1ifdcd<96000000)

  

 collapse (sum) kcal11 kcal12 kcal13 kcal14 kcal20 kcal21 kcal22 kcal23 kcal24 kcal25 kcal26 kcal27 kcal28 kcal31 kcal32 kcal33 kcal35 kcal41 kcal42 kcal43 kcal44 kcal50 kcal51 kcal52 kcal53 kcal54 kcal55 kcal56 kcal57 kcal58 kcal59 kcal61 kcal62 kcal63 kcal64 kcal67 kcal71 kcal72 kcal73 kcal74 kcal75 kcal76 kcal77 kcal78 kcal81 kcal82 kcal83 kcal91 kcal92 kcal93 kcal94 kcal95 gram11 gram12 gram13 gram14 gram20 gram21 gram22 gram23 gram24 gram25 gram26 gram27 gram28 gram31 gram32 gram33 gram35 gram41 gram42 gram43 gram44 gram50 gram51 gram52 gram53 gram54 gram55 gram56 gram57 gram58 gram59 gram61 gram62 gram63 gram64 gram67 gram71 gram72 gram73 gram74 gram75 gram76 gram77 gram78 gram81 gram82 gram83 gram91 gram92 gram93 gram94 gram95, by(seqn) 
  sort seqn
merge seqn using nhanesnutr0506
drop _merge
 sort seqn
save nhanesnutr0506, replace


use nhanesnutr0506, clear

* age, in yrs
g age = ridageyr

* sex, 0 = male, 1 = female
g sex =  riagendr-1

* black, 0 = white, 1 = black
g black = 0 if ridreth1==3
replace black = 1 if ridreth1==4

* hisp, 0 = nonhisp, 1 = hisp
g hisp = 1 if ridreth1<3
replace hisp = 0 if ridreth1>=3


* sbp and dbp, in mmhg

foreach i in bpxsy1 bpxsy2 bpxsy3 bpxsy4 {
    replace `i' =. if `i'==0
}

gen n_sbp= !missing(bpxsy1)+ !missing(bpxsy2)+ !missing(bpxsy3)+ !missing(bpxsy4)

egen sbp = rowmean(bpxsy1 bpxsy2 bpxsy3 bpxsy4)


* dm is diabetes status, by L a1c or fbg or self-report or meds
g a1c = lbxgh
gen dm =1 if ((lbxgh>=6.5) | (lbxglu>=126)) | (diq010==1) | (diq050==1)
replace dm = 0 if dm!=1 


* egfr by CKD-EPI equation
g screat = lbxscr
g ualbcr = urxuma/urxucr*1000
g egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age) if sex==0 & black==0
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018 if sex==1 & black==0
replace egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.159 if sex==0 & black==1
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018*1.159 if sex==1 & black==1

* tob is current smoker, 1 = current 
g tob = 1 if smq040<=2
replace tob = 0 if (smq040==. | smq040==3)

* totchol and ldl are total and ldl cholesterol, in mg/dl
g hdl = lbdhdd
g totchol = lbxtc

*MI or stroke history
g cvdhx =1  if (mcq160e==1)|(mcq160f==1)
replace cvdhx = 0 if cvdhx!=1

g cvddeath = 1 if mortstat==1 & (ucod_leading=="001" | ucod_leading=="005")
replace cvddeath = 0 if cvddeath!=1
 
 
cd "/Users/sbasu/Data/NHANES"
export delimited using "nhanesnutr0506", replace




clear
fdause "/Users/sbasu/Data/NHANES/2007-2008/DEMO_E.xpt"
sort seqn
save nhanesnutr0708, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2007-2008/BMX_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2007-2008/BPQ_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2007-2008/BPX_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2007-2008/MCQ_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2007-2008/ALB_CR_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear
fdause "/Users/sbasu/Data/NHANES/2007-2008/BIOPRO_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear
fdause "/Users/sbasu/Data/NHANES/2007-2008/GHB_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear
fdause "/Users/sbasu/Data/NHANES/2007-2008/GLU_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear
fdause "/Users/sbasu/Data/NHANES/2007-2008/DIQ_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear
fdause "/Users/sbasu/Data/NHANES/2007-2008/SMQ_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
clear
fdause "/Users/sbasu/Data/NHANES/2007-2008/HDL_E.xpt"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
fdause "/Users/sbasu/Data/NHANES/2007-2008/TCHOL_E.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace
fdause "/Users/sbasu/Data/NHANES/2007-2008/SMQ_E.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace

fdause "/Users/sbasu/Data/NHANES/2007-2008/DR1TOT_E.XPT",  clear	
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace



import sasxport "/Users/sbasu/Data/NHANES/2007-2008/RXQ_RX_E.xpt", clear
sort seqn
save nhanesdrug0708, replace
import sasxport "/Users/sbasu/Data/NHANES/2007-2008/RXQ_DRUG.xpt", clear
merge m:m rxddrgid using nhanesdrug0708
drop _merge


*med list
g byte acei = regexm(rxddrug, "PRIL$")
g byte ace2 = regexm(rxddrug, "^BENAZEPRIL")
replace ace2 = 0 if acei==1
g byte arb = regexm(rxddrug, "SARTAN$")
g byte bb = regexm(rxddrug, "OLOL$")
g byte bb2 = regexm(rxddrug, "CARVEDILOL$")
g byte bb3 = regexm(rxddrug, "SOTALOL")
g byte ccb = regexm(rxddrug,"DIPINE$")
g byte ccb2 = regexm(rxddrug,"DILTIAZEM")
g byte ccb3 = regexm(rxddrug,"PAMIL$")
g byte ccb4 = regexm(rxddrug,"^AMLODIPINE")
replace ccb4 = 0 if ccb==1
g byte thi = regexm(rxddrug,"^HYDROCHLOROTHIAZIDE")
g byte thi2 = regexm(rxddrug,"THIAZIDE$")
replace thi2 = 0 if thi==1
g byte oth = regexm(rxddrug,"HYDRALAZINE")
g byte oth2 = regexm(rxddrug,"TRIAMTERENE")
g byte oth3 = regexm(rxddrug,"ANTIHYPERTENSIVE AGENT")
g byte oth4 = regexm(rxddrug,"CLONIDINE")

g bpmeds = acei+ace2+arb+bb+bb2+bb3+ccb+ccb2+ccb3+ccb4+thi+thi2+oth+oth2+oth3+oth4
g statin = regexm(rxddrug,"STATIN$")
g oraldmrx = regexm(rxddrug,"METFORMIN$") | regexm(rxddrug,"^METFORMIN") | regexm(rxddrug,"GLIPIZIDE$") | regexm(rxddrug,"^GLIPIZIDE") | regexm(rxddrug,"^GLITAZONE") | regexm(rxddrug,"GLITAZONE$")
*(diq070==1)
g anticoag = regexm(rxddrug,"WARFARIN$") | regexm(rxddrug,"^WARFARIN") | regexm(rxddrug,"COUMADIN$") | regexm(rxddrug,"^COUMADIN")
g asa = regexm(rxddrug,"ASPIRIN$") | regexm(rxddrug,"^ASPIRIN") 

sort seqn
collapse (max) bpmeds statin oraldmrx anticoag asa, by(seqn) cw
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn

save nhanesnutr0708, replace


use "/Users/sbasu/Data/NHANES/Linked NDI/NHANES_2007_2008_MORT_2011_PUBLIC.dta"
sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace


fdause "/Users/sbasu/Data/NHANES/2007-2008/DR1IFF_E.XPT",  clear	


* kcals by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., kcal11 = milks and milk drinks
  g kcal11 = dr1ikcal if (dr1ifdcd>=11000000 & dr1ifdcd<12000000)
  g kcal12 = dr1ikcal if (dr1ifdcd>=12000000 & dr1ifdcd<13000000)
  g kcal13 = dr1ikcal if (dr1ifdcd>=13000000 & dr1ifdcd<14000000)
  g kcal14 = dr1ikcal if (dr1ifdcd>=14000000 & dr1ifdcd<15000000)

  g kcal20 = dr1ikcal if (dr1ifdcd>=20000000 & dr1ifdcd<21000000)
  g kcal21 = dr1ikcal if (dr1ifdcd>=21000000 & dr1ifdcd<22000000)
  g kcal22 = dr1ikcal if (dr1ifdcd>=22000000 & dr1ifdcd<23000000)
  g kcal23 = dr1ikcal if (dr1ifdcd>=23000000 & dr1ifdcd<24000000)
  g kcal24 = dr1ikcal if (dr1ifdcd>=24000000 & dr1ifdcd<25000000)
  g kcal25 = dr1ikcal if (dr1ifdcd>=25000000 & dr1ifdcd<26000000)
  g kcal26 = dr1ikcal if (dr1ifdcd>=26000000 & dr1ifdcd<27000000)
  g kcal27 = dr1ikcal if (dr1ifdcd>=27000000 & dr1ifdcd<28000000)
  g kcal28 = dr1ikcal if (dr1ifdcd>=28000000 & dr1ifdcd<29000000)

  g kcal31 = dr1ikcal if (dr1ifdcd>=31000000 & dr1ifdcd<32000000)
  g kcal32 = dr1ikcal if (dr1ifdcd>=32000000 & dr1ifdcd<33000000)
  g kcal33 = dr1ikcal if (dr1ifdcd>=33000000 & dr1ifdcd<34000000)
  g kcal35 = dr1ikcal if (dr1ifdcd>=34000000 & dr1ifdcd<35000000)

  g kcal41 = dr1ikcal if (dr1ifdcd>=41000000 & dr1ifdcd<42000000)
  g kcal42 = dr1ikcal if (dr1ifdcd>=42000000 & dr1ifdcd<43000000)
  g kcal43 = dr1ikcal if (dr1ifdcd>=43000000 & dr1ifdcd<44000000)
  g kcal44 = dr1ikcal if (dr1ifdcd>=44000000 & dr1ifdcd<45000000)

  g kcal50 = dr1ikcal if (dr1ifdcd>=50000000 & dr1ifdcd<51000000)
  g kcal51 = dr1ikcal if (dr1ifdcd>=51000000 & dr1ifdcd<52000000)
  g kcal52 = dr1ikcal if (dr1ifdcd>=52000000 & dr1ifdcd<53000000)
  g kcal53 = dr1ikcal if (dr1ifdcd>=53000000 & dr1ifdcd<54000000)
  g kcal54 = dr1ikcal if (dr1ifdcd>=54000000 & dr1ifdcd<55000000)
  g kcal55 = dr1ikcal if (dr1ifdcd>=55000000 & dr1ifdcd<56000000)
  g kcal56 = dr1ikcal if (dr1ifdcd>=56000000 & dr1ifdcd<57000000)
  g kcal57 = dr1ikcal if (dr1ifdcd>=57000000 & dr1ifdcd<58000000)
  g kcal58 = dr1ikcal if (dr1ifdcd>=58000000 & dr1ifdcd<59000000)
  g kcal59 = dr1ikcal if (dr1ifdcd>=59000000 & dr1ifdcd<60000000)

  g kcal61 = dr1ikcal if (dr1ifdcd>=61000000 & dr1ifdcd<62000000)
  g kcal62 = dr1ikcal if (dr1ifdcd>=62000000 & dr1ifdcd<63000000)
  g kcal63 = dr1ikcal if (dr1ifdcd>=63000000 & dr1ifdcd<64000000)
  g kcal64 = dr1ikcal if (dr1ifdcd>=64000000 & dr1ifdcd<65000000)
  g kcal67 = dr1ikcal if (dr1ifdcd>=67000000 & dr1ifdcd<68000000)

  g kcal71 = dr1ikcal if (dr1ifdcd>=71000000 & dr1ifdcd<72000000)
  g kcal72 = dr1ikcal if (dr1ifdcd>=72000000 & dr1ifdcd<73000000)
  g kcal73 = dr1ikcal if (dr1ifdcd>=73000000 & dr1ifdcd<74000000)
  g kcal74 = dr1ikcal if (dr1ifdcd>=74000000 & dr1ifdcd<75000000)
  g kcal75 = dr1ikcal if (dr1ifdcd>=75000000 & dr1ifdcd<76000000)
  g kcal76 = dr1ikcal if (dr1ifdcd>=76000000 & dr1ifdcd<77000000)
  g kcal77 = dr1ikcal if (dr1ifdcd>=77000000 & dr1ifdcd<78000000)
  g kcal78 = dr1ikcal if (dr1ifdcd>=78000000 & dr1ifdcd<79000000)

  g kcal81 = dr1ikcal if (dr1ifdcd>=81000000 & dr1ifdcd<82000000)
  g kcal82 = dr1ikcal if (dr1ifdcd>=82000000 & dr1ifdcd<83000000)
  g kcal83 = dr1ikcal if (dr1ifdcd>=83000000 & dr1ifdcd<84000000)

  g kcal91 = dr1ikcal if (dr1ifdcd>=91000000 & dr1ifdcd<92000000)
  g kcal92 = dr1ikcal if (dr1ifdcd>=92000000 & dr1ifdcd<93000000)
  g kcal93 = dr1ikcal if (dr1ifdcd>=93000000 & dr1ifdcd<94000000)
  g kcal94 = dr1ikcal if (dr1ifdcd>=94000000 & dr1ifdcd<95000000)
  g kcal95 = dr1ikcal if (dr1ifdcd>=95000000 & dr1ifdcd<96000000)

  
  
 * grams by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., gram11 = milks and milk drinks
  g gram11 = dr1igrms if (dr1ifdcd>=11000000 & dr1ifdcd<12000000)
  g gram12 = dr1igrms if (dr1ifdcd>=12000000 & dr1ifdcd<13000000)
  g gram13 = dr1igrms if (dr1ifdcd>=13000000 & dr1ifdcd<14000000)
  g gram14 = dr1igrms if (dr1ifdcd>=14000000 & dr1ifdcd<15000000)

  g gram20 = dr1igrms if (dr1ifdcd>=20000000 & dr1ifdcd<21000000)
  g gram21 = dr1igrms if (dr1ifdcd>=21000000 & dr1ifdcd<22000000)
  g gram22 = dr1igrms if (dr1ifdcd>=22000000 & dr1ifdcd<23000000)
  g gram23 = dr1igrms if (dr1ifdcd>=23000000 & dr1ifdcd<24000000)
  g gram24 = dr1igrms if (dr1ifdcd>=24000000 & dr1ifdcd<25000000)
  g gram25 = dr1igrms if (dr1ifdcd>=25000000 & dr1ifdcd<26000000)
  g gram26 = dr1igrms if (dr1ifdcd>=26000000 & dr1ifdcd<27000000)
  g gram27 = dr1igrms if (dr1ifdcd>=27000000 & dr1ifdcd<28000000)
  g gram28 = dr1igrms if (dr1ifdcd>=28000000 & dr1ifdcd<29000000)

  g gram31 = dr1igrms if (dr1ifdcd>=31000000 & dr1ifdcd<32000000)
  g gram32 = dr1igrms if (dr1ifdcd>=32000000 & dr1ifdcd<33000000)
  g gram33 = dr1igrms if (dr1ifdcd>=33000000 & dr1ifdcd<34000000)
  g gram35 = dr1igrms if (dr1ifdcd>=34000000 & dr1ifdcd<35000000)

  g gram41 = dr1igrms if (dr1ifdcd>=41000000 & dr1ifdcd<42000000)
  g gram42 = dr1igrms if (dr1ifdcd>=42000000 & dr1ifdcd<43000000)
  g gram43 = dr1igrms if (dr1ifdcd>=43000000 & dr1ifdcd<44000000)
  g gram44 = dr1igrms if (dr1ifdcd>=44000000 & dr1ifdcd<45000000)

  g gram50 = dr1igrms if (dr1ifdcd>=50000000 & dr1ifdcd<51000000)
  g gram51 = dr1igrms if (dr1ifdcd>=51000000 & dr1ifdcd<52000000)
  g gram52 = dr1igrms if (dr1ifdcd>=52000000 & dr1ifdcd<53000000)
  g gram53 = dr1igrms if (dr1ifdcd>=53000000 & dr1ifdcd<54000000)
  g gram54 = dr1igrms if (dr1ifdcd>=54000000 & dr1ifdcd<55000000)
  g gram55 = dr1igrms if (dr1ifdcd>=55000000 & dr1ifdcd<56000000)
  g gram56 = dr1igrms if (dr1ifdcd>=56000000 & dr1ifdcd<57000000)
  g gram57 = dr1igrms if (dr1ifdcd>=57000000 & dr1ifdcd<58000000)
  g gram58 = dr1igrms if (dr1ifdcd>=58000000 & dr1ifdcd<59000000)
  g gram59 = dr1igrms if (dr1ifdcd>=59000000 & dr1ifdcd<60000000)

  g gram61 = dr1igrms if (dr1ifdcd>=61000000 & dr1ifdcd<62000000)
  g gram62 = dr1igrms if (dr1ifdcd>=62000000 & dr1ifdcd<63000000)
  g gram63 = dr1igrms if (dr1ifdcd>=63000000 & dr1ifdcd<64000000)
  g gram64 = dr1igrms if (dr1ifdcd>=64000000 & dr1ifdcd<65000000)
  g gram67 = dr1igrms if (dr1ifdcd>=67000000 & dr1ifdcd<68000000)

  g gram71 = dr1igrms if (dr1ifdcd>=71000000 & dr1ifdcd<72000000)
  g gram72 = dr1igrms if (dr1ifdcd>=72000000 & dr1ifdcd<73000000)
  g gram73 = dr1igrms if (dr1ifdcd>=73000000 & dr1ifdcd<74000000)
  g gram74 = dr1igrms if (dr1ifdcd>=74000000 & dr1ifdcd<75000000)
  g gram75 = dr1igrms if (dr1ifdcd>=75000000 & dr1ifdcd<76000000)
  g gram76 = dr1igrms if (dr1ifdcd>=76000000 & dr1ifdcd<77000000)
  g gram77 = dr1igrms if (dr1ifdcd>=77000000 & dr1ifdcd<78000000)
  g gram78 = dr1igrms if (dr1ifdcd>=78000000 & dr1ifdcd<79000000)

  g gram81 = dr1igrms if (dr1ifdcd>=81000000 & dr1ifdcd<82000000)
  g gram82 = dr1igrms if (dr1ifdcd>=82000000 & dr1ifdcd<83000000)
  g gram83 = dr1igrms if (dr1ifdcd>=83000000 & dr1ifdcd<84000000)

  g gram91 = dr1igrms if (dr1ifdcd>=91000000 & dr1ifdcd<92000000)
  g gram92 = dr1igrms if (dr1ifdcd>=92000000 & dr1ifdcd<93000000)
  g gram93 = dr1igrms if (dr1ifdcd>=93000000 & dr1ifdcd<94000000)
  g gram94 = dr1igrms if (dr1ifdcd>=94000000 & dr1ifdcd<95000000)
  g gram95 = dr1igrms if (dr1ifdcd>=95000000 & dr1ifdcd<96000000)

  

 collapse (sum) kcal11 kcal12 kcal13 kcal14 kcal20 kcal21 kcal22 kcal23 kcal24 kcal25 kcal26 kcal27 kcal28 kcal31 kcal32 kcal33 kcal35 kcal41 kcal42 kcal43 kcal44 kcal50 kcal51 kcal52 kcal53 kcal54 kcal55 kcal56 kcal57 kcal58 kcal59 kcal61 kcal62 kcal63 kcal64 kcal67 kcal71 kcal72 kcal73 kcal74 kcal75 kcal76 kcal77 kcal78 kcal81 kcal82 kcal83 kcal91 kcal92 kcal93 kcal94 kcal95 gram11 gram12 gram13 gram14 gram20 gram21 gram22 gram23 gram24 gram25 gram26 gram27 gram28 gram31 gram32 gram33 gram35 gram41 gram42 gram43 gram44 gram50 gram51 gram52 gram53 gram54 gram55 gram56 gram57 gram58 gram59 gram61 gram62 gram63 gram64 gram67 gram71 gram72 gram73 gram74 gram75 gram76 gram77 gram78 gram81 gram82 gram83 gram91 gram92 gram93 gram94 gram95, by(seqn) 

 

sort seqn
merge seqn using nhanesnutr0708
drop _merge
sort seqn
save nhanesnutr0708, replace


use nhanesnutr0708, clear

* age, in yrs
g age = ridageyr

* sex, 0 = male, 1 = female
g sex =  riagendr-1

* black, 0 = white, 1 = black
g black = 0 if ridreth1==3
replace black = 1 if ridreth1==4

* hisp, 0 = nonhisp, 1 = hisp
g hisp = 1 if ridreth1<3
replace hisp = 0 if ridreth1>=3


* sbp and dbp, in mmhg

foreach i in bpxsy1 bpxsy2 bpxsy3 bpxsy4 {
    replace `i' =. if `i'==0
}

gen n_sbp= !missing(bpxsy1)+ !missing(bpxsy2)+ !missing(bpxsy3)+ !missing(bpxsy4)

egen sbp = rowmean(bpxsy1 bpxsy2 bpxsy3 bpxsy4)


* dm is diabetes status, by L a1c or fbg or self-report or meds
g a1c = lbxgh
gen dm =1 if ((lbxgh>=6.5) | (lbxglu>=126)) | (diq010==1) | (diq050==1)
replace dm = 0 if dm!=1 


* egfr by CKD-EPI equation
g screat = lbxscr
g ualbcr = urxuma/urxucr*1000
g egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age) if sex==0 & black==0
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018 if sex==1 & black==0
replace egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.159 if sex==0 & black==1
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018*1.159 if sex==1 & black==1

* tob is current smoker, 1 = current 
g tob = 1 if smq040<=2
replace tob = 0 if (smq040==. | smq040==3)

* totchol and ldl are total and ldl cholesterol, in mg/dl
g hdl = lbdhdd
g totchol = lbxtc

*MI or stroke history
g cvdhx =1  if (mcq160e==1)|(mcq160f==1)
replace cvdhx = 0 if cvdhx!=1

g cvddeath = 1 if mortstat==1 & (ucod_leading=="001" | ucod_leading=="005")
replace cvddeath = 0 if cvddeath!=1

 
cd "/Users/sbasu/Data/NHANES"
export delimited using "nhanesnutr0708", replace



clear
fdause "/Users/sbasu/Data/NHANES/2009-2010/DEMO_F.xpt"
sort seqn
save nhanesnutr0910, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2009-2010/BMX_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2009-2010/BPQ_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2009-2010/BPX_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2009-2010/MCQ_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear	
fdause "/Users/sbasu/Data/NHANES/2009-2010/ALB_CR_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear
fdause "/Users/sbasu/Data/NHANES/2009-2010/BIOPRO_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear
fdause "/Users/sbasu/Data/NHANES/2009-2010/GHB_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear
fdause "/Users/sbasu/Data/NHANES/2009-2010/GLU_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear
fdause "/Users/sbasu/Data/NHANES/2009-2010/DIQ_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear
fdause "/Users/sbasu/Data/NHANES/2009-2010/SMQ_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
clear
fdause "/Users/sbasu/Data/NHANES/2009-2010/HDL_F.xpt"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
fdause "/Users/sbasu/Data/NHANES/2009-2010/TCHOL_F.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace
fdause "/Users/sbasu/Data/NHANES/2009-2010/SMQ_F.xpt",  clear	
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace


fdause "/Users/sbasu/Data/NHANES/2009-2010/DR1TOT_F.XPT",  clear	
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace


import sasxport "/Users/sbasu/Data/NHANES/2009-2010/RXQ_RX_F.xpt", clear
save nhanesdrug0910, replace
import sasxport "/Users/sbasu/Data/NHANES/2009-2010/RXQ_DRUG.xpt", clear
merge m:m rxddrgid using nhanesdrug0910
drop _merge
sort seqn
save nhanesdrug0910, replace


*med list
g byte acei = regexm(rxddrug, "PRIL$")
g byte ace2 = regexm(rxddrug, "^BENAZEPRIL")
replace ace2 = 0 if acei==1
g byte arb = regexm(rxddrug, "SARTAN$")
g byte bb = regexm(rxddrug, "OLOL$")
g byte bb2 = regexm(rxddrug, "CARVEDILOL$")
g byte bb3 = regexm(rxddrug, "SOTALOL")
g byte ccb = regexm(rxddrug,"DIPINE$")
g byte ccb2 = regexm(rxddrug,"DILTIAZEM")
g byte ccb3 = regexm(rxddrug,"PAMIL$")
g byte ccb4 = regexm(rxddrug,"^AMLODIPINE")
replace ccb4 = 0 if ccb==1
g byte thi = regexm(rxddrug,"^HYDROCHLOROTHIAZIDE")
g byte thi2 = regexm(rxddrug,"THIAZIDE$")
replace thi2 = 0 if thi==1
g byte oth = regexm(rxddrug,"HYDRALAZINE")
g byte oth2 = regexm(rxddrug,"TRIAMTERENE")
g byte oth3 = regexm(rxddrug,"ANTIHYPERTENSIVE AGENT")
g byte oth4 = regexm(rxddrug,"CLONIDINE")

g bpmeds = acei+ace2+arb+bb+bb2+bb3+ccb+ccb2+ccb3+ccb4+thi+thi2+oth+oth2+oth3+oth4
g statin = regexm(rxddrug,"STATIN$")
g oraldmrx = regexm(rxddrug,"METFORMIN$") | regexm(rxddrug,"^METFORMIN") | regexm(rxddrug,"GLIPIZIDE$") | regexm(rxddrug,"^GLIPIZIDE") | regexm(rxddrug,"^GLITAZONE") | regexm(rxddrug,"GLITAZONE$")
*(diq070==1)
g anticoag = regexm(rxddrug,"WARFARIN$") | regexm(rxddrug,"^WARFARIN") | regexm(rxddrug,"COUMADIN$") | regexm(rxddrug,"^COUMADIN")
g asa = regexm(rxddrug,"ASPIRIN$") | regexm(rxddrug,"^ASPIRIN") 

sort seqn
collapse (max) bpmeds statin oraldmrx anticoag asa, by(seqn) cw
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace


use "/Users/sbasu/Data/NHANES/Linked NDI/NHANES_2009_2010_MORT_2011_PUBLIC.dta"
sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace



fdause "/Users/sbasu/Data/NHANES/2009-2010/DR1IFF_F.XPT",  clear	



* kcals by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., kcal11 = milks and milk drinks
  g kcal11 = dr1ikcal if (dr1ifdcd>=11000000 & dr1ifdcd<12000000)
  g kcal12 = dr1ikcal if (dr1ifdcd>=12000000 & dr1ifdcd<13000000)
  g kcal13 = dr1ikcal if (dr1ifdcd>=13000000 & dr1ifdcd<14000000)
  g kcal14 = dr1ikcal if (dr1ifdcd>=14000000 & dr1ifdcd<15000000)

  g kcal20 = dr1ikcal if (dr1ifdcd>=20000000 & dr1ifdcd<21000000)
  g kcal21 = dr1ikcal if (dr1ifdcd>=21000000 & dr1ifdcd<22000000)
  g kcal22 = dr1ikcal if (dr1ifdcd>=22000000 & dr1ifdcd<23000000)
  g kcal23 = dr1ikcal if (dr1ifdcd>=23000000 & dr1ifdcd<24000000)
  g kcal24 = dr1ikcal if (dr1ifdcd>=24000000 & dr1ifdcd<25000000)
  g kcal25 = dr1ikcal if (dr1ifdcd>=25000000 & dr1ifdcd<26000000)
  g kcal26 = dr1ikcal if (dr1ifdcd>=26000000 & dr1ifdcd<27000000)
  g kcal27 = dr1ikcal if (dr1ifdcd>=27000000 & dr1ifdcd<28000000)
  g kcal28 = dr1ikcal if (dr1ifdcd>=28000000 & dr1ifdcd<29000000)

  g kcal31 = dr1ikcal if (dr1ifdcd>=31000000 & dr1ifdcd<32000000)
  g kcal32 = dr1ikcal if (dr1ifdcd>=32000000 & dr1ifdcd<33000000)
  g kcal33 = dr1ikcal if (dr1ifdcd>=33000000 & dr1ifdcd<34000000)
  g kcal35 = dr1ikcal if (dr1ifdcd>=34000000 & dr1ifdcd<35000000)

  g kcal41 = dr1ikcal if (dr1ifdcd>=41000000 & dr1ifdcd<42000000)
  g kcal42 = dr1ikcal if (dr1ifdcd>=42000000 & dr1ifdcd<43000000)
  g kcal43 = dr1ikcal if (dr1ifdcd>=43000000 & dr1ifdcd<44000000)
  g kcal44 = dr1ikcal if (dr1ifdcd>=44000000 & dr1ifdcd<45000000)

  g kcal50 = dr1ikcal if (dr1ifdcd>=50000000 & dr1ifdcd<51000000)
  g kcal51 = dr1ikcal if (dr1ifdcd>=51000000 & dr1ifdcd<52000000)
  g kcal52 = dr1ikcal if (dr1ifdcd>=52000000 & dr1ifdcd<53000000)
  g kcal53 = dr1ikcal if (dr1ifdcd>=53000000 & dr1ifdcd<54000000)
  g kcal54 = dr1ikcal if (dr1ifdcd>=54000000 & dr1ifdcd<55000000)
  g kcal55 = dr1ikcal if (dr1ifdcd>=55000000 & dr1ifdcd<56000000)
  g kcal56 = dr1ikcal if (dr1ifdcd>=56000000 & dr1ifdcd<57000000)
  g kcal57 = dr1ikcal if (dr1ifdcd>=57000000 & dr1ifdcd<58000000)
  g kcal58 = dr1ikcal if (dr1ifdcd>=58000000 & dr1ifdcd<59000000)
  g kcal59 = dr1ikcal if (dr1ifdcd>=59000000 & dr1ifdcd<60000000)

  g kcal61 = dr1ikcal if (dr1ifdcd>=61000000 & dr1ifdcd<62000000)
  g kcal62 = dr1ikcal if (dr1ifdcd>=62000000 & dr1ifdcd<63000000)
  g kcal63 = dr1ikcal if (dr1ifdcd>=63000000 & dr1ifdcd<64000000)
  g kcal64 = dr1ikcal if (dr1ifdcd>=64000000 & dr1ifdcd<65000000)
  g kcal67 = dr1ikcal if (dr1ifdcd>=67000000 & dr1ifdcd<68000000)

  g kcal71 = dr1ikcal if (dr1ifdcd>=71000000 & dr1ifdcd<72000000)
  g kcal72 = dr1ikcal if (dr1ifdcd>=72000000 & dr1ifdcd<73000000)
  g kcal73 = dr1ikcal if (dr1ifdcd>=73000000 & dr1ifdcd<74000000)
  g kcal74 = dr1ikcal if (dr1ifdcd>=74000000 & dr1ifdcd<75000000)
  g kcal75 = dr1ikcal if (dr1ifdcd>=75000000 & dr1ifdcd<76000000)
  g kcal76 = dr1ikcal if (dr1ifdcd>=76000000 & dr1ifdcd<77000000)
  g kcal77 = dr1ikcal if (dr1ifdcd>=77000000 & dr1ifdcd<78000000)
  g kcal78 = dr1ikcal if (dr1ifdcd>=78000000 & dr1ifdcd<79000000)

  g kcal81 = dr1ikcal if (dr1ifdcd>=81000000 & dr1ifdcd<82000000)
  g kcal82 = dr1ikcal if (dr1ifdcd>=82000000 & dr1ifdcd<83000000)
  g kcal83 = dr1ikcal if (dr1ifdcd>=83000000 & dr1ifdcd<84000000)

  g kcal91 = dr1ikcal if (dr1ifdcd>=91000000 & dr1ifdcd<92000000)
  g kcal92 = dr1ikcal if (dr1ifdcd>=92000000 & dr1ifdcd<93000000)
  g kcal93 = dr1ikcal if (dr1ifdcd>=93000000 & dr1ifdcd<94000000)
  g kcal94 = dr1ikcal if (dr1ifdcd>=94000000 & dr1ifdcd<95000000)
  g kcal95 = dr1ikcal if (dr1ifdcd>=95000000 & dr1ifdcd<96000000)

  
  
 * grams by food code, using USDA classification system: https://reedir.arsnet.usda.gov/codesearchwebapp/(gcp3kq55ssdyc445ry2k2rus)/coding_scheme.pdf
 * e.g., gram11 = milks and milk drinks
  g gram11 = dr1igrms if (dr1ifdcd>=11000000 & dr1ifdcd<12000000)
  g gram12 = dr1igrms if (dr1ifdcd>=12000000 & dr1ifdcd<13000000)
  g gram13 = dr1igrms if (dr1ifdcd>=13000000 & dr1ifdcd<14000000)
  g gram14 = dr1igrms if (dr1ifdcd>=14000000 & dr1ifdcd<15000000)

  g gram20 = dr1igrms if (dr1ifdcd>=20000000 & dr1ifdcd<21000000)
  g gram21 = dr1igrms if (dr1ifdcd>=21000000 & dr1ifdcd<22000000)
  g gram22 = dr1igrms if (dr1ifdcd>=22000000 & dr1ifdcd<23000000)
  g gram23 = dr1igrms if (dr1ifdcd>=23000000 & dr1ifdcd<24000000)
  g gram24 = dr1igrms if (dr1ifdcd>=24000000 & dr1ifdcd<25000000)
  g gram25 = dr1igrms if (dr1ifdcd>=25000000 & dr1ifdcd<26000000)
  g gram26 = dr1igrms if (dr1ifdcd>=26000000 & dr1ifdcd<27000000)
  g gram27 = dr1igrms if (dr1ifdcd>=27000000 & dr1ifdcd<28000000)
  g gram28 = dr1igrms if (dr1ifdcd>=28000000 & dr1ifdcd<29000000)

  g gram31 = dr1igrms if (dr1ifdcd>=31000000 & dr1ifdcd<32000000)
  g gram32 = dr1igrms if (dr1ifdcd>=32000000 & dr1ifdcd<33000000)
  g gram33 = dr1igrms if (dr1ifdcd>=33000000 & dr1ifdcd<34000000)
  g gram35 = dr1igrms if (dr1ifdcd>=34000000 & dr1ifdcd<35000000)

  g gram41 = dr1igrms if (dr1ifdcd>=41000000 & dr1ifdcd<42000000)
  g gram42 = dr1igrms if (dr1ifdcd>=42000000 & dr1ifdcd<43000000)
  g gram43 = dr1igrms if (dr1ifdcd>=43000000 & dr1ifdcd<44000000)
  g gram44 = dr1igrms if (dr1ifdcd>=44000000 & dr1ifdcd<45000000)

  g gram50 = dr1igrms if (dr1ifdcd>=50000000 & dr1ifdcd<51000000)
  g gram51 = dr1igrms if (dr1ifdcd>=51000000 & dr1ifdcd<52000000)
  g gram52 = dr1igrms if (dr1ifdcd>=52000000 & dr1ifdcd<53000000)
  g gram53 = dr1igrms if (dr1ifdcd>=53000000 & dr1ifdcd<54000000)
  g gram54 = dr1igrms if (dr1ifdcd>=54000000 & dr1ifdcd<55000000)
  g gram55 = dr1igrms if (dr1ifdcd>=55000000 & dr1ifdcd<56000000)
  g gram56 = dr1igrms if (dr1ifdcd>=56000000 & dr1ifdcd<57000000)
  g gram57 = dr1igrms if (dr1ifdcd>=57000000 & dr1ifdcd<58000000)
  g gram58 = dr1igrms if (dr1ifdcd>=58000000 & dr1ifdcd<59000000)
  g gram59 = dr1igrms if (dr1ifdcd>=59000000 & dr1ifdcd<60000000)

  g gram61 = dr1igrms if (dr1ifdcd>=61000000 & dr1ifdcd<62000000)
  g gram62 = dr1igrms if (dr1ifdcd>=62000000 & dr1ifdcd<63000000)
  g gram63 = dr1igrms if (dr1ifdcd>=63000000 & dr1ifdcd<64000000)
  g gram64 = dr1igrms if (dr1ifdcd>=64000000 & dr1ifdcd<65000000)
  g gram67 = dr1igrms if (dr1ifdcd>=67000000 & dr1ifdcd<68000000)

  g gram71 = dr1igrms if (dr1ifdcd>=71000000 & dr1ifdcd<72000000)
  g gram72 = dr1igrms if (dr1ifdcd>=72000000 & dr1ifdcd<73000000)
  g gram73 = dr1igrms if (dr1ifdcd>=73000000 & dr1ifdcd<74000000)
  g gram74 = dr1igrms if (dr1ifdcd>=74000000 & dr1ifdcd<75000000)
  g gram75 = dr1igrms if (dr1ifdcd>=75000000 & dr1ifdcd<76000000)
  g gram76 = dr1igrms if (dr1ifdcd>=76000000 & dr1ifdcd<77000000)
  g gram77 = dr1igrms if (dr1ifdcd>=77000000 & dr1ifdcd<78000000)
  g gram78 = dr1igrms if (dr1ifdcd>=78000000 & dr1ifdcd<79000000)

  g gram81 = dr1igrms if (dr1ifdcd>=81000000 & dr1ifdcd<82000000)
  g gram82 = dr1igrms if (dr1ifdcd>=82000000 & dr1ifdcd<83000000)
  g gram83 = dr1igrms if (dr1ifdcd>=83000000 & dr1ifdcd<84000000)

  g gram91 = dr1igrms if (dr1ifdcd>=91000000 & dr1ifdcd<92000000)
  g gram92 = dr1igrms if (dr1ifdcd>=92000000 & dr1ifdcd<93000000)
  g gram93 = dr1igrms if (dr1ifdcd>=93000000 & dr1ifdcd<94000000)
  g gram94 = dr1igrms if (dr1ifdcd>=94000000 & dr1ifdcd<95000000)
  g gram95 = dr1igrms if (dr1ifdcd>=95000000 & dr1ifdcd<96000000)

  

 collapse (sum) kcal11 kcal12 kcal13 kcal14 kcal20 kcal21 kcal22 kcal23 kcal24 kcal25 kcal26 kcal27 kcal28 kcal31 kcal32 kcal33 kcal35 kcal41 kcal42 kcal43 kcal44 kcal50 kcal51 kcal52 kcal53 kcal54 kcal55 kcal56 kcal57 kcal58 kcal59 kcal61 kcal62 kcal63 kcal64 kcal67 kcal71 kcal72 kcal73 kcal74 kcal75 kcal76 kcal77 kcal78 kcal81 kcal82 kcal83 kcal91 kcal92 kcal93 kcal94 kcal95 gram11 gram12 gram13 gram14 gram20 gram21 gram22 gram23 gram24 gram25 gram26 gram27 gram28 gram31 gram32 gram33 gram35 gram41 gram42 gram43 gram44 gram50 gram51 gram52 gram53 gram54 gram55 gram56 gram57 gram58 gram59 gram61 gram62 gram63 gram64 gram67 gram71 gram72 gram73 gram74 gram75 gram76 gram77 gram78 gram81 gram82 gram83 gram91 gram92 gram93 gram94 gram95, by(seqn) 


sort seqn
merge seqn using nhanesnutr0910
drop _merge
sort seqn
save nhanesnutr0910, replace


use nhanesnutr0910, clear


* age, in yrs
g age = ridageyr

* sex, 0 = male, 1 = female
g sex =  riagendr-1

* black, 0 = white, 1 = black
g black = 0 if ridreth1==3
replace black = 1 if ridreth1==4

* hisp, 0 = nonhisp, 1 = hisp
g hisp = 1 if ridreth1<3
replace hisp = 0 if ridreth1>=3


* sbp and dbp, in mmhg

foreach i in bpxsy1 bpxsy2 bpxsy3 bpxsy4 {
    replace `i' =. if `i'==0
}

gen n_sbp= !missing(bpxsy1)+ !missing(bpxsy2)+ !missing(bpxsy3)+ !missing(bpxsy4)

egen sbp = rowmean(bpxsy1 bpxsy2 bpxsy3 bpxsy4)


* dm is diabetes status, by L a1c or fbg or self-report or meds
g a1c = lbxgh
gen dm =1 if ((lbxgh>=6.5) | (lbxglu>=126)) | (diq010==1) | (diq050==1)
replace dm = 0 if dm!=1 


* egfr by CKD-EPI equation
g screat = lbxscr
g ualbcr = urxuma/urxucr*1000
g egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age) if sex==0 & black==0
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018 if sex==1 & black==0
replace egfr = 141*(min(screat/0.9,1)^(-0.411))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.159 if sex==0 & black==1
replace egfr = 141*(min(screat/0.7,1)^(-0.329))*(max(screat/0.9,1)^(-1.209))*(0.993^age)*1.018*1.159 if sex==1 & black==1

* tob is current smoker, 1 = current 
g tob = 1 if smq040<=2
replace tob = 0 if (smq040==. | smq040==3)

* totchol and ldl are total and ldl cholesterol, in mg/dl
g hdl = lbdhdd
g totchol = lbxtc

*MI or stroke history
g cvdhx =1  if (mcq160e==1)|(mcq160f==1)
replace cvdhx = 0 if cvdhx!=1

g cvddeath = 1 if mortstat==1 & (ucod_leading=="001" | ucod_leading=="005")
replace cvddeath = 0 if cvddeath!=1

 
cd "/Users/sbasu/Data/NHANES"
export delimited using "nhanesnutr0910", replace



