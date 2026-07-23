# Türkiye'de Genç İşsizliğinin Makroekonomik Belirleyicileri (2019-2026)
Bu proje, R programlama kullanılarak Türkiye'deki genç işsizlik oranını etkileyen makroekonomik faktörleri zaman serisi ekonometrisi (VECM) ile modellemektedir.  

Proje Özeti ve Amacı: COVID-19 pandemisi ve yüksek enflasyonist süreçlerin işgücü piyasası üzerindeki kısa ve uzun dönemli etkilerini ölçmek.  
Veri Kaynakları: TÜİK ve TCMB'den (EVDS) alınan Ocak 2019 - Mart 2026 dönemi aylık makroekonomik veriler.  
Uygulanan Yöntemler: ADF & Zivot-Andrews Birim Kök Testleri, Johansen Eşbütünleşme Analizi, Vektör Hata Düzeltme Modeli (VECM) ve Tanısal Testler (Otokorelasyon, ARCH).  

Temel Çıktılar ve İş İçgörüleri
Sanayi Üretimi Etkisi: Sanayi üretim endeksindeki artışlar uzun dönemde genç işsizliğini belirgin bir şekilde azaltmaktadır.  
Enflasyon: İktisadi beklentilerle uyumlu olarak, enflasyondaki artışlar uzun dönemde genç işsizliği azaltıcı etki yaratmaktadır.  
Hata Düzeltme Hızı: Piyasada oluşan kısa dönemli makroekonomik şoklar, yaklaşık 3 ay gibi bir sürede düzeltilerek (Katsayı: -0.34) yeniden uzun dönem dengesine ulaşmaktadır.

Kullanılan Teknolojiler
Dil: R Programlama
Paketler: tseries, urca, vars, tsDyn, strucchange, ggplot2



# Macroeconomic Determinants of Youth Unemployment in Turkey (2019-2026)  
This project models the macroeconomic factors affecting the youth unemployment rate in Turkey using time series econometrics (VECM) with R programming.  

Project Overview
Objective: To measure the short and long-term effects of the COVID-19 pandemic and high inflationary periods on the labor market.  
Data Sources: Monthly macroeconomic data from TURKSTAT (TÜİK) and CBRT (TCMB EVDS) covering the January 2019 - March 2026 period.  
Methods Applied: ADF & Zivot-Andrews Unit Root Tests, Johansen Cointegration Analysis, Vector Error Correction Model (VECM), and Diagnostic Tests (Autocorrelation, ARCH).  


Key Findings & Business Insights
Industrial Production Effect: Increases in the industrial production index significantly reduce youth unemployment in the long run.  
Inflation: Consistent with economic expectations, increases in inflation have a reducing effect on youth unemployment in the long run.  
Error Correction Speed: Short-term macroeconomic shocks in the market are corrected (Coefficient: -0.34) and return to long-term equilibrium in approximately 3 months.    

Technologies Used
Language: R Programming
Packages: tseries, urca, vars, tsDyn, strucchange, ggplot2
