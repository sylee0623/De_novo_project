HR<-read.table("C://Users//seoye//OneDrive - 한양대학교//연구실//HR_unfiltered.table",header=TRUE)
CCC<-read.table("C://Users//seoye//OneDrive - 한양대학교//연구실//CCC_unfiltered.table",header=TRUE)
non_CCC<-read.table("C://Users//seoye//OneDrive - 한양대학교//연구실//non_CCC_unfiltered.table",header=TRUE)

indel_info<-c("c")
for(i in 1:nrow(HR)){
  if(HR$EVENTLENGTH[i]>0){indel_info[i]<-"insertion"}
  else{indel_info[i]<-"deletion"}
}
HR<-cbind(HR,indel_info)

indel_info<-c("c")
for(i in 1:nrow(CCC)){
  if(CCC$EVENTLENGTH[i]>0){indel_info[i]<-"insertion"}
  else{indel_info[i]<-"deletion"}
}
CCC<-cbind(CCC,indel_info)

indel_info<-c("c")
for(i in 1:nrow(non_CCC)){
  if(non_CCC$EVENTLENGTH[i]>0){indel_info[i]<-"insertion"}
  else{indel_info[i]<-"deletion"}
}
non_CCC<-cbind(non_CCC,indel_info)

total<-rbind(HR,CCC,non_CCC)


HR<-HR[complete.cases(HR),]
CCC<-CCC[complete.cases(CCC),]
non_CCC<-non_CCC[complete.cases(non_CCC),]

dens<-density(HR_deletion$FS)

# dy/dx first derivative
first<-diff(dens$y)/diff(dens$x)

# Condition for inflection point
flections<-c()
for(i in 1:length(first)){
  flections<-c(flections,i*max(HR_deletion$FS)/511)
}

der<-data.frame(xaxis=flections,yaxis=first)

ggplot(HR_deletion)+geom_density(aes(x=FS,group=indel_info,fill=indel_info),alpha=0.3)+annotate("rect", xmin=30, xmax=12.88, ymin=0, ymax=0.13, alpha=0.1, fill="blue")

+geom_segment(aes(xend =threshold, yend = 0.01, x = threshold+1, y = der_part$yaxis[min]+0.1), arrow = arrow(), color='red')


der_part<-der[der$xaxis>10,]
der_part<-der_part[der_part$xaxis<15,]
min<-which.min(abs(der_part$yaxis - 0))

ggplot(der)+geom_line(aes(x=xaxis,y=yaxis))


threshold<-der_part$xaxis[min]




+geom_segment(aes(xend = der_part$xaxis[min], yend = 0.045, x = der_part$xaxis[min]+1, y = 0.06), arrow = arrow(), color='red')


#FS
HR_insertion<-HR[HR$EVENTLENGTH>0,]
HR_deletion<-HR[HR$EVENTLENGTH<0,]

CCC_insertion<-CCC[CCC$EVENTLENGTH >0,]
CCC_deletion<-CCC[CCC$EVENTLENGTH<0,]

non_CCC_insertion<-non_CCC[non_CCC$EVENTLENGTH >0,]
non_CCC_deletion<-non_CCC[non_CCC$EVENTLENGTH<0,]

HR_FS_insertion<-HR_insertion[HR_insertion$FS <14,]
HR_FS_deletion<-HR_deletion[HR_deletion$FS <12.43,]
CCC_FS_insertion<-CCC_insertion[CCC_insertion$FS<10.57,]
CCC_FS_deletion<-CCC_deletion[CCC_deletion$FS<10.97,]
non_CCC_FS_insertion<-non_CCC_insertion[non_CCC_insertion$FS<18.83,]
non_CCC_FS_deletion<-non_CCC_deletion[non_CCC_deletion$FS<14.33,]


HR_SOR_insertion<-HR_FS_insertion[HR_FS_insertion$SOR <2.94,]
HR_SOR_deletion<-HR_FS_deletion[HR_FS_deletion$SOR <2.51,]
CCC_SOR_insertion<-CCC_FS_insertion[CCC_FS_insertion$SOR<2.92,]
CCC_SOR_deletion<-CCC_FS_deletion[CCC_FS_deletion$SOR<=2.89,]
non_CCC_SOR_insertion<-non_CCC_FS_insertion[non_CCC_FS_insertion$SOR<3.29,]
non_CCC_SOR_deletion<-non_CCC_FS_deletion[non_CCC_FS_deletion$SOR<3.81,]

HR_QD_insertion<-HR_SOR_insertion[HR_SOR_insertion$QD >13.5,]
HR_QD_deletion<-HR_SOR_deletion[HR_SOR_deletion$QD >12.04,]
CCC_QD_insertion<-CCC_SOR_insertion[CCC_SOR_insertion$QD>13.0,]
CCC_QD_deletion<-CCC_SOR_deletion[CCC_SOR_deletion$QD>11.6,]
non_CCC_QD_insertion<-non_CCC_SOR_insertion[non_CCC_SOR_insertion$QD>13.3,]
non_CCC_QD_deletion<-non_CCC_SOR_deletion[non_CCC_SOR_deletion$QD>16.67,]


non_CCC_result_deletion<-non_CCC_QD_deletion[non_CCC_QD_deletion$MQ==60,]
non_CCC_result_inserion<-non_CCC_QD_insertion[non_CCC_QD_insertion$MQ==60,]
CCC_result_deletion<-CCC_QD_deletion[CCC_QD_deletion$MQ==60,]
CCC_result_inserion<-CCC_QD_insertion[CCC_QD_insertion$MQ==60,]
HR_result_deletion<-HR_QD_deletion[HR_QD_deletion$MQ==60,]
HR_result_inserion<-HR_QD_insertion[HR_QD_insertion$MQ==60,]

non_CCC_result_deletion<-non_CCC_result_deletion[non_CCC_result_deletion$MQRankSum==0,]
non_CCC_result_inserion<-non_CCC_result_inserion[non_CCC_result_inserion$MQRankSum==0,]
CCC_result_deletion<-CCC_result_deletion[CCC_result_deletion$MQRankSum==0,]
CCC_result_inserion<-CCC_result_inserion[CCC_result_inserion$MQRankSum==0,]
HR_result_deletion<-HR_result_deletion[HR_result_deletion$MQRankSum==0,]
HR_result_inserion<-HR_result_inserion[HR_result_inserion$MQRankSum==0,]


total<-rbind(non_CCC_result_deletion,non_CCC_result_inserion,CCC_result_deletion,CCC_result_inserion,HR_result_deletion,HR_result_inserion)
