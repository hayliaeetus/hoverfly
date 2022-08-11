# Episyrphus balteatus
source("Dataset_Sorting.R")

# Basic model ####
m0_balt <- fit_occu(list(psi ~ 1, p ~ 1), 
                    visit_data_balt, site_data) # Null model
# Temporal only ####
# Without smooth
m_balt_tpsi_n <- fit_occu(list(psi ~ occasion,
                               p ~ 1),
                          visit_data_balt,
                          site_data)
m_balt_tp_n <- fit_occu(list(psi ~ 1,
                             p ~ occasion),
                        visit_data_balt,
                        site_data)
m_balt_t_n <- fit_occu(list(psi ~ occasion,
                            p ~ occasion),
                       visit_data_balt,
                       site_data)
# With smooth
m_balt_tpsi <- fit_occu(list(psi ~ s(occasion, bs = "cs",
                                     k = 38), 
                             p ~ 1), 
                        visit_data_balt, 
                        site_data) # Just psi
m_balt_tp <- fit_occu(list(psi ~ 1, 
                           p ~ s(occasion, bs = "cs",
                                 k = 38)),
                      visit_data_balt,
                      site_data) # Just p

m_balt_t <- fit_occu(list(psi ~ s(occasion, bs = "cs", k = 38),
                          p ~ s(occasion, bs = "cs", k = 38)), 
                     visit_data_balt, 
                     site_data) # Both
# Compare
AIC(m0_balt,
    m_balt_tpsi, m_balt_tpsi_n,
    m_balt_tp, m_balt_tp_n,
    m_balt_t, m_balt_t_n)
# AIC prefers smooth on occasion for both p and psi

# Spatial only ####
# Without smooth
m_balt_spsi_n <- fit_occu(list(psi ~ x * y,
                               p ~ 1),
                          visit_data_balt,
                          site_data)
# With smooth
m_balt_spsi <- fit_occu(list(psi ~ t2(x, y,
                                      bs = "ts",
                                      d = 2),
                             p ~ 1), 
                        visit_data_balt, 
                        site_data) # Spatial psi
# Compare
AIC(m_balt_spsi, m_balt_spsi_n)
# AIC prefers spatial smooth
m_balt_spsi_tp <- fit_occu(list(psi ~ t2(x, y,
                                         bs = "ts",
                                         d = 2),
                                p ~ s(occasion,
                                      bs = "cs",
                                      k = 38)),
                           visit_data_balt,
                           site_data) # Spatial psi, temporal p
AIC(m_balt_t,
    m_balt_spsi, m_balt_spsi_tp)

# Spatio-temporal ####
m_balt_stpsi <- fit_occu(list(psi ~ t2(x, y,
                                       occasion,
                                       bs = c("ts", "cs"),
                                       d = c(2, 1)),
                              p ~ 1),
                         visit_data_balt,
                         site_data) # Spatiotemporal psi
m_balt_stpsi_tp <- fit_occu(list(psi ~ t2(x, y,
                                    occasion, 
                                    bs = c("ts", "cs"), 
                                    d = c(2, 1)),
                           p ~ s(occasion, 
                                 bs = "cs",
                                 k = 38)),
                      visit_data_balt,
                      site_data) # Spatiotemporal psi, temporal p
AIC(m_balt_stpsi_tp,
    m_balt_stpsi, m_balt_stpsi_tp)

# List length cov. ####
# Without smooth
m_list_n <- fit_occu(list(psi ~ t2(x, y,
                                   occasion,
                                   bs = c("ts", "cs"),
                                   d = c(2, 1)),
                          p ~ s(occasion,
                                bs = "cs",
                                k = 38) +
                            list_length),
                     visit_data_balt,
                     site_data)
# With smooth
m_list_x <- fit_occu(list(psi ~ t2(x, y,
                                   occasion, 
                                   bs = c("ts", "cs"), 
                                   d = c(2, 1)),
                          p ~ s(occasion, 
                                bs = "cs",
                                k = 38) + 
                            s(list_length,
                              bs = "ts")),
                     visit_data_balt,
                     site_data) # Spatiotemporal psi, temporal & list length p
AIC(m_balt_stpsi_tp,
    m_list_x, m_list_n)
# Keep best model for predictions (pred.R)
mb <- m_list_x
