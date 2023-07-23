provider "google" {                                                                                                                                                    
  project     = var.project                                                                                                                                  
  credentials = file("compute-instance.json")                                                                                                                          
  region      = var.region               
  zone       = var.zone              
}
