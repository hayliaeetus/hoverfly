# Sphaerophoria scripta
source("Dataset_Sorting.R")

# Basic model ####
m0_scr <- fit_occu(list(psi ~ 1,
                        p ~ 1),
                   visit_data_script, 
                   site_data) # All null
# Temporal only ####
# Without smooth
m_scr_tpsi_n <- fit_occu(list(psi ~ occasion,
                              p ~ 1),
                         visit_data_script,
                         site_data)
m_scr_tp_n <- fit_occu(list(psi ~ 1,
                            p ~ occasion),
                       visit_data_script,
                       site_data)
m_scr_t_n <- fit_occu(list(psi ~ occasion,
                           p ~ occasion),
                      visit_data_script,
                      site_data)
# With smooth
m_scr_tpsi <- fit_occu(list(psi ~ s(occasion, bs = "cs"), 
                            p ~ 1), 
                       visit_data_script, 
                       site_data) # Just psi

m_scr_tp <- fit_occu(list(psi ~ 1, 
                          p ~ s(occasion, bs = "cs", k = 38)),
                     visit_data_script,
                     site_data) # Just p

m_scr_t <- fit_occu(list(psi ~ s(occasion, bs = "cs", k = 38),
                         p ~ s(occasion, bs = "cs", k = 38)), 
                    visit_data_script, 
                    site_data) # Both 
# Compare
AIC(m0_scr,
    m_scr_tpsi, m_scr_tpsi_n,
    m_scr_tp, m_scr_tp_n,
    m_scr_t, m_scr_t_n)
# AIC prefers smooths on both p and psi

# Spatial only ####
# Without smooth
m_scr_spsi_n <- fit_occu(list(psi ~ x * y,
                              p ~ 1),
                         visit_data_script,
                         site_data)
# With smooth
m_scr_spsi <- fit_occu(list(psi ~ t2(x, y,
                                     bs = "ts",
                                     d = 2),
                            p ~ 1), 
                       visit_data_script, 
                       site_data) # Just spatial psi
# Spatial smooth preferred
m_scr_spsi_tp <- fit_occu(list(psi ~ t2(x, y,
                                        bs = "ts",
                                        d = 2),
                               p ~ s(occasion,
                                     bs = "cs",
                                     k = 38)),
                          visit_data_script,
                          site_data) # Spatial psi, temporal p
AIC(m_scr_t,
    m_scr_spsi, m_scr_spsi_n,
    m_scr_spsi_tp)
# Spatio-temporal ####
m_scr_stpsi <- fit_occu(list(psi ~ t2(x, y,
                                      occasion,
                                      bs = c("ts", "cs"),
                                      d = c(2, 1)),
                             p ~ 1),
                        visit_data_script,
                        site_data) # Spatiotemporal psi
m_scr_stpsi_tp <- fit_occu(list(psi ~ t2(x, y,
                                         occasion, 
                                         bs = c("ts", "cs"), 
                                         d = c(2, 1)),
                                p ~ s(occasion, 
                                      bs = "cs",
                                      k = 38)),
                           visit_data_script,
                           site_data) # Spatiotemporal psi, temporal p
AIC(m_scr_spsi_tp, 
    m_scr_stpsi, m_scr_stpsi_tp)
# List length ####
ms_list_x <- fit_occu(list(psi ~ t2(x, y,
                                    occasion, 
                                    bs = c("ts", "cs"), 
                                    d = c(2, 1)),
                           p ~ s(occasion, 
                                 bs = "cs",
                                 k = 38) + 
                             s(list_length,
                               bs = "ts")),
                      visit_data_script,
                      site_data) # Spatiotemporal psi, temporal & list length p
ms_list_n <- fit_occu(list(psi ~ t2(x, y,
                               occasion, 
                               bs = c("ts", "cs"),
                               d = c(1, 2)),
                           p ~ s(occasion,
                                 bs = "cs",
                                 k = 38) +
                             list_length),
                      visit_data_script,
                      site_data)
AIC(m_scr_stpsi_tp,
    ms_list_x, ms_list_n)
# Use best model for predictions:
ms <- ms_list_x