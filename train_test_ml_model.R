
# TO DOS:
# add HEI, AHEI, MDS, DASH score, refit ASCVD risk score for CVD mort only
# consider time to event/survival models/censoring rather than logistic alone


detach()
rm(list=ls())

library(readr)

setwd("~/Data/NHANES")

nhanesnutr9900 <- read_csv("~/Data/NHANES/nhanesnutr9900.csv")
nhanesnutr0102 <- read_csv("~/Data/NHANES/nhanesnutr0102.csv")
nhanesnutr0304 <- read_csv("~/Data/NHANES/nhanesnutr0304.csv")
nhanesnutr0506 <- read_csv("~/Data/NHANES/nhanesnutr0506.csv")
nhanesnutr0708 <- read_csv("~/Data/NHANES/nhanesnutr0708.csv")
nhanesnutr0910 <- read_csv("~/Data/NHANES/nhanesnutr0910.csv")



nh9900 = data.frame(nhanesnutr9900$age,nhanesnutr9900$sex,nhanesnutr9900$black,nhanesnutr9900$hisp,
                    nhanesnutr9900$tob,nhanesnutr9900$sbp,nhanesnutr9900$cvdhx,nhanesnutr9900$bpmeds,
                    nhanesnutr9900$oraldmrx,nhanesnutr9900$anticoag,nhanesnutr9900$statin,nhanesnutr9900$a1c,
                    nhanesnutr9900$totchol,nhanesnutr9900$hdl,nhanesnutr9900$screat,nhanesnutr9900$ualbcr,
                    nhanesnutr9900$mortstat,nhanesnutr9900$ucod_leading,nhanesnutr9900$dodqtr,nhanesnutr9900$dodyear,
                    nhanesnutr9900$permth_int,nhanesnutr9900$diq010,nhanesnutr9900$diq070,nhanesnutr9900$lbxglu,
                    nhanesnutr9900$drxtkcal, nhanesnutr9900$drxtprot, nhanesnutr9900$drxtcarb, nhanesnutr9900$drxttfat,
                    nhanesnutr9900$drxtsfat, nhanesnutr9900$drxtmfat, nhanesnutr9900$drxtpfat, 
                    nhanesnutr9900$drxtchol, nhanesnutr9900$drxtfibe, nhanesnutr9900$drxtvaiu,
                    nhanesnutr9900$drxtcaro, nhanesnutr9900$drxtvb1, nhanesnutr9900$drxtvb2,
                    nhanesnutr9900$drxtniac, nhanesnutr9900$drxtvb6, nhanesnutr9900$drxtfola,
                    nhanesnutr9900$drxtvb12, nhanesnutr9900$drxtvc, nhanesnutr9900$drxtve,
                    nhanesnutr9900$drxtcalc, nhanesnutr9900$drxtphos, nhanesnutr9900$drxtmagn,
                    nhanesnutr9900$drxtiron, nhanesnutr9900$drxtzinc, nhanesnutr9900$drxtcopp,
                    nhanesnutr9900$drdtsodi, nhanesnutr9900$drxtpota, nhanesnutr9900$drxtsele,
                    nhanesnutr9900$drxtcaff, nhanesnutr9900$drxttheo, nhanesnutr9900$drxtalco, nhanesnutr9900$drxtwate, 
                    nhanesnutr9900$drxts040, nhanesnutr9900$drxts060, nhanesnutr9900$drxts080, nhanesnutr9900$drxts100, nhanesnutr9900$drxts120, nhanesnutr9900$drxts140, nhanesnutr9900$drxts160, nhanesnutr9900$drxts180, 
                    nhanesnutr9900$drxtm161, nhanesnutr9900$drxtm181, nhanesnutr9900$drxtm201, nhanesnutr9900$drxtm221,
                    nhanesnutr9900$drxtp182, nhanesnutr9900$drxtp183, nhanesnutr9900$drxtp184, nhanesnutr9900$drxtp204, nhanesnutr9900$drxtp205, nhanesnutr9900$drxtp225, nhanesnutr9900$drxtp226,
                    nhanesnutr9900$kcal11, nhanesnutr9900$kcal12, nhanesnutr9900$kcal13, nhanesnutr9900$kcal14, nhanesnutr9900$kcal20, nhanesnutr9900$kcal21, nhanesnutr9900$kcal22, nhanesnutr9900$kcal23, nhanesnutr9900$kcal24, nhanesnutr9900$kcal25, nhanesnutr9900$kcal26, nhanesnutr9900$kcal27, nhanesnutr9900$kcal28, nhanesnutr9900$kcal31, nhanesnutr9900$kcal32, nhanesnutr9900$kcal33, nhanesnutr9900$kcal35, nhanesnutr9900$kcal41, nhanesnutr9900$kcal42, nhanesnutr9900$kcal43, nhanesnutr9900$kcal44, nhanesnutr9900$kcal50, nhanesnutr9900$kcal51, nhanesnutr9900$kcal52, nhanesnutr9900$kcal53, nhanesnutr9900$kcal54, nhanesnutr9900$kcal55, nhanesnutr9900$kcal56, nhanesnutr9900$kcal57, nhanesnutr9900$kcal58, nhanesnutr9900$kcal59, nhanesnutr9900$kcal61, nhanesnutr9900$kcal62, nhanesnutr9900$kcal63, nhanesnutr9900$kcal64, nhanesnutr9900$kcal67, nhanesnutr9900$kcal71, nhanesnutr9900$kcal72, nhanesnutr9900$kcal73, nhanesnutr9900$kcal74, nhanesnutr9900$kcal75, nhanesnutr9900$kcal76, nhanesnutr9900$kcal77, nhanesnutr9900$kcal78, nhanesnutr9900$kcal81, nhanesnutr9900$kcal82, nhanesnutr9900$kcal83, nhanesnutr9900$kcal91, nhanesnutr9900$kcal92, nhanesnutr9900$kcal93, nhanesnutr9900$kcal94, nhanesnutr9900$kcal95, nhanesnutr9900$gram11, nhanesnutr9900$gram12, nhanesnutr9900$gram13, nhanesnutr9900$gram14, nhanesnutr9900$gram20, nhanesnutr9900$gram21, nhanesnutr9900$gram22, nhanesnutr9900$gram23, nhanesnutr9900$gram24, nhanesnutr9900$gram25, nhanesnutr9900$gram26, nhanesnutr9900$gram27, nhanesnutr9900$gram28, nhanesnutr9900$gram31, nhanesnutr9900$gram32, nhanesnutr9900$gram33, nhanesnutr9900$gram35, nhanesnutr9900$gram41, nhanesnutr9900$gram42, nhanesnutr9900$gram43, nhanesnutr9900$gram44, nhanesnutr9900$gram50, nhanesnutr9900$gram51, nhanesnutr9900$gram52, nhanesnutr9900$gram53, nhanesnutr9900$gram54, nhanesnutr9900$gram55, nhanesnutr9900$gram56, nhanesnutr9900$gram57, nhanesnutr9900$gram58, nhanesnutr9900$gram59, nhanesnutr9900$gram61, nhanesnutr9900$gram62, nhanesnutr9900$gram63, nhanesnutr9900$gram64, nhanesnutr9900$gram67, nhanesnutr9900$gram71, nhanesnutr9900$gram72, nhanesnutr9900$gram73, nhanesnutr9900$gram74, nhanesnutr9900$gram75, nhanesnutr9900$gram76, nhanesnutr9900$gram77, nhanesnutr9900$gram78, nhanesnutr9900$gram81, nhanesnutr9900$gram82, nhanesnutr9900$gram83, nhanesnutr9900$gram91, nhanesnutr9900$gram92, nhanesnutr9900$gram93, nhanesnutr9900$gram94, nhanesnutr9900$gram95)

