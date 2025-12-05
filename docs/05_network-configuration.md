# 5. Network Configuration

This section describes how I configured the IP settings on all virtual machines in the Hyper-V environment. Correct network configuration is essential for Active Directory, DNS, and communication between clients and servers.

---

## 5.1 Assigning Static IP Addresses

After the operating systems were installed, I configured static IP addresses on each machine.  
The network follows the subnet **192.168.85.0/24**, and the NAT switch acts as the default gateway for the entire environment.

Below is the IP configuration used for the project:

**Table 3 — IP Configuration of All Virtual Machines**

| Machine         | IP Address       | Subnet Mask       | Gateway        | DNS Server         |
|-----------------|------------------|-------------------|----------------|---------------------|
| **DC01**        | 192.168.85.11    | 255.255.255.0      | 192.168.85.1   | 172.30.255.254      |
| **DC02**        | 192.168.85.12    | 255.255.255.0      | 192.168.85.1   | 192.168.85.11       |
| **KLIENTADMIN** | 192.168.85.64    | 255.255.255.0      | 192.168.85.1   | 192.168.85.11       |
| **KLIENT01**    | 192.168.85.128   | 255.255.255.0      | 192.168.85.1   | 192.168.85.11       |

DC01 uses the external DNS forwarder provided by the course (172.30.255.254), while all other machines point to DC01 for internal name resolution.

---

## 5.2 Verifying Network Communication

Once all IP addresses were set, I verified the internal connectivity using the `ping` command.  
Each machine could successfully reach:

- The NAT switch (192.168.85.1)  
- Both domain controllers  
- Other clients in the environment  

This confirmed that the virtual machines were correctly connected to the same virtual network.

---

## 5.3 Preparing for Domain Services

With working IP addresses, DNS resolution, and proper routing, the environment was ready for the installation and configuration of:

- DNS services  
- Active Directory  
- Domain joining for Windows clients  

These components rely heavily on correct network configuration, which is why this step is crucial before moving forward.

---
