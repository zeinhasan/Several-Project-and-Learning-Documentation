#Contoh pengambilan data sampel
pop <- 1:10

#pengambilan sampel dengan pengembalian
sample1 <- sample(pop,size=5,replace=T)
sample1
#pengambilan sampel tanpa pengembalian
sample2 <- sample(pop,size=5,replace=F)
sample2

#####Distribusi Normal

###Data Tunggal
#Probability density dari distribusi normal mean = 47.6 dan sd = 10.3
#P(X=50)
dnorm(50,mean=47.6,sd=10.3)
#Cumulative Distribution 47.6 dari distribusi normal mean = 47.6 dan sd = 10.3
#P(X<=47.6)
pnorm(47.6,mean=47.6,sd=10.3,lower.tail = TRUE)
#Inverse Cumulative 0.85 dari distribusi normal mean = 47.6 dan sd = 10.3
#P(X<=x)=0.85. x = ?
qnorm(0.85,mean=47.6,sd=10.3)

###Data Tidak Tunggal
#Buat data waktu masuk dari pekerja perusahaan X
late = c(12,23,9,25,9,30,2,10,25,9)
#cari mean dan standar deviasi nya
mean(late)
sd(late)
#masukkan nilai mean dan standar deviasi ke dalam fungsi pnorm()
prob = pnorm(late,mean=15.4,sd=9.42)
#jadikan satu di dalam suatu dataframe
table = data.frame(late,prob)
table

#####Distribusi t

###Data Tunggal
#Probability density dari distribusi t dengan derajat bebas 1000
#P(X=1.96)
dt(1.96,1000)
#Cumulative Distribution dari distribusi t dengan derajat bebas 20
#P(X<=1.645)
pt(1.645,20)
#Inverse Cumulative dari distribusi t dengan derajat bebas 46
#P(X<=x)=0.05. x = ?
qt(0.05,20)

###Data Tidak Tunggal
#Buat data terlebih dahulu
t.percent <- c(0.05,0.1,0.9,0.95)
#Cari nilai invers kumulatif nya
value.t <- qt(t.percent,100)
result.t <- data.frame(percentile=t.percent,value=value.t)
result.t

#####Distribusi F

###Data Tunggal
#Probability density dari distribusi f dengan derajat bebas 3 dan 5
#P(X=2.67)
df(2.67,3,5)
#Cumulative Distribution dari distribusi F dengan derajat bebas 3 dan 5
#P(X>2.448)
pf(2.448,3,5,lower.tail=F)
#Inverse Cumulative dari distribusi t dengan derajat bebas 3 dan 14
#P(X<=x)=0.975. x = ?
qf(.975,3,14)

###Data Tidak Tunggal
#Buat data terlebih dahulu
f.example <- c(1.57,3.19,4.24)
#Cari nilai invers kumulatif nya
value.f <- df(f.example,3,14)
result.f <- data.frame(x=f.example,value=value.f)
result.f

### Latihan Soal

