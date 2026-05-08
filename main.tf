# १. HPE iLO प्रोव्हायडर (ProLiant सर्व्हर कंट्रोल करण्यासाठी)
provider "ilo" {
  # इथे आपण लूप वापरून ३ सर्व्हर्सना हाताळू शकतो
  # सध्या फक्त समजण्यासाठी एका सर्व्हरचा डेटा:
  host     = "192.168.1.101" 
  username = "admin"
  password = "password123"
}

# २. BIOS सेटिंग्ज ऑटोमेट करणे (High Performance साठी)
resource "ilo_bios_settings" "proliant_config" {
  settings = {
    "WorkloadProfile" = "GeneralThroughputCompute"
    "PowerRegulator"  = "StaticHighPerf"
  }
}

# ३. बूट ऑर्डर सेट करणे (PXE Boot)
resource "ilo_boot_settings" "proliant_boot" {
  boot_order = ["Pxe", "Hdd"]
}