nh0102 = data.frame(nhanesnutr0102$age,nhanesnutr0102$sex,nhanesnutr0102$black,nhanesnutr0102$hisp,nhanesnutr0102$tob,nhanesnutr0102$sbp,nhanesnutr0102$cvdhx,nhanesnutr0102$bpmeds,nhanesnutr0102$oraldmrx,nhanesnutr0102$anticoag,nhanesnutr0102$statin,nhanesnutr0102$a1c,nhanesnutr0102$totchol,nhanesnutr0102$hdl,nhanesnutr0102$screat,nhanesnutr0102$ualbcr,nhanesnutr0102$mortstat,nhanesnutr0102$ucod_leading,nhanesnutr0102$dodqtr,nhanesnutr0102$dodyear,nhanesnutr0102$permth_int,nhanesnutr0102$diq010,nhanesnutr0102$diq070,nhanesnutr0102$lbxglu,
                    nhanesnutr0102$drxtkcal, nhanesnutr0102$drxtprot, nhanesnutr0102$drxtcarb, nhanesnutr0102$drxttfat,
                    nhanesnutr0102$drxtsfat, nhanesnutr0102$drxtmfat, nhanesnutr0102$drxtpfat, 
                    nhanesnutr0102$drxtchol, nhanesnutr0102$drxtfibe, nhanesnutr0102$drxtvara,
                    nhanesnutr0102$drxtbcar, nhanesnutr0102$drxtvb1, nhanesnutr0102$drxtvb2,
                    nhanesnutr0102$drxtniac, nhanesnutr0102$drxtvb6, nhanesnutr0102$drxtfola,
                    nhanesnutr0102$drxtvb12, nhanesnutr0102$drxtvc, nhanesnutr0102$drxtatoc,
                    nhanesnutr0102$drxtcalc, nhanesnutr0102$drxtphos, nhanesnutr0102$drxtmagn,
                    nhanesnutr0102$drxtiron, nhanesnutr0102$drxtzinc, nhanesnutr0102$drxtcopp,
                    nhanesnutr0102$drdtsodi, nhanesnutr0102$drxtpota, nhanesnutr0102$drxtsele,
                    nhanesnutr0102$drxtcaff, nhanesnutr0102$drxttheo, nhanesnutr0102$drxtalco, nhanesnutr0102$drd320gw, 
                    nhanesnutr0102$drxts040, nhanesnutr0102$drxts060, nhanesnutr0102$drxts080, nhanesnutr0102$drxts100, nhanesnutr0102$drxts120, nhanesnutr0102$drxts140, nhanesnutr0102$drxts160, nhanesnutr0102$drxts180, 
                    nhanesnutr0102$drxtm161, nhanesnutr0102$drxtm181, nhanesnutr0102$drxtm201, nhanesnutr0102$drxtm221,
                    nhanesnutr0102$drxtp182, nhanesnutr0102$drxtp183, nhanesnutr0102$drxtp184, nhanesnutr0102$drxtp204, nhanesnutr0102$drxtp205, nhanesnutr0102$drxtp225, nhanesnutr0102$drxtp226,
                    nhanesnutr0102$kcal11, nhanesnutr0102$kcal12, nhanesnutr0102$kcal13, nhanesnutr0102$kcal14, nhanesnutr0102$kcal20, nhanesnutr0102$kcal21, nhanesnutr0102$kcal22, nhanesnutr0102$kcal23, nhanesnutr0102$kcal24, nhanesnutr0102$kcal25, nhanesnutr0102$kcal26, nhanesnutr0102$kcal27, nhanesnutr0102$kcal28, nhanesnutr0102$kcal31, nhanesnutr0102$kcal32, nhanesnutr0102$kcal33, nhanesnutr0102$kcal35, nhanesnutr0102$kcal41, nhanesnutr0102$kcal42, nhanesnutr0102$kcal43, nhanesnutr0102$kcal44, nhanesnutr0102$kcal50, nhanesnutr0102$kcal51, nhanesnutr0102$kcal52, nhanesnutr0102$kcal53, nhanesnutr0102$kcal54, nhanesnutr0102$kcal55, nhanesnutr0102$kcal56, nhanesnutr0102$kcal57, nhanesnutr0102$kcal58, nhanesnutr0102$kcal59, nhanesnutr0102$kcal61, nhanesnutr0102$kcal62, nhanesnutr0102$kcal63, nhanesnutr0102$kcal64, nhanesnutr0102$kcal67, nhanesnutr0102$kcal71, nhanesnutr0102$kcal72, nhanesnutr0102$kcal73, nhanesnutr0102$kcal74, nhanesnutr0102$kcal75, nhanesnutr0102$kcal76, nhanesnutr0102$kcal77, nhanesnutr0102$kcal78, nhanesnutr0102$kcal81, nhanesnutr0102$kcal82, nhanesnutr0102$kcal83, nhanesnutr0102$kcal91, nhanesnutr0102$kcal92, nhanesnutr0102$kcal93, nhanesnutr0102$kcal94, nhanesnutr0102$kcal95, nhanesnutr0102$gram11, nhanesnutr0102$gram12, nhanesnutr0102$gram13, nhanesnutr0102$gram14, nhanesnutr0102$gram20, nhanesnutr0102$gram21, nhanesnutr0102$gram22, nhanesnutr0102$gram23, nhanesnutr0102$gram24, nhanesnutr0102$gram25, nhanesnutr0102$gram26, nhanesnutr0102$gram27, nhanesnutr0102$gram28, nhanesnutr0102$gram31, nhanesnutr0102$gram32, nhanesnutr0102$gram33, nhanesnutr0102$gram35, nhanesnutr0102$gram41, nhanesnutr0102$gram42, nhanesnutr0102$gram43, nhanesnutr0102$gram44, nhanesnutr0102$gram50, nhanesnutr0102$gram51, nhanesnutr0102$gram52, nhanesnutr0102$gram53, nhanesnutr0102$gram54, nhanesnutr0102$gram55, nhanesnutr0102$gram56, nhanesnutr0102$gram57, nhanesnutr0102$gram58, nhanesnutr0102$gram59, nhanesnutr0102$gram61, nhanesnutr0102$gram62, nhanesnutr0102$gram63, nhanesnutr0102$gram64, nhanesnutr0102$gram67, nhanesnutr0102$gram71, nhanesnutr0102$gram72, nhanesnutr0102$gram73, nhanesnutr0102$gram74, nhanesnutr0102$gram75, nhanesnutr0102$gram76, nhanesnutr0102$gram77, nhanesnutr0102$gram78, nhanesnutr0102$gram81, nhanesnutr0102$gram82, nhanesnutr0102$gram83, nhanesnutr0102$gram91, nhanesnutr0102$gram92, nhanesnutr0102$gram93, nhanesnutr0102$gram94, nhanesnutr0102$gram95)


