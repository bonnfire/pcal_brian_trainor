## create master table for pcal

pcal_samples <- openxlsx::read.xlsx("~/Dropbox (Palmer Lab)/Palmer Lab/Bonnie Lin/github/pcal_brian_trainor/CREATE/Sample list for DNA samples.xlsx", colNames = F) %>% 
  rename("rfid" = "X1", 
         "sex" = "X3") %>% 
  mutate(rfid = paste0("p.cal", str_pad(rfid, 2, "left", "0")), 
         sex = toupper(sex)) %>% 
  select(rfid, sex)

pcal_dna <- openxlsx::read.xlsx("~/Dropbox (Palmer Lab)/Palmer Lab/Bonnie Lin/github/pcal_brian_trainor/CREATE/DNA Extraction Data_PL 2020-01-16.xlsx") %>% 
  clean_names %>%
  rename("rfid" = "sample_number") %>% 
  mutate(rfid = paste0("p.cal", str_pad(rfid, 2, "left", "0"))) %>% 
  select(rfid, source)

pcal_master <- pcal_samples %>% 
  left_join(pcal_dna, by = "rfid")

write.csv(pcal_master, "~/Desktop/Database/csv files/pcal_brian_trainor/pcal_master_n96.csv", row.names = F)
