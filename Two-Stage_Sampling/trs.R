#read.csv Ū��csv�ɮ�
#�N��Ʀs����Rdata�R�W��data_all
data_all <- read.csv("~/Desktop/���j�ҵ{/106���/�G���q/data.csv"
                     ,header=T
                     ,fileEncoding = "BIG5")
str(data_all)
#�N�Ĥ@��ϰ�O���W�٧אּ�^��area��K�@�~
colnames(data_all)[1]="area"

#area�@���������s�A��unique�d�ݦ@���X�ӿ����A�`�@20�ӡAM=20
allcity<-unique(data_all$area)
allcity

library(sampling) 
first_sample=NULL
##�qM�Ӥl���餤²���H����Xm=5��
#cluster���s��ˡAsrswor���X����^�Bsrswr���X��^
set.seed(3)
first_sample<-cluster(data_all
                      ,clustername=c("area")
                      ,size=5
                      ,method=c("srswor"))
unique(first_sample$area)

#����Ω�˼Ƥ��#����Ω�˼Ƥ��
#��X��M�μ˥���
table_first_sample<-as.data.frame(table(first_sample$area)
                                  [which(table(first_sample$area)!=0)])


#�˥���Ұt�m
sample_size=120
table_first_sample$p<-table_first_sample$Freq/sum(table_first_sample$Freq)
table_first_sample$sample_size<-round(sample_size*table_first_sample$p)
table_first_sample#�Ĥ@���q��˪��p

sum(table_first_sample$p)#���Ҥ�Ҧ��p����ҥ[�`�O�_�ŦX���v���z���]
sum(table_first_sample$sample_size)#�����`��˼˥��ƬO�_���]�w��120��

#���h���strata() stratanames���h���̾�,size�U�h�n�Q��X���˥���
second_sample<-strata(first_sample, stratanames=c("area")
                      , size=table_first_sample$sample_size
                      ,method=c("srswor"))

#��X�����H�μ˥���
table_second_sample<-as.data.frame(table(second_sample$area)
                                   [which(table(second_sample$area)!=F)])

table_first_sample
table_second_sample

output<-getdata(data_all,second_sample)#���X��˸��
write.csv(output,"~/Desktop/���j�ҵ{/106���/�G���q/output.csv"
          ,row.names = FALSE
          ,fileEncoding = "BIG5")