nh0304 = data.frame(nhanesnutr0304$age,nhanesnutr0304$sex,nhanesnutr0304$black,nhanesnutr0304$hisp,nhanesnutr0304$tob,nhanesnutr0304$sbp,nhanesnutr0304$cvdhx,nhanesnutr0304$bpmeds,nhanesnutr0304$oraldmrx,nhanesnutr0304$anticoag,nhanesnutr0304$statin,nhanesnutr0304$a1c,nhanesnutr0304$totchol,nhanesnutr0304$hdl,nhanesnutr0304$screat,nhanesnutr0304$ualbcr,nhanesnutr0304$mortstat,nhanesnutr0304$ucod_leading,nhanesnutr0304$dodqtr,nhanesnutr0304$dodyear,nhanesnutr0304$permth_int,nhanesnutr0304$diq010,nhanesnutr0304$diq070,nhanesnutr0304$lbxglu,
                    nhanesnutr0304$dr1tkcal, nhanesnutr0304$dr1tprot, nhanesnutr0304$dr1tcarb, nhanesnutr0304$dr1ttfat,
                    nhanesnutr0304$dr1tsfat, nhanesnutr0304$dr1tmfat, nhanesnutr0304$dr1tpfat, 
                    nhanesnutr0304$dr1tchol, nhanesnutr0304$dr1tfibe, nhanesnutr0304$dr1tvara,
                    nhanesnutr0304$dr1tbcar, nhanesnutr0304$dr1tvb1, nhanesnutr0304$dr1tvb2,
                    nhanesnutr0304$dr1tniac, nhanesnutr0304$dr1tvb6, nhanesnutr0304$dr1tfola,
                    nhanesnutr0304$dr1tvb12, nhanesnutr0304$dr1tvc, nhanesnutr0304$dr1tatoc,
                    nhanesnutr0304$dr1tcalc, nhanesnutr0304$dr1tphos, nhanesnutr0304$dr1tmagn,
                    nhanesnutr0304$dr1tiron, nhanesnutr0304$dr1tzinc, nhanesnutr0304$dr1tcopp,
                    nhanesnutr0304$dr1tsodi, nhanesnutr0304$dr1tpota, nhanesnutr0304$dr1tsele,
                    nhanesnutr0304$dr1tcaff, nhanesnutr0304$dr1ttheo, nhanesnutr0304$dr1talco, nhanesnutr0304$dr1_320, 
                    nhanesnutr0304$dr1ts040, nhanesnutr0304$dr1ts060, nhanesnutr0304$dr1ts080, nhanesnutr0304$dr1ts100, nhanesnutr0304$dr1ts120, nhanesnutr0304$dr1ts140, nhanesnutr0304$dr1ts160, nhanesnutr0304$dr1ts180, 
                    nhanesnutr0304$dr1tm161, nhanesnutr0304$dr1tm181, nhanesnutr0304$dr1tm201, nhanesnutr0304$dr1tm221,
                    nhanesnutr0304$dr1tp182, nhanesnutr0304$dr1tp183, nhanesnutr0304$dr1tp184, nhanesnutr0304$dr1tp204, nhanesnutr0304$dr1tp205, nhanesnutr0304$dr1tp225, nhanesnutr0304$dr1tp226,
                    nhanesnutr0304$kcal11, nhanesnutr0304$kcal12, nhanesnutr0304$kcal13, nhanesnutr0304$kcal14, nhanesnutr0304$kcal20, nhanesnutr0304$kcal21, nhanesnutr0304$kcal22, nhanesnutr0304$kcal23, nhanesnutr0304$kcal24, nhanesnutr0304$kcal25, nhanesnutr0304$kcal26, nhanesnutr0304$kcal27, nhanesnutr0304$kcal28, nhanesnutr0304$kcal31, nhanesnutr0304$kcal32, nhanesnutr0304$kcal33, nhanesnutr0304$kcal35, nhanesnutr0304$kcal41, nhanesnutr0304$kcal42, nhanesnutr0304$kcal43, nhanesnutr0304$kcal44, nhanesnutr0304$kcal50, nhanesnutr0304$kcal51, nhanesnutr0304$kcal52, nhanesnutr0304$kcal53, nhanesnutr0304$kcal54, nhanesnutr0304$kcal55, nhanesnutr0304$kcal56, nhanesnutr0304$kcal57, nhanesnutr0304$kcal58, nhanesnutr0304$kcal59, nhanesnutr0304$kcal61, nhanesnutr0304$kcal62, nhanesnutr0304$kcal63, nhanesnutr0304$kcal64, nhanesnutr0304$kcal67, nhanesnutr0304$kcal71, nhanesnutr0304$kcal72, nhanesnutr0304$kcal73, nhanesnutr0304$kcal74, nhanesnutr0304$kcal75, nhanesnutr0304$kcal76, nhanesnutr0304$kcal77, nhanesnutr0304$kcal78, nhanesnutr0304$kcal81, nhanesnutr0304$kcal82, nhanesnutr0304$kcal83, nhanesnutr0304$kcal91, nhanesnutr0304$kcal92, nhanesnutr0304$kcal93, nhanesnutr0304$kcal94, nhanesnutr0304$kcal95, nhanesnutr0304$gram11, nhanesnutr0304$gram12, nhanesnutr0304$gram13, nhanesnutr0304$gram14, nhanesnutr0304$gram20, nhanesnutr0304$gram21, nhanesnutr0304$gram22, nhanesnutr0304$gram23, nhanesnutr0304$gram24, nhanesnutr0304$gram25, nhanesnutr0304$gram26, nhanesnutr0304$gram27, nhanesnutr0304$gram28, nhanesnutr0304$gram31, nhanesnutr0304$gram32, nhanesnutr0304$gram33, nhanesnutr0304$gram35, nhanesnutr0304$gram41, nhanesnutr0304$gram42, nhanesnutr0304$gram43, nhanesnutr0304$gram44, nhanesnutr0304$gram50, nhanesnutr0304$gram51, nhanesnutr0304$gram52, nhanesnutr0304$gram53, nhanesnutr0304$gram54, nhanesnutr0304$gram55, nhanesnutr0304$gram56, nhanesnutr0304$gram57, nhanesnutr0304$gram58, nhanesnutr0304$gram59, nhanesnutr0304$gram61, nhanesnutr0304$gram62, nhanesnutr0304$gram63, nhanesnutr0304$gram64, nhanesnutr0304$gram67, nhanesnutr0304$gram71, nhanesnutr0304$gram72, nhanesnutr0304$gram73, nhanesnutr0304$gram74, nhanesnutr0304$gram75, nhanesnutr0304$gram76, nhanesnutr0304$gram77, nhanesnutr0304$gram78, nhanesnutr0304$gram81, nhanesnutr0304$gram82, nhanesnutr0304$gram83, nhanesnutr0304$gram91, nhanesnutr0304$gram92, nhanesnutr0304$gram93, nhanesnutr0304$gram94, nhanesnutr0304$gram95)

