# Code for model predictions
# Set up ####
nocc <- 38 # Number of occasions
xgr <- seq(50000, 7e+05, 10000) # Vector of x coordinates
ygr <- seq(0, 1250000, 10000) # Vector of y coordinates
gr <- expand.grid(xgr, ygr) # Make grid of coordinates
xgrp <- rep(gr[,1], nocc) # Rep x coords for each occasion
ygrp <- rep(gr[,2], nocc) # Rep y coords for each occasion
tgr <- rep(1:nocc, each = nrow(gr)) # Each x/y coord combination per occasion

# Episyrphus balteatus ####
predict_xyt <- predict(mb, 
                       visit_data_balt,
                       data.table(occasion = tgr,
                                  x = xgrp,
                                  y = ygrp),
                       nboot = 1000)
saveRDS(predict_xyt, file = "Ebalt_predict.Rdata")

png(file="balt_pred_rough.png",
    width=600, height=350)
ggplot(data.frame(x = xgrp,
                  y = ygrp,
                  t = tgr,
                  psi = predict_xyt$psi)) +
  geom_tile(aes(x = x,
                y = y,
                group = t,
                fill = psi)) + 
  theme_bw() +
  facet_wrap(~t) +
  scale_x_continuous("x") +
  scale_y_continuous("y") +
  scale_fill_viridis_c("Occupancy")
dev.off()
# Eristalis tenax ####
predict_xyt_tenax <- predict(mt, 
                             visit_data_tenax,
                             data.table(occasion = tgr,
                                        x = xgrp,
                                        y = ygrp),
                             nboot = 1000)
saveRDS(predict_xyt_tenax, file = "Etenax_predict.Rdata")

png(file="tenax_pred_rough.png",
    width=600, height=350)
ggplot(data.frame(x = xgrp,
                  y = ygrp,
                  t = tgr,
                  psi = predict_xyt_tenax$psi)) +
  geom_tile(aes(x = x,
                y = y,
                group = t,
                fill = psi)) + 
  theme_bw() +
  facet_wrap(~t) +
  scale_x_continuous("x") +
  scale_y_continuous("y") +
  scale_fill_viridis_c("Occupancy")
dev.off()
# Sphaerophoria scripta ####
predict_xyt_scr <- predict(ms, 
                           visit_data_script, 
                           data.table(occasion = tgr,
                                      x = xgrp,
                                      y = ygrp),
                           nboot = 1000)
saveRDS(predict_xyt_scr, file = "Sscripta_predict.Rdata")

png(file="scr_pred_rough.png",
    width=600, height=350)
ggplot(data.frame(x = xgrp,
                  y = ygrp,
                  t = tgr,
                  psi = predict_xyt_scr$psi)) +
  geom_tile(aes(x = x,
                y = y,
                group = t,
                fill = psi)) + 
  theme_bw() +
  facet_wrap(~t) +
  scale_x_continuous("x") +
  scale_y_continuous("y") +
  scale_fill_viridis_c("Occupancy")
dev.off()
