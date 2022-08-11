# Model Code
# E. balteatus
mb <- fit_occu(list(psi ~ t2(x, y,
                             occasion, 
                             bs = c("ts", "cs"), 
                             d = c(2, 1)),
                    p ~ s(occasion, 
                          bs = "cs",
                          k = 38) + 
                      s(list_length,
                        bs = "ts")),
               visit_data_balt,
               site_data)

# E. tenax
mt <- fit_occu(list(psi ~ t2(x, y,
                             occasion, 
                             bs = c("ts", "cs"), 
                             d = c(2, 1)),
                    p ~ s(occasion, 
                          bs = "cs",
                          k = 38) + 
                      s(list_length,
                        bs = "ts")),
               visit_data_tenax,
               site_data)

# S. scripta
ms <- fit_occu(list(psi ~ t2(x, y,
                             occasion, 
                             bs = c("ts", "cs"), 
                             d = c(2, 1)),
                    p ~ s(occasion, 
                          bs = "cs",
                          k = 38) + 
                      s(list_length,
                        bs = "ts")),
               visit_data_script,
               site_data)