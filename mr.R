rm(list = ls(all=TRUE))

library(data.table)
library(tidyverse)
library(SUMnlmr)
library(ggplot2)

#4.fcm
summ_bin<-create_nlmr_summary(y=dt$fcm, 
                              x=dt$rc, 
                              g=dt$rc_grs, 
                              covar=matrix(data=c(dt$age, dt$sex), ncol=2), 
                              family="binomial", 
                              q=10, 
                              strata_method="ranked", 
                              extra_statistics=T, 
                              report_GR=T, 
                              report_het=T)
model<- with(summ_bin$summary, 
             frac_poly_summ_mr(bx=bx, 
                               by=by, 
                               bxse=bxse, 
                               byse=byse, 
                               xmean=xmean,  
                               family="binomial", 
                               fig=T))
summary(model)
rc.grs.fcm <- as.data.frame(model$figure$data)

p <- ggplot(rc.grs.fcm) +
  geom_ribbon(aes(ymin = lci, ymax = uci, x=x), fill = "darkred", alpha = 0.15) +
  geom_line(aes(x=x,y=yest), color="darkred", linewidth=0.3, alpha=1, linetype=1) +
  scale_color_manual(values = c("darkred")) +
  geom_hline(yintercept = 1, color="black", linetype="dashed", linewidth=0.25)+
  scale_y_continuous(breaks=c(0.6, 0.8, 1, 1.2, 1.4)) +
  scale_x_continuous(breaks=c(0, 0.3, 0.6, 0.9, 1.2, 1.5)) +
  xlab("Remnant cholesterol, mmol/L") +
  ylab("Causal OR for first cardiometabolic disease") +
  theme_classic()
p <- p + 
  theme(axis.title = element_text(size = 8),
        axis.text = element_text(size = 7, color = "black"),  
        axis.line = element_line(linetype=1, color="black", linewidth=0.3),   
        axis.ticks = element_line(linetype=1, color="black", linewidth=0.3)) 
p







