# active-directory-lab

This project shows how I set up and configured an Active Directory (AD) domain for a small company with ten users.  
My goal was to create a working environment with user accounts, shared folders, and basic Group Policy settings.

---

## Overview

The environment is built in Hyper-V.  
I use two Windows Server 2019 machines (one GUI and one Core) and two Windows 10 Education clients.  
All of them run on a NAT-switch so they can communicate with each other and reach the internet.

During the project I install the servers, configure the network, set up Active Directory, create the OU structure, add users and groups, and test everything to make sure it works.

---

## Project Workflow

```mermaid
flowchart TD
    A[Start] --> B[Install Windows Server and Clients]
    B --> C[Configure Network]
    C --> D[Set up AD DS]
    D --> E[Create OU Structure]
    E --> F[Add Users and Groups]
    F --> G[Configure Shares and NTFS Permissions]
    G --> H[Apply Group Policies]
    H --> I[Test the Environment]
    I --> J[Finish]
