import json

# १. ५ सर्व्हर्सची यादी (iLO IPs)
# आपण इथे 'Mocking' करतोय जेणेकरून तुला इंटरनेट/सर्व्हरची गरज पडणार नाही
server_list = [
    {"ip": "192.168.1.101", "name": "Server-01"},
    {"ip": "192.168.1.102", "name": "Server-02"},
    {"ip": "192.168.1.103", "name": "Server-03"},
    {"ip": "192.168.1.104", "name": "Server-04"},
    {"ip": "192.168.1.105", "name": "Server-05"}
]

healthy_servers = []

print("--- Infrastructure Discovery Started ---")

for server in server_list:
    print(f"Checking {server['name']} at {server['ip']}...")
    
    # २. इथे आपण 'बनावट' हेल्थ चेक करूया (Mocking)
    # समजा १०३ आणि १०५ मध्ये प्रॉब्लेम आहे
    if server['ip'] in ["192.168.1.103", "192.168.1.105"]:
        print(f"❌ {server['name']} is UNHEALTHY. Skipping...")
    else:
        print(f"✅ {server['name']} is OK.")
        healthy_servers.append(server['ip'])

# ३. अ‍ॅन्सिबलसाठी JSON फाईल बनवणे
inventory_data = {
    "all_healthy_nodes": healthy_servers
}

with open("ready_inventory.json", "w") as f:
    json.dump(inventory_data, f, indent=4)

print("\n--- Discovery Complete ---")
print(f"Found {len(healthy_servers)} healthy servers.")
print("Inventory saved to 'ready_inventory.json'")