nh0506 = data.frame(nhanesnutr0506$age,nhanesnutr0506$sex,nhanesnutr0506$black,nhanesnutr0506$hisp,nhanesnutr0506$tob,nhanesnutr0506$sbp,nhanesnutr0506$cvdhx,nhanesnutr0506$bpmeds,nhanesnutr0506$oraldmrx,nhanesnutr0506$anticoag,nhanesnutr0506$statin,nhanesnutr0506$a1c,nhanesnutr0506$totchol,nhanesnutr0506$hdl,nhanesnutr0506$screat,nhanesnutr0506$ualbcr,nhanesnutr0506$mortstat,nhanesnutr0506$ucod_leading,nhanesnutr0506$dodqtr,nhanesnutr0506$dodyear,nhanesnutr0506$permth_int,nhanesnutr0506$diq010,nhanesnutr0506$did070,nhanesnutr0506$lbxglu,
                    nhanesnutr0506$dr1tkcal, nhanesnutr0506$dr1tprot, nhanesnutr0506$dr1tcarb, nhanesnutr0506$dr1ttfat,
                    nhanesnutr0506$dr1tsfat, nhanesnutr0506$dr1tmfat, nhanesnutr0506$dr1tpfat, 
                    nhanesnutr0506$dr1tchol, nhanesnutr0506$dr1tfibe, nhanesnutr0506$dr1tvara,
                    nhanesnutr0506$dr1tbcar, nhanesnutr0506$dr1tvb1, nhanesnutr0506$dr1tvb2,
                    nhanesnutr0506$dr1tniac, nhanesnutr0506$dr1tvb6, nhanesnutr0506$dr1tfola,
                    nhanesnutr0506$dr1tvb12, nhanesnutr0506$dr1tvc, nhanesnutr0506$dr1tatoc,
                    nhanesnutr0506$dr1tcalc, nhanesnutr0506$dr1tphos, nhanesnutr0506$dr1tmagn,
                    nhanesnutr0506$dr1tiron, nhanesnutr0506$dr1tzinc, nhanesnutr0506$dr1tcopp,
                    nhanesnutr0506$dr1tsodi, nhanesnutr0506$dr1tpota, nhanesnutr0506$dr1tsele,
                    nhanesnutr0506$dr1tcaff, nhanesnutr0506$dr1ttheo, nhanesnutr0506$dr1talco, nhanesnutr0506$dr1_320z, 
                    nhanesnutr0506$dr1ts040, nhanesnutr0506$dr1ts060, nhanesnutr0506$dr1ts080, nhanesnutr0506$dr1ts100, nhanesnutr0506$dr1ts120, nhanesnutr0506$dr1ts140, nhanesnutr0506$dr1ts160, nhanesnutr0506$dr1ts180, 
                    nhanesnutr0506$dr1tm161, nhanesnutr0506$dr1tm181, nhanesnutr0506$dr1tm201, nhanesnutr0506$dr1tm221,
                    nhanesnutr0506$dr1tp182, nhanesnutr0506$dr1tp183, nhanesnutr0506$dr1tp184, nhanesnutr0506$dr1tp204, nhanesnutr0506$dr1tp205, nhanesnutr0506$dr1tp225, nhanesnutr0506$dr1tp226,
                    nhanesnutr0506$kcal11, nhanesnutr0506$kcal12, nhanesnutr0506$kcal13, nhanesnutr0506$kcal14, nhanesnutr0506$kcal20, nhanesnutr0506$kcal21, nhanesnutr0506$kcal22, nhanesnutr0506$kcal23, nhanesnutr0506$kcal24, nhanesnutr0506$kcal25, nhanesnutr0506$kcal26, nhanesnutr0506$kcal27, nhanesnutr0506$kcal28, nhanesnutr0506$kcal31, nhanesnutr0506$kcal32, nhanesnutr0506$kcal33, nhanesnutr0506$kcal35, nhanesnutr0506$kcal41, nhanesnutr0506$kcal42, nhanesnutr0506$kcal43, nhanesnutr0506$kcal44, nhanesnutr0506$kcal50, nhanesnutr0506$kcal51, nhanesnutr0506$kcal52, nhanesnutr0506$kcal53, nhanesnutr0506$kcal54, nhanesnutr0506$kcal55, nhanesnutr0506$kcal56, nhanesnutr0506$kcal57, nhanesnutr0506$kcal58, nhanesnutr0506$kcal59, nhanesnutr0506$kcal61, nhanesnutr0506$kcal62, nhanesnutr0506$kcal63, nhanesnutr0506$kcal64, nhanesnutr0506$kcal67, nhanesnutr0506$kcal71, nhanesnutr0506$kcal72, nhanesnutr0506$kcal73, nhanesnutr0506$kcal74, nhanesnutr0506$kcal75, nhanesnutr0506$kcal76, nhanesnutr0506$kcal77, nhanesnutr0506$kcal78, nhanesnutr0506$kcal81, nhanesnutr0506$kcal82, nhanesnutr0506$kcal83, nhanesnutr0506$kcal91, nhanesnutr0506$kcal92, nhanesnutr0506$kcal93, nhanesnutr0506$kcal94, nhanesnutr0506$kcal95, nhanesnutr0506$gram11, nhanesnutr0506$gram12, nhanesnutr0506$gram13, nhanesnutr0506$gram14, nhanesnutr0506$gram20, nhanesnutr0506$gram21, nhanesnutr0506$gram22, nhanesnutr0506$gram23, nhanesnutr0506$gram24, nhanesnutr0506$gram25, nhanesnutr0506$gram26, nhanesnutr0506$gram27, nhanesnutr0506$gram28, nhanesnutr0506$gram31, nhanesnutr0506$gram32, nhanesnutr0506$gram33, nhanesnutr0506$gram35, nhanesnutr0506$gram41, nhanesnutr0506$gram42, nhanesnutr0506$gram43, nhanesnutr0506$gram44, nhanesnutr0506$gram50, nhanesnutr0506$gram51, nhanesnutr0506$gram52, nhanesnutr0506$gram53, nhanesnutr0506$gram54, nhanesnutr0506$gram55, nhanesnutr0506$gram56, nhanesnutr0506$gram57, nhanesnutr0506$gram58, nhanesnutr0506$gram59, nhanesnutr0506$gram61, nhanesnutr0506$gram62, nhanesnutr0506$gram63, nhanesnutr0506$gram64, nhanesnutr0506$gram67, nhanesnutr0506$gram71, nhanesnutr0506$gram72, nhanesnutr0506$gram73, nhanesnutr0506$gram74, nhanesnutr0506$gram75, nhanesnutr0506$gram76, nhanesnutr0506$gram77, nhanesnutr0506$gram78, nhanesnutr0506$gram81, nhanesnutr0506$gram82, nhanesnutr0506$gram83, nhanesnutr0506$gram91, nhanesnutr0506$gram92, nhanesnutr0506$gram93, nhanesnutr0506$gram94, nhanesnutr0506$gram95)

names(nh0506)[names(nh0506) == 'nhanesnutr0506$did070'] <- 'nhanesnutr0506$diq070'

nh0708 = data.frame(nhanesnutr0708$age,nhanesnutr0708$sex,nhanesnutr0708$black,nhanesnutr0708$hisp,nhanesnutr0708$tob,nhanesnutr0708$sbp,nhanesnutr0708$cvdhx,nhanesnutr0708$bpmeds,nhanesnutr0708$oraldmrx,nhanesnutr0708$anticoag,nhanesnutr0708$statin,nhanesnutr0708$a1c,nhanesnutr0708$totchol,nhanesnutr0708$hdl,nhanesnutr0708$screat,nhanesnutr0708$ualbcr,nhanesnutr0708$mortstat,nhanesnutr0708$ucod_leading,nhanesnutr0708$dodqtr,nhanesnutr0708$dodyear,nhanesnutr0708$permth_int,nhanesnutr0708$diq010,nhanesnutr0708$did070,nhanesnutr0708$lbxglu,
                    nhanesnutr0708$dr1tkcal, nhanesnutr0708$dr1tprot, nhanesnutr0708$dr1tcarb, nhanesnutr0708$dr1ttfat,
                    nhanesnutr0708$dr1tsfat, nhanesnutr0708$dr1tmfat, nhanesnutr0708$dr1tpfat, 
                    nhanesnutr0708$dr1tchol, nhanesnutr0708$dr1tfibe, nhanesnutr0708$dr1tvara,
                    nhanesnutr0708$dr1tbcar, nhanesnutr0708$dr1tvb1, nhanesnutr0708$dr1tvb2,
                    nhanesnutr0708$dr1tniac, nhanesnutr0708$dr1tvb6, nhanesnutr0708$dr1tfola,
                    nhanesnutr0708$dr1tvb12, nhanesnutr0708$dr1tvc, nhanesnutr0708$dr1tatoc,
                    nhanesnutr0708$dr1tcalc, nhanesnutr0708$dr1tphos, nhanesnutr0708$dr1tmagn,
                    nhanesnutr0708$dr1tiron, nhanesnutr0708$dr1tzinc, nhanesnutr0708$dr1tcopp,
                    nhanesnutr0708$dr1tsodi, nhanesnutr0708$dr1tpota, nhanesnutr0708$dr1tsele,
                    nhanesnutr0708$dr1tcaff, nhanesnutr0708$dr1ttheo, nhanesnutr0708$dr1talco, nhanesnutr0708$dr1_320z, 
                    nhanesnutr0708$dr1ts040, nhanesnutr0708$dr1ts060, nhanesnutr0708$dr1ts080, nhanesnutr0708$dr1ts100, nhanesnutr0708$dr1ts120, nhanesnutr0708$dr1ts140, nhanesnutr0708$dr1ts160, nhanesnutr0708$dr1ts180, 
                    nhanesnutr0708$dr1tm161, nhanesnutr0708$dr1tm181, nhanesnutr0708$dr1tm201, nhanesnutr0708$dr1tm221,
                    nhanesnutr0708$dr1tp182, nhanesnutr0708$dr1tp183, nhanesnutr0708$dr1tp184, nhanesnutr0708$dr1tp204, nhanesnutr0708$dr1tp205, nhanesnutr0708$dr1tp225, nhanesnutr0708$dr1tp226,
                    nhanesnutr0708$kcal11, nhanesnutr0708$kcal12, nhanesnutr0708$kcal13, nhanesnutr0708$kcal14, nhanesnutr0708$kcal20, nhanesnutr0708$kcal21, nhanesnutr0708$kcal22, nhanesnutr0708$kcal23, nhanesnutr0708$kcal24, nhanesnutr0708$kcal25, nhanesnutr0708$kcal26, nhanesnutr0708$kcal27, nhanesnutr0708$kcal28, nhanesnutr0708$kcal31, nhanesnutr0708$kcal32, nhanesnutr0708$kcal33, nhanesnutr0708$kcal35, nhanesnutr0708$kcal41, nhanesnutr0708$kcal42, nhanesnutr0708$kcal43, nhanesnutr0708$kcal44, nhanesnutr0708$kcal50, nhanesnutr0708$kcal51, nhanesnutr0708$kcal52, nhanesnutr0708$kcal53, nhanesnutr0708$kcal54, nhanesnutr0708$kcal55, nhanesnutr0708$kcal56, nhanesnutr0708$kcal57, nhanesnutr0708$kcal58, nhanesnutr0708$kcal59, nhanesnutr0708$kcal61, nhanesnutr0708$kcal62, nhanesnutr0708$kcal63, nhanesnutr0708$kcal64, nhanesnutr0708$kcal67, nhanesnutr0708$kcal71, nhanesnutr0708$kcal72, nhanesnutr0708$kcal73, nhanesnutr0708$kcal74, nhanesnutr0708$kcal75, nhanesnutr0708$kcal76, nhanesnutr0708$kcal77, nhanesnutr0708$kcal78, nhanesnutr0708$kcal81, nhanesnutr0708$kcal82, nhanesnutr0708$kcal83, nhanesnutr0708$kcal91, nhanesnutr0708$kcal92, nhanesnutr0708$kcal93, nhanesnutr0708$kcal94, nhanesnutr0708$kcal95, nhanesnutr0708$gram11, nhanesnutr0708$gram12, nhanesnutr0708$gram13, nhanesnutr0708$gram14, nhanesnutr0708$gram20, nhanesnutr0708$gram21, nhanesnutr0708$gram22, nhanesnutr0708$gram23, nhanesnutr0708$gram24, nhanesnutr0708$gram25, nhanesnutr0708$gram26, nhanesnutr0708$gram27, nhanesnutr0708$gram28, nhanesnutr0708$gram31, nhanesnutr0708$gram32, nhanesnutr0708$gram33, nhanesnutr0708$gram35, nhanesnutr0708$gram41, nhanesnutr0708$gram42, nhanesnutr0708$gram43, nhanesnutr0708$gram44, nhanesnutr0708$gram50, nhanesnutr0708$gram51, nhanesnutr0708$gram52, nhanesnutr0708$gram53, nhanesnutr0708$gram54, nhanesnutr0708$gram55, nhanesnutr0708$gram56, nhanesnutr0708$gram57, nhanesnutr0708$gram58, nhanesnutr0708$gram59, nhanesnutr0708$gram61, nhanesnutr0708$gram62, nhanesnutr0708$gram63, nhanesnutr0708$gram64, nhanesnutr0708$gram67, nhanesnutr0708$gram71, nhanesnutr0708$gram72, nhanesnutr0708$gram73, nhanesnutr0708$gram74, nhanesnutr0708$gram75, nhanesnutr0708$gram76, nhanesnutr0708$gram77, nhanesnutr0708$gram78, nhanesnutr0708$gram81, nhanesnutr0708$gram82, nhanesnutr0708$gram83, nhanesnutr0708$gram91, nhanesnutr0708$gram92, nhanesnutr0708$gram93, nhanesnutr0708$gram94, nhanesnutr0708$gram95)
