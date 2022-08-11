# Eristalis tenax
source("Dataset_Sorting.R")

# Basic model ####
m0_tenax <- fit_occu(list(psi ~ 1, p ~ 1), 
                     visit_data_tenax, 
                     site_data) # Null model
# Temporal only ####
# Without smooth
m_tenax_tpsi_n <- fit_occu(list(psi ~ occasion,
                                p ~ 1),
                           visit_data_tenax,
                           site_data)
m_tenax_tp_n <- fit_occu(list(psi ~ 1,
                              p ~ occasion),
                         visit_data_tenax,
                         site_data)
m_tenax_t_n <- fit_occu(list(psi ~ occasion,
                             p ~ occasion),
                        visit_data_tenax,
                        site_data)
# With smooth
m_tenax_tpsi <- fit_occu(list(psi ~ s(occasion, bs = "cs", k = 38), 
                             p ~ 1), 
                        visit_data_tenax, 
                        site_data) # Just psi
m_tenax_tp <- fit_occu(list(psi ~ 1, 
                           p ~ s(occasion, bs = "cs", k = 38)),
                      visit_data_tenax,
                      site_data) # Just p

m_tenax_t <- fit_occu(list(psi ~ s(occasion, bs = "cs", k = 38),
                          p ~ s(occasion, bs = "cs", k = 38)), 
                     visit_data_tenax, 
                     site_data) # Both
AIC(m0_tenax, 
    m_tenax_tp, m_tenax_tp_n,
    m_tenax_tpsi, m_tenax_tpsi_n,
    m_tenax_t, m_tenax_t_n)
# AIC prefers smooth on both p and psi

# Spatial only ####
# Without smooth
m_tenax_spsi_n <- fit_occu(list(psi ~ x * y,
                                p ~ 1),
                           visit_data_tenax,
                           site_data)
# With smooth
m_tenax_spsi <- fit_occu(list(psi ~ t2(x, y,
                                      bs = "ts",
                                      d = 2),
                             p ~ 1), 
                        visit_data_tenax, 
                        site_data) # Spatial psi
# Compare
AIC(m_tenax_spsi_n, m_tenax_spsi)
# AIC prefers smooth on spatial component
m_tenax_spsi_tp <- fit_occu(list(psi ~ t2(x, y,
                                         bs = "ts",
                                         d = 2),
                                p ~ s(occasion,
                                      bs = "cs",
                                      k = 38)),
                           visit_data_tenax,
                           site_data) # Spatial psi, temporal p
AIC(m_tenax_t,
    m_tenax_spsi, m_tenax_spsi_tp)

# Spatio-temporal ####
m_tenax_stpsi <- fit_occu(list(psi ~ t2(x, y,
                                       occasion,
                                       bs = c("ts", "cs"),
                                       d = c(2, 1)),
                              p ~ 1),
                         visit_data_tenax,
                         site_data) # Spatiotemporal psi
m_tenax_stpsi_tp <- fit_occu(list(psi ~ t2(x, y,
                                          occasion, 
                                          bs = c("ts", "cs"), 
                                          d = c(2, 1)),
                                 p ~ s(occasion, 
                                       bs = "cs",
                                       k = 38)),
                            visit_data_tenax,
                            site_data) # Spatiotemporal psi, temporal p
AIC(m_tenax_spsi_tp,
    m_tenax_stpsi, m_tenax_stpsi_tp)

# List length cov. ####
mc_list_x <- fit_occu(list(psi ~ t2(x, y,
                                   occasion, 
                                   bs = c("ts", "cs"), 
                                   d = c(2, 1)),
                          p ~ s(occasion, 
                                bs = "cs",
                                k = 38) + 
                            s(list_length,
                              bs = "ts")),
                     visit_data_tenax,
                     site_data) # Spatiotemporal psi, temporal & list length p
mc_list_x_n <- fit_occu(list(psi ~ t2(x, y,
                                      occasion,
                                      bs = c("ts", "cs"),
                                      d = c(2, 1)),
                             p ~ s(occasion,
                                   bs = "cs",
                                   k = 38) + 
                               list_length),
                        visit_data_tenax,
                        site_data)
AIC(m_tenax_stpsi_tp, mc_list_x, mc_list_x_n)

# Use best model for predictions
mt <- mc_list_x
