install.packages("readxl")
install.packages("ggplot2")
install.packages("tseries")  
library(ggplot2)
library(tseries)
library(readxl)
verim2 <- read.csv("genc_issizlik_verisi.csv", sep = ";", dec = ",", header = TRUE)
veri_df <- as.data.frame(veri_matrisi)

colnames(veri_df) <- c("issizlikorani", "katilmaorani", "ln_enflasyon", "ln_sanayi")

issizlik_ts  <- ts(veri_df$issizlikorani, start=c(2019, 1), frequency=12)
katilim_ts   <- ts(veri_df$katilmaorani, start=c(2019, 1), frequency=12)
enflasyon_ts <- ts(veri_df$ln_enflasyon, start=c(2019, 1), frequency=12)
sanayi_ts    <- ts(veri_df$ln_sanayi, start=c(2019, 1), frequency=12)

veri_final <- cbind(issizlik_ts, katilim_ts, enflasyon_ts, sanayi_ts)
colnames(veri_final) <- c("Genc_Issizlik", "Isgucune_Katilim", "Log_Enflasyon", "Log_Sanayi_Uretimi")

# Betimsel İstatistikler
summary(veri_final)

# Genç İşsizlik Oranı ADF Testi
adf_issizlik <- ur.df(issizlik_ts, type = "trend", selectlags = "AIC")
summary(adf_issizlik)
# Genç İşsizlik için Birinci Fark ADF Testi
adf_diff_issizlik <- ur.df(diff(issizlik_ts), type = "drift", selectlags = "AIC")
summary(adf_diff_issizlik) 


# İşgücüne Katılım Testi
adf_katilim <- ur.df(katilim_ts, type = "trend", selectlags = "AIC")
summary(adf_katilim)

adf_diff_katilim <- ur.df(diff(katilim_ts), type = "drift", selectlags = "AIC")
summary(adf_diff_katilim)

#  Log_Enflasyon Testi 
adf_enflasyon <- ur.df(enflasyon_ts, type = "trend", selectlags = "AIC")
summary(adf_enflasyon)

adf_diff_enflasyon <- ur.df(diff(enflasyon_ts), type = "drift", selectlags = "AIC")
summary(adf_diff_enflasyon)

# Log_Sanayi Testi 
adf_sanayi <- ur.df(sanayi_ts, type = "trend", selectlags = "AIC")
summary(adf_sanayi)

adf_diff_sanayi <- ur.df(diff(sanayi_ts), type = "drift", selectlags = "AIC")
summary(adf_diff_sanayi)

# Gecikme Uzunluğu Seçim Kriterleri (VAR Selection)
lag_kriterleri <- VARselect(veri_final, lag.max = 12, type = "both")

# Sonuçları 
print(lag_kriterleri$selection)

# Johansen Testi 
johansen_sonuc <- ca.jo(veri_final, type = "trace", ecdet = "const", K = 2)

# Test sonuçları
summary(johansen_sonuc)

# VECM Modeline Dönüştürme
vecm_model <- VECM(veri_final, lag = 2, estim = "ML", r = 2)
summary(vecm_model)


plot.ts(veri_final, 
        main = "Değişkenlerin Zaman Serisi Analizi (Düzey)", 
        col = "pink", 
        lwd = 2, 
        nc = 2) 


# Birinci farkların grafiği
diff_veri <- diff(veri_final)
plot.ts(diff_veri, 
        main = "Serilerin Birinci Farkları (Durağan Hal)", 
        col = "darkred", 
        lwd = 1.5, 
        nc = 2)


vecm_var <- vec2var(johansen_sonuc, r = 2)

# Sanayi Üretimi -> Genç İşsizlik Tepkisi
irf_sanayi <- irf(vecm_var, impulse = "Log_Sanayi_Uretimi", 
                  response = "Genc_Issizlik", n.ahead = 12, boot = TRUE)

plot(irf_sanayi, main = "Sanayi Üretimindeki Şoka Genç İşsizliğin Tepkisi", 
     ylab = "Genç İşsizlik Oranı", xlab = "Ay")


# Varyans Ayrıştırma
fevd_analizi <- fevd(vecm_var, n.ahead = 10)

plot(fevd_analizi$Genc_Issizlik, 
     main = "Genç İşsizlik Varyans Ayrıştırması", 
     col = rainbow(4))
legend("bottomright", legend = colnames(veri_final), fill = rainbow(4))




# Portmanteau Testi
install.packages("vars")
library(vars)
otokorelasyon_testi <- serial.test(vecm_var, lags.pt = 12, type = "PT.asymptotic")
print(otokorelasyon_testi)


degisen_varyans_testi <- arch.test(vecm_var, lags.multi = 5, multivariate.only = TRUE)
print(degisen_varyans_testi)


normallik_testi <- normality.test(vecm_var, multivariate.only = TRUE)
print(normallik_testi)



install.packages("strucchange")
library(strucchange)

kirilma_testi <- breakpoints(diff(Genc_Issizlik) ~ diff(Log_Sanayi_Uretimi) + diff(Log_Enflasyon), data = as.data.frame(veri_final))

summary(kirilma_testi)

plot(kirilma_testi)


za_issizlik <- ur.za(issizlik_ts, model = "both", lag = 2)
summary(za_issizlik)