names(nh0708)[names(nh0708) == 'nhanesnutr0708$did070'] <- 'nhanesnutr0708$diq070'


nh0910 = data.frame(nhanesnutr0910$age,nhanesnutr0910$sex,nhanesnutr0910$black,nhanesnutr0910$hisp,nhanesnutr0910$tob,nhanesnutr0910$sbp,nhanesnutr0910$cvdhx,nhanesnutr0910$bpmeds,nhanesnutr0910$oraldmrx,nhanesnutr0910$anticoag,nhanesnutr0910$statin,nhanesnutr0910$a1c,nhanesnutr0910$totchol,nhanesnutr0910$hdl,nhanesnutr0910$screat,nhanesnutr0910$ualbcr,nhanesnutr0910$mortstat,nhanesnutr0910$ucod_leading,nhanesnutr0910$dodqtr,nhanesnutr0910$dodyear,nhanesnutr0910$permth_int,nhanesnutr0910$diq010,nhanesnutr0910$diq070,nhanesnutr0910$lbxglu,
                    nhanesnutr0910$dr1tkcal, nhanesnutr0910$dr1tprot, nhanesnutr0910$dr1tcarb, nhanesnutr0910$dr1ttfat,
                    nhanesnutr0910$dr1tsfat, nhanesnutr0910$dr1tmfat, nhanesnutr0910$dr1tpfat, 
                    nhanesnutr0910$dr1tchol, nhanesnutr0910$dr1tfibe, nhanesnutr0910$dr1tvara,
                    nhanesnutr0910$dr1tbcar, nhanesnutr0910$dr1tvb1, nhanesnutr0910$dr1tvb2,
                    nhanesnutr0910$dr1tniac, nhanesnutr0910$dr1tvb6, nhanesnutr0910$dr1tfola,
                    nhanesnutr0910$dr1tvb12, nhanesnutr0910$dr1tvc, nhanesnutr0910$dr1tatoc,
                    nhanesnutr0910$dr1tcalc, nhanesnutr0910$dr1tphos, nhanesnutr0910$dr1tmagn,
                    nhanesnutr0910$dr1tiron, nhanesnutr0910$dr1tzinc, nhanesnutr0910$dr1tcopp,
                    nhanesnutr0910$dr1tsodi, nhanesnutr0910$dr1tpota, nhanesnutr0910$dr1tsele,
                    nhanesnutr0910$dr1tcaff, nhanesnutr0910$dr1ttheo, nhanesnutr0910$dr1talco, nhanesnutr0910$dr1_320z, 
                    nhanesnutr0910$dr1ts040, nhanesnutr0910$dr1ts060, nhanesnutr0910$dr1ts080, nhanesnutr0910$dr1ts100, nhanesnutr0910$dr1ts120, nhanesnutr0910$dr1ts140, nhanesnutr0910$dr1ts160, nhanesnutr0910$dr1ts180, 
                    nhanesnutr0910$dr1tm161, nhanesnutr0910$dr1tm181, nhanesnutr0910$dr1tm201, nhanesnutr0910$dr1tm221,
                    nhanesnutr0910$dr1tp182, nhanesnutr0910$dr1tp183, nhanesnutr0910$dr1tp184, nhanesnutr0910$dr1tp204, nhanesnutr0910$dr1tp205, nhanesnutr0910$dr1tp225, nhanesnutr0910$dr1tp226,
                    nhanesnutr0910$kcal11, nhanesnutr0910$kcal12, nhanesnutr0910$kcal13, nhanesnutr0910$kcal14, nhanesnutr0910$kcal20, nhanesnutr0910$kcal21, nhanesnutr0910$kcal22, nhanesnutr0910$kcal23, nhanesnutr0910$kcal24, nhanesnutr0910$kcal25, nhanesnutr0910$kcal26, nhanesnutr0910$kcal27, nhanesnutr0910$kcal28, nhanesnutr0910$kcal31, nhanesnutr0910$kcal32, nhanesnutr0910$kcal33, nhanesnutr0910$kcal35, nhanesnutr0910$kcal41, nhanesnutr0910$kcal42, nhanesnutr0910$kcal43, nhanesnutr0910$kcal44, nhanesnutr0910$kcal50, nhanesnutr0910$kcal51, nhanesnutr0910$kcal52, nhanesnutr0910$kcal53, nhanesnutr0910$kcal54, nhanesnutr0910$kcal55, nhanesnutr0910$kcal56, nhanesnutr0910$kcal57, nhanesnutr0910$kcal58, nhanesnutr0910$kcal59, nhanesnutr0910$kcal61, nhanesnutr0910$kcal62, nhanesnutr0910$kcal63, nhanesnutr0910$kcal64, nhanesnutr0910$kcal67, nhanesnutr0910$kcal71, nhanesnutr0910$kcal72, nhanesnutr0910$kcal73, nhanesnutr0910$kcal74, nhanesnutr0910$kcal75, nhanesnutr0910$kcal76, nhanesnutr0910$kcal77, nhanesnutr0910$kcal78, nhanesnutr0910$kcal81, nhanesnutr0910$kcal82, nhanesnutr0910$kcal83, nhanesnutr0910$kcal91, nhanesnutr0910$kcal92, nhanesnutr0910$kcal93, nhanesnutr0910$kcal94, nhanesnutr0910$kcal95, nhanesnutr0910$gram11, nhanesnutr0910$gram12, nhanesnutr0910$gram13, nhanesnutr0910$gram14, nhanesnutr0910$gram20, nhanesnutr0910$gram21, nhanesnutr0910$gram22, nhanesnutr0910$gram23, nhanesnutr0910$gram24, nhanesnutr0910$gram25, nhanesnutr0910$gram26, nhanesnutr0910$gram27, nhanesnutr0910$gram28, nhanesnutr0910$gram31, nhanesnutr0910$gram32, nhanesnutr0910$gram33, nhanesnutr0910$gram35, nhanesnutr0910$gram41, nhanesnutr0910$gram42, nhanesnutr0910$gram43, nhanesnutr0910$gram44, nhanesnutr0910$gram50, nhanesnutr0910$gram51, nhanesnutr0910$gram52, nhanesnutr0910$gram53, nhanesnutr0910$gram54, nhanesnutr0910$gram55, nhanesnutr0910$gram56, nhanesnutr0910$gram57, nhanesnutr0910$gram58, nhanesnutr0910$gram59, nhanesnutr0910$gram61, nhanesnutr0910$gram62, nhanesnutr0910$gram63, nhanesnutr0910$gram64, nhanesnutr0910$gram67, nhanesnutr0910$gram71, nhanesnutr0910$gram72, nhanesnutr0910$gram73, nhanesnutr0910$gram74, nhanesnutr0910$gram75, nhanesnutr0910$gram76, nhanesnutr0910$gram77, nhanesnutr0910$gram78, nhanesnutr0910$gram81, nhanesnutr0910$gram82, nhanesnutr0910$gram83, nhanesnutr0910$gram91, nhanesnutr0910$gram92, nhanesnutr0910$gram93, nhanesnutr0910$gram94, nhanesnutr0910$gram95)




