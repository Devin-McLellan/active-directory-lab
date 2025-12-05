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

# 1.3 Domain Configuration
A new domain is created to organize and secure user data and network resources.

--- 

# 1.4 User Management
Ten users are added to the domain with different authentication levels and access permissions. This ensures that the user has correct permissions for software and administrative tools.

---

