# 4. Virtualization and Installation

This part of the project describes how I created the virtual environment in Hyper-V, installed the operating systems, and prepared the basic network configuration that the rest of the Active Directory setup depends on.

---

## 4.1 Creating the NAT Switch

To create the NAT switch in Hyper-V, I used PowerShell in administrator mode. I followed a guide to configure a NAT network for the subnet **192.168.85.0/24**.  
I assigned the gateway IP address **192.168.85.1/24** and verified the settings using the commands:

- `Get-VMSwitch`
- `Get-NetNat`

These commands confirmed that the switch was created correctly and linked to my Hyper-V environment.

---

## 4.2 Installing the Operating Systems

Hyper-V was already enabled in Windows, so I created the following virtual machines:

| Device        | Operating System                           | RAM        | CPU |
|---------------|---------------------------------------------|------------|-----|
| **DC01**      | Windows Server 2019 Desktop Experience      | 4 GB RAM   | 2 vCPU |
| **DC02**      | Windows Server 2019 Core                    | 2 GB RAM   | 2 vCPU |
| **KLIENTADMIN** | Windows 10 Education                      | 4 GB RAM   | 2 vCPU |
| **KLIENT01**  | Windows 10 Education                        | 4 GB RAM   | 2 vCPU |
| **NAT Switch** | –                                          | –          | – |

|

---

I installed Windows Server 2019 on DC01 and DC02, and Windows 10 Education on both clients. After installation, I updated all machines using Windows Update.  
Windows Firewall and antivirus software were activated on every system.

---

## 4.3 Network Configuration

When the installation was complete, I configured static IP addresses on each machine according to the table below:

| Machine        | IP Address       | Subnet Mask       | Gateway         | DNS Server          |
|----------------|------------------|-------------------|------------------|----------------------|
| **DC01**       | 192.168.85.11    | 255.255.255.0     | 192.168.85.1     | 172.30.255.254       |
| **DC02**       | 192.168.85.12    | 255.255.255.0     | 192.168.85.1     | 192.168.85.11        |
| **KLIENTADMIN**| 192.168.85.64    | 255.255.255.0     | 192.168.85.1     | 192.168.85.11        |
| **KLIENT01**   | 192.168.85.128   | 255.255.255.0     | 192.168.85.1     | 192.168.85.11        |

The NAT switch works as the default gateway for all virtual machines.

---

## 4.4 Partitioning the Server Disk

On DC01, I used **Disk Management** to partition the virtual hard drive.  
I created two new partitions, each around **60 GB**, in addition to the default Recovery and EFI partitions.

- The first partition is used for the operating system.
- The second partition is reserved for home folders, group folders, and the project folder, as required by the lab instructions.

---

## 4.5 Adjusting IPv6 Priority

To avoid issues with Windows functions that rely on IPv6, I did not disable IPv6 completely.  
Instead, I lowered the IPv6 priority so that the system prefers IPv4.

I used PowerShell to set the interface priority to **32** (instead of **255**, which disables IPv6 entirely).  
After running the command, I restarted each machine and verified the change using:


The value **32** confirmed that the system now prioritizes IPv4.

---

## 4.6 Installing DNS and Active Directory

I installed DNS and Active Directory Domain Services on **DC01** and restarted the server.  
After the reboot, I promoted DC01 to a domain controller and created the domain **Grupp85.lab**.  
The Directory Services Restore Mode (DSRM) password was set to **Pa55w0rd**.

Once DC01 was configured, I continued with **DC02**.  
Using `sconfig`, I joined DC02 to the domain (option 1 – Domain/Workgroup).

After both servers were joined and functioning correctly, I created checkpoints for all virtual machines.  
This makes it easy to revert in case any configuration errors occur in the next steps.

---

## 4.7 Preparing the Windows 10 Clients

I logged in locally on the Windows 10 clients and joined them to the domain **Grupp85.lab** by navigating to:

**Settings → System → About → Rename this PC (advanced settings)**

At first, KLIENT01 could not find the domain. After troubleshooting, I discovered that it had an incorrect DNS configuration.  
When I changed the DNS server to point to **DC01**, the domain join worked correctly.

After both clients were joined, I installed **RSAT (Remote Server Administration Tools)** on KLIENTADMIN.  
After a restart, I verified that all RSAT components were available and that I could manage the server remotely.

---