colnames(nh9900) = c("age1c","sex","black","hisp","tob","sbp1c","cvdhx","bprx","oraldmrx","anticoag","statin","a1c",
                     "chol1","hdl1","creatin1c","ualbcre1","mortstat","ucod_leading","dodqtr","dodyear",
                     "permth_int","diq010","diq070","lbxglu",
                     "energy", "protein", "carb","totfat",
                     "satfat", "monofat", "polyfat",
                     "dietchol", "fiber", "vita", 
                     "caro", "vitb1", "vitb2",
                     "niacin", "vitb6", "folate",
                     "vitb12", "vitc", "vite",
                     "calc", "phos", "mag",
                     "iron", "zinc", "copp",
                     "na", "k", "sele",
                     "caff", "theobrom", "alcohol", "water",
                     "s040", "s060", "s080", "s100", "s120", "s140", "s160", "s180", 
                     "m161", "m181", "m201", "m221",
                     "p182", "p183", "p184", "p204", "p205", "p225","p226",
                     "kcal11", "kcal12", "kcal13", "kcal14", "kcal20", "kcal21", "kcal22", "kcal23", "kcal24", "kcal25", "kcal26", "kcal27", "kcal28", "kcal31", "kcal32", "kcal33", "kcal35", "kcal41", "kcal42", "kcal43", "kcal44", "kcal50", "kcal51", "kcal52", "kcal53", "kcal54", "kcal55", "kcal56", "kcal57", "kcal58", "kcal59", "kcal61", "kcal62", "kcal63", "kcal64", "kcal67", "kcal71", "kcal72", "kcal73", "kcal74", "kcal75", "kcal76", "kcal77", "kcal78", "kcal81", "kcal82", "kcal83", "kcal91", "kcal92", "kcal93", "kcal94", "kcal95", "gram11", "gram12", "gram13", "gram14", "gram20", "gram21", "gram22", "gram23", "gram24", "gram25", "gram26", "gram27", "gram28", "gram31", "gram32", "gram33", "gram35", "gram41", "gram42", "gram43", "gram44", "gram50", "gram51", "gram52", "gram53", "gram54", "gram55", "gram56", "gram57", "gram58", "gram59", "gram61", "gram62", "gram63", "gram64", "gram67", "gram71", "gram72", "gram73", "gram74", "gram75", "gram76", "gram77", "gram78", "gram81", "gram82", "gram83", "gram91", "gram92", "gram93", "gram94", "gram95")

colnames(nh0102) = c("age1c","sex","black","hisp","tob","sbp1c","cvdhx","bprx","oraldmrx","anticoag","statin","a1c",
                     "chol1","hdl1","creatin1c","ualbcre1","mortstat","ucod_leading","dodqtr","dodyear",
                     "permth_int","diq010","diq070","lbxglu",
                     "energy", "protein", "carb","totfat",
                     "satfat", "monofat", "polyfat",
                     "dietchol", "fiber", "vita", 
                     "caro", "vitb1", "vitb2",
                     "niacin", "vitb6", "folate",
                     "vitb12", "vitc", "vite",
                     "calc", "phos", "mag",
                     "iron", "zinc", "copp",
                     "na", "k", "sele",
                     "caff", "theobrom", "alcohol", "water",
                     "s040", "s060", "s080", "s100", "s120", "s140", "s160", "s180", 
                     "m161", "m181", "m201", "m221",
                     "p182", "p183", "p184", "p204", "p205", "p225","p226",
                     "kcal11", "kcal12", "kcal13", "kcal14", "kcal20", "kcal21", "kcal22", "kcal23", "kcal24", "kcal25", "kcal26", "kcal27", "kcal28", "kcal31", "kcal32", "kcal33", "kcal35", "kcal41", "kcal42", "kcal43", "kcal44", "kcal50", "kcal51", "kcal52", "kcal53", "kcal54", "kcal55", "kcal56", "kcal57", "kcal58", "kcal59", "kcal61", "kcal62", "kcal63", "kcal64", "kcal67", "kcal71", "kcal72", "kcal73", "kcal74", "kcal75", "kcal76", "kcal77", "kcal78", "kcal81", "kcal82", "kcal83", "kcal91", "kcal92", "kcal93", "kcal94", "kcal95", "gram11", "gram12", "gram13", "gram14", "gram20", "gram21", "gram22", "gram23", "gram24", "gram25", "gram26", "gram27", "gram28", "gram31", "gram32", "gram33", "gram35", "gram41", "gram42", "gram43", "gram44", "gram50", "gram51", "gram52", "gram53", "gram54", "gram55", "gram56", "gram57", "gram58", "gram59", "gram61", "gram62", "gram63", "gram64", "gram67", "gram71", "gram72", "gram73", "gram74", "gram75", "gram76", "gram77", "gram78", "gram81", "gram82", "gram83", "gram91", "gram92", "gram93", "gram94", "gram95")

