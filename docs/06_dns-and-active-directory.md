# 6. DNS and Active Directory

This section describes how I installed and configured DNS and Active Directory on my domain controllers. These services form the core of the network environment, so it was important to complete each step carefully and verify the configuration before continuing.

---

## 6.1 Installing DNS and Active Directory on DC01

I started by installing **DNS** and **Active Directory Domain Services (AD DS)** on **DC01** using the Server Manager roles and features wizard.  
After the installation was complete, I restarted the server and promoted DC01 to a domain controller.

During the promotion process, I created the domain: GRUPP85-LAB

I also set the Directory Services Restore Mode (DSRM) password: Pa55w0rd

When the configuration finished, DC01 was fully operational as the primary domain controller.

---

## 6.2 Joining DC02 to the Domain

The next step was to join **DC02** to the new domain.  
Since DC02 runs Windows Server Core, I used the built-in tool **sconfig**.

Inside sconfig, I selected: Option 1 — Domain/Workgroup 

Then I entered the domain name *Grupp85.lab* and supplied administrator credentials from DC01.  
After joining the domain, I restarted DC02. Once the system came back online, it communicated correctly with DC01.

---

## 6.3 Creating System Checkpoints

After both domain controllers were properly connected and stable, I created **checkpoints** for all virtual machines in Hyper-V.

The reason for this is simple:  
The upcoming steps involve creating users, groups, folders, and GPO configurations. A small mistake in this phase can break the entire structure. With checkpoints, I can easily revert the environment if something goes wrong.

---

## 6.4 Preparing for Client Deployment

With the domain running on DC01 and DC02, the environment was now ready for:

- Joining Windows 10 clients  
- Installing RSAT tools  
- Creating OUs, users, templates, and groups  
- Configuring shares and NTFS permissions  
- Applying Group Policy settings  

A correct and stable DNS and AD installation is essential for all later steps.

---
