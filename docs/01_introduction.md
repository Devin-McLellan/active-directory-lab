# 1.0 Introduction

This project implements a small local network using Windows Server 2019 and Windows 10 Education. The environment runs in Hyper-V, while Active Directory (AD) is used inside the network for authentication and management. The goal is to simulate the IT infrastructure of a small company.
The project includes:
-	**Two domain controllers (one GUI, one Core)**
-	**Two Windows 10 clients**
-	**A NAT switch configured using PowerShell and Hyper-V**
-	**DNS and Active Directory**
-	**Group Policy**
-	**File and authorization using NTFS permissions**

---

# 1.1 Hyper-V Setup
The environment is built using local Hyper-V virtual machines. These versions of Windows are installed:
- **Windows 10 Education**
- **Windows Server 2019 (GUI)**
- **Windows Server 2019 (Core)**

---

# 1.2 Active Directory
The core service of this project is Active Directory which is used to manage users, authentication, and access control within the network. 

---

## 1.3 Domain Configuration
A new domain is created to organize and secure user data and network resources.
## User Management
Ten users are added to the domain with different authentication levels and access permissions. This ensures that the user has correct permissions for software and administrative tools.

---

# 1.4 Preparations
Before starting the installation, I began a short literature review. I used the books
*Operativsystem – teori och praktiskt handhavande* and *Windows Server 2019 Inside Out* for information. I watched an introductory video on YouTube about Active Directory. I also read the lab manual several times and created a flowchart to visualize the workflow.

---

# 1.5 Flowchart
A flowchart is created in **[draw.io](https://www.drawio.com/)** to plan the full implementation process.

---

# 1.6 Software
- Windows Server 2019 Datacenter (Desktop Experience)
- Windows Server 2019 Core
- Two Windows 10 Education clients
- Hyper-V as the virtualization platform for all servers and clients

---

## 1.7 Network Topology
The network topology follows the course addressing table, where the IP structure and
domain names are based on the last two digits of my student ID (85). All servers and
clients use static IP addresses in the same subnet, and the NAT switch acts as the
gateway for both internal communication and internet access.