colnames(nh0304) = c("age1c","sex","black","hisp","tob","sbp1c","cvdhx","bprx","oraldmrx","anticoag","statin","a1c",
                     "chol1","hdl1","creatin1c","ualbcre1","mortstat","ucod_leading","dodqtr","dodyear",
                     "permth_int","diq010","diq070","lbxglu",
                     "energy", "protein", "carb","totfat",
                     "satfat", "monofat", "polyfat",
                     "dietchol", "fiber", "vita", 
                     "caro", "vitb1", "vitb2",
                     "niacin", "vitb6", "folate",
                     "vitb12", "vitc", "vite",
                     "calc", "phos", "mag",
                     "iron", "zinc", "copp",
                     "na", "k", "sele",
                     "caff", "theobrom", "alcohol", "water",
                     "s040", "s060", "s080", "s100", "s120", "s140", "s160", "s180", 
                     "m161", "m181", "m201", "m221",
                     "p182", "p183", "p184", "p204", "p205", "p225","p226",
                     "kcal11", "kcal12", "kcal13", "kcal14", "kcal20", "kcal21", "kcal22", "kcal23", "kcal24", "kcal25", "kcal26", "kcal27", "kcal28", "kcal31", "kcal32", "kcal33", "kcal35", "kcal41", "kcal42", "kcal43", "kcal44", "kcal50", "kcal51", "kcal52", "kcal53", "kcal54", "kcal55", "kcal56", "kcal57", "kcal58", "kcal59", "kcal61", "kcal62", "kcal63", "kcal64", "kcal67", "kcal71", "kcal72", "kcal73", "kcal74", "kcal75", "kcal76", "kcal77", "kcal78", "kcal81", "kcal82", "kcal83", "kcal91", "kcal92", "kcal93", "kcal94", "kcal95", "gram11", "gram12", "gram13", "gram14", "gram20", "gram21", "gram22", "gram23", "gram24", "gram25", "gram26", "gram27", "gram28", "gram31", "gram32", "gram33", "gram35", "gram41", "gram42", "gram43", "gram44", "gram50", "gram51", "gram52", "gram53", "gram54", "gram55", "gram56", "gram57", "gram58", "gram59", "gram61", "gram62", "gram63", "gram64", "gram67", "gram71", "gram72", "gram73", "gram74", "gram75", "gram76", "gram77", "gram78", "gram81", "gram82", "gram83", "gram91", "gram92", "gram93", "gram94", "gram95")

colnames(nh0506) = c("age1c","sex","black","hisp","tob","sbp1c","cvdhx","bprx","oraldmrx","anticoag","statin","a1c",
                     "chol1","hdl1","creatin1c","ualbcre1","mortstat","ucod_leading","dodqtr","dodyear",
                     "permth_int","diq010","diq070","lbxglu",
                     "energy", "protein", "carb","totfat",
                     "satfat", "monofat", "polyfat",
                     "dietchol", "fiber", "vita", 
                     "caro", "vitb1", "vitb2",
                     "niacin", "vitb6", "folate",
                     "vitb12", "vitc", "vite",
                     "calc", "phos", "mag",
                     "iron", "zinc", "copp",
                     "na", "k", "sele",
                     "caff", "theobrom", "alcohol", "water",
                     "s040", "s060", "s080", "s100", "s120", "s140", "s160", "s180", 
                     "m161", "m181", "m201", "m221",
                     "p182", "p183", "p184", "p204", "p205", "p225","p226",
                     "kcal11", "kcal12", "kcal13", "kcal14", "kcal20", "kcal21", "kcal22", "kcal23", "kcal24", "kcal25", "kcal26", "kcal27", "kcal28", "kcal31", "kcal32", "kcal33", "kcal35", "kcal41", "kcal42", "kcal43", "kcal44", "kcal50", "kcal51", "kcal52", "kcal53", "kcal54", "kcal55", "kcal56", "kcal57", "kcal58", "kcal59", "kcal61", "kcal62", "kcal63", "kcal64", "kcal67", "kcal71", "kcal72", "kcal73", "kcal74", "kcal75", "kcal76", "kcal77", "kcal78", "kcal81", "kcal82", "kcal83", "kcal91", "kcal92", "kcal93", "kcal94", "kcal95", "gram11", "gram12", "gram13", "gram14", "gram20", "gram21", "gram22", "gram23", "gram24", "gram25", "gram26", "gram27", "gram28", "gram31", "gram32", "gram33", "gram35", "gram41", "gram42", "gram43", "gram44", "gram50", "gram51", "gram52", "gram53", "gram54", "gram55", "gram56", "gram57", "gram58", "gram59", "gram61", "gram62", "gram63", "gram64", "gram67", "gram71", "gram72", "gram73", "gram74", "gram75", "gram76", "gram77", "gram78", "gram81", "gram82", "gram83", "gram91", "gram92", "gram93", "gram94", "gram95")

colnames(nh0708) = c("age1c","sex","black","hisp","tob","sbp1c","cvdhx","bprx","oraldmrx","anticoag","statin","a1c",
                     "chol1","hdl1","creatin1c","ualbcre1","mortstat","ucod_leading","dodqtr","dodyear",
                     "permth_int","diq010","diq070","lbxglu",
                     "energy", "protein", "carb","totfat",
                     "satfat", "monofat", "polyfat",
                     "dietchol", "fiber", "vita", 
                     "caro", "vitb1", "vitb2",
                     "niacin", "vitb6", "folate",
                     "vitb12", "vitc", "vite",
                     "calc", "phos", "mag",
                     "iron", "zinc", "copp",
                     "na", "k", "sele",
                     "caff", "theobrom", "alcohol", "water",
                     "s040", "s060", "s080", "s100", "s120", "s140", "s160", "s180", 
                     "m161", "m181", "m201", "m221",
                     "p182", "p183", "p184", "p204", "p205", "p225","p226",
                     "kcal11", "kcal12", "kcal13", "kcal14", "kcal20", "kcal21", "kcal22", "kcal23", "kcal24", "kcal25", "kcal26", "kcal27", "kcal28", "kcal31", "kcal32", "kcal33", "kcal35", "kcal41", "kcal42", "kcal43", "kcal44", "kcal50", "kcal51", "kcal52", "kcal53", "kcal54", "kcal55", "kcal56", "kcal57", "kcal58", "kcal59", "kcal61", "kcal62", "kcal63", "kcal64", "kcal67", "kcal71", "kcal72", "kcal73", "kcal74", "kcal75", "kcal76", "kcal77", "kcal78", "kcal81", "kcal82", "kcal83", "kcal91", "kcal92", "kcal93", "kcal94", "kcal95", "gram11", "gram12", "gram13", "gram14", "gram20", "gram21", "gram22", "gram23", "gram24", "gram25", "gram26", "gram27", "gram28", "gram31", "gram32", "gram33", "gram35", "gram41", "gram42", "gram43", "gram44", "gram50", "gram51", "gram52", "gram53", "gram54", "gram55", "gram56", "gram57", "gram58", "gram59", "gram61", "gram62", "gram63", "gram64", "gram67", "gram71", "gram72", "gram73", "gram74", "gram75", "gram76", "gram77", "gram78", "gram81", "gram82", "gram83", "gram91", "gram92", "gram93", "gram94", "gram95")

colnames(nh0910) = c("age1c","sex","black","hisp","tob","sbp1c","cvdhx","bprx","oraldmrx","anticoag","statin","a1c",
                     "chol1","hdl1","creatin1c","ualbcre1","mortstat","ucod_leading","dodqtr","dodyear",
                     "permth_int","diq010","diq070","lbxglu",
                     "energy", "protein", "carb","totfat",
                     "satfat", "monofat", "polyfat",
                     "dietchol", "fiber", "vita", 
                     "caro", "vitb1", "vitb2",
                     "niacin", "vitb6", "folate",
                     "vitb12", "vitc", "vite",
                     "calc", "phos", "mag",
                     "iron", "zinc", "copp",
                     "na", "k", "sele",
                     "caff", "theobrom", "alcohol", "water",
                     "s040", "s060", "s080", "s100", "s120", "s140", "s160", "s180", 
                     "m161", "m181", "m201", "m221",
                     "p182", "p183", "p184", "p204", "p205", "p225","p226",
                     "kcal11", "kcal12", "kcal13", "kcal14", "kcal20", "kcal21", "kcal22", "kcal23", "kcal24", "kcal25", "kcal26", "kcal27", "kcal28", "kcal31", "kcal32", "kcal33", "kcal35", "kcal41", "kcal42", "kcal43", "kcal44", "kcal50", "kcal51", "kcal52", "kcal53", "kcal54", "kcal55", "kcal56", "kcal57", "kcal58", "kcal59", "kcal61", "kcal62", "kcal63", "kcal64", "kcal67", "kcal71", "kcal72", "kcal73", "kcal74", "kcal75", "kcal76", "kcal77", "kcal78", "kcal81", "kcal82", "kcal83", "kcal91", "kcal92", "kcal93", "kcal94", "kcal95", "gram11", "gram12", "gram13", "gram14", "gram20", "gram21", "gram22", "gram23", "gram24", "gram25", "gram26", "gram27", "gram28", "gram31", "gram32", "gram33", "gram35", "gram41", "gram42", "gram43", "gram44", "gram50", "gram51", "gram52", "gram53", "gram54", "gram55", "gram56", "gram57", "gram58", "gram59", "gram61", "gram62", "gram63", "gram64", "gram67", "gram71", "gram72", "gram73", "gram74", "gram75", "gram76", "gram77", "gram78", "gram81", "gram82", "gram83", "gram91", "gram92", "gram93", "gram94", "gram95")


nhall = rbind(nh9900)#,nh0102,nh0304,nh0506,nh0708,nh0910)

nhall$dm = (nhall$a1c>=6.5)|(nhall$lbxglu>=126)|(nhall$diq010==1)

nhall$cvddeath = (nhall$mortstat=="Assumed Deceased")&((nhall$ucod_leading=="001")|(nhall$ucod_leading=="005"))
# nhall$allmort = (nhall$mortstat=="Assumed Deceased")

nhall$cvdhx[is.na(nhall$cvdhx)==1]=0
nhall$dm[is.na(nhall$dm)==1]=0
nhall$cvddeath[is.na(nhall$cvddeath)==1]=0

library(mice)
nhallsubnames = setdiff(names(nhall),c("mortstat","ucod_leading","permth_int","diq010","diq070","dodqtr","dodyear"))
nhallsub = nhall[,nhallsubnames]
set.seed(100)
nhallimp = mice(nhallsub,m=1)

save("~/Documents/Epi/Research/Methods/ML for nutr/ML for nutr.RData")


load("~/Documents/Epi/Research/Methods/ML for nutr/ML for nutr.RData")

library(mice)
nhallcomp = complete(nhallimp)

library(caret)
set.seed(100)
splitIndex <- createDataPartition(nhallcomp$cvddeath, p = .8, list = FALSE, times = 1) # randomly splitting the data into train and test sets
trainSplit <- nhallcomp[ splitIndex,]
testSplit <- nhallcomp[-splitIndex,]
prop.table(table(trainSplit$cvddeath))

# making a balanced subset of the training data
# library(DMwR)
# set.seed(100)
# trainSplit <- SMOTE(cvddeath ~ ., trainSplit, perc.over = 600, perc.under=100) 
# prop.table(table(testSplit$cvddeath))

library(h2o)  
h2o.init()
h2o.removeAll() 
train <- as.h2o(trainSplit)
test <- as.h2o(testSplit)


# Identify predictors and response
y <- "cvddeath"
x <- setdiff(names(train), c("cvddeath","mortstat","ucod_leading","permth_int"))

# For binary classification, response should be a factor
train[,y] <- as.factor(train[,y])
test[,y] <- as.factor(test[,y])


# The Automatic Machine Learning (AutoML) function automates the supervised machine learning model training process. 
# The current version of AutoML trains and cross-validates a Random Forest, an Extremely-Randomized Forest, 
# a random grid of Gradient Boosting Machines (GBMs), a random grid of Deep Neural Nets, 
# and then trains a Stacked Ensemble using all of the models.

aml <- h2o.automl(x = x, y = y,
                  training_frame = train,
                  leaderboard_frame = test,
                  max_runtime_secs = 30)

# View the AutoML Leaderboard
lb <- aml@leaderboard
lb

# model_id      auc  logloss
# 1 StackedEnsemble_BestOfFamily_0_AutoML_20180122_073837 0.999768 0.006153
# 2    StackedEnsemble_AllModels_0_AutoML_20180122_073837 0.999768 0.006153
# 3                          DRF_0_AutoML_20180122_073837 0.999767 0.006493

# The leader model is stored here
aml@leader





#### PARKING LOT ####

# save the model
model_path <- h2o.saveModel(object=aml@leader, path=getwd(), force=TRUE)

print(model_path)

# load the model
saved_model <- h2o.loadModel(model_path)

testmodel = h2o.randomForest(x = x, y = y, training_frame = train, ntrees=500, max_depth = 100)
summary(testmodel)

pred <-predict(testmodel, test)  


### THE SCRIPTS BELOW ARE OLD FUNCTIONS FOR ASSESSING CALIBRAITON; CAN REPLACE WITH HOSMER-LEMESHOW TEST FOR LOGISTIC OUTCOMES; THE FUNCTIONS BELOW ARE FOR SURVIVAL/TIME-TO-EVENT DATA

kmdec=function(dec.num,dec.name, datain, adm.cens){
  stopped=0
  data.sub=datain[datain[,dec.name]==dec.num,]
  if (sum(data.sub$out)>1){
    avsurv=survfit(Surv(tvar,out) ~ 1, data=datain[datain[,dec.name]==dec.num,], error="g")
    avsurv.est=ifelse(min(avsurv$time)<=adm.cens,avsurv$surv[avsurv$time==max(avsurv$time[avsurv$time<=adm.cens])],1)
    avsurv.stderr=ifelse(min(avsurv$time)<=adm.cens,avsurv$std.err[avsurv$time==max(avsurv$time[avsurv$time<=adm.cens])],0)
    avsurv.stderr=avsurv.stderr*avsurv.est
    avsurv.num=ifelse(min(avsurv$time)<=adm.cens,avsurv$n.risk[avsurv$time==max(avsurv$time[avsurv$time<=adm.cens])],0)
  } else {
    return(c(0,0,0,0,stopped=-1))
  }
  if (sum(data.sub$out)<5) stopped=1
  c(avsurv.est, avsurv.stderr, avsurv.num, dec.num, stopped) 
}
GND.calib = function(pred, tvar, out, cens.t, groups, adm.cens){
  tvar.t=ifelse(tvar>adm.cens, adm.cens, tvar)
  out.t=ifelse(tvar>adm.cens, 0, out)
  datause=data.frame(pred=pred, tvar=tvar.t, out=out.t, count=1, cens.t=cens.t, dec=groups)
  numcat=length(unique(datause$dec))
  groups=sort(unique(datause$dec))
  kmtab=matrix(unlist(lapply(groups,kmdec,"dec",datain=datause, adm.cens)),ncol=5, byrow=TRUE)
  if (any(kmtab[,5] == -1)) stop("Stopped because at least one of the groups contains <2 events. Consider collapsing some groups.")
  else if (any(kmtab[,5] == 1)) warning("At least one of the groups contains < 5 events. GND can become unstable.\
                                        (see Demler, Paynter, Cook 'Tests of Calibration and Goodness of Fit in the Survival Setting' DOI: 10.1002/sim.6428) \
                                        Consider collapsing some groups to avoid this problem.")
  hltab=data.frame(group=kmtab[,4],
                   totaln=tapply(datause$count,datause$dec,sum),
                   censn=tapply(datause$cens.t,datause$dec,sum),
                   numevents=tapply(datause$out,datause$dec,sum),
                   expected=tapply(datause$pred,datause$dec,sum),
                   kmperc=1-kmtab[,1], 
                   kmvar=kmtab[,2]^2, 
                   kmnrisk=kmtab[,3],
                   expectedperc=tapply(datause$pred,datause$dec,mean))
  hltab$kmnum=hltab$kmperc*hltab$totaln
  hltab$GND_component=ifelse(hltab$kmvar==0, 0,(hltab$kmperc-hltab$expectedperc)^2/(hltab$kmvar))
  print(hltab[c(1,2,3,4,10,5,6,9,7,11)], digits=4)
  plot(tapply(datause$pred,datause$dec,mean),1-kmtab[,1],xlab="Expected K-M rate",ylab="Observed K-M rate",xlim=c(0,1),ylim=c(0,1))
  abline(a=0,b=1, col = "gray60")
  calline = lm(hltab$kmperc~hltab$expectedperc)
  c(df=numcat-1, chi2gw=sum(hltab$GND_component),pvalgw=1-pchisq(sum(hltab$GND_component),numcat-1),slope=calline$coefficients[2],intercept = calline$coefficients[1])
}

