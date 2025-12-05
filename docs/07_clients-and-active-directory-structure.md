# 7. Clients and Active Directory Structure

This section describes how I joined the Windows 10 clients to the domain and how I created the initial structure in Active Directory. This includes organizational units (OUs), groups, user templates, and the basic folder structure used later for permissions and Group Policy.

---

## 7.1 Joining the Windows Clients to the Domain

I started by logging in locally on both Windows 10 Education clients. To join them to the domain **Grupp85.lab**, I navigated to:

**Settings → System → About → Rename this PC (advanced settings)**

When I tried to join the domain for the first time, **KLIENT01** showed an error saying that it could not find the domain.  
After troubleshooting, I discovered that the DNS settings were incorrect. The client was not pointing to **DC01**, which is required for domain discovery.

I changed the DNS server address to the IP of DC01, and after that the domain join worked normally.

Both clients were restarted and successfully authenticated against the domain.

---

## 7.2 Installing RSAT on KLIENTADMIN

To manage the servers remotely, I installed **Remote Server Administration Tools (RSAT)** on the KLIENTADMIN machine.  
After downloading and installing RSAT from Microsoft’s website, I restarted the machine.

To verify the installation, I checked that all RSAT components were available in the Windows Administrative Tools folder.  
When everything was confirmed to be in place, I could manage Active Directory and the server configuration directly from KLIENTADMIN.

---

## 7.3 Creating the Initial Active Directory Structure

To better understand how Active Directory should be organized, I watched instructional videos online.  
Afterwards, I opened **Active Directory Users and Computers (ADUC)** and created my first Organizational Unit (OU).

I selected:

**New → Organizational Unit**

and named the OU: Företaget

This OU becomes the main container for users, groups, project folders, and user templates.

---

## 7.4 Creating Required Groups and Folder Structure

After the main OU was created, I continued by creating the user groups required by the lab instructions.  
At the same time, I verified that the virtual hard drive on DC01 was partitioned correctly.

On the secondary partition, I created the following folders:

- **Hem** – used for user home directories  
- **Grupper** – contains folders for each department  
- **Projekt** – used for project storage (including the subfolder **Echo**)  

These folders are later shared and controlled through NTFS permissions and Group Policy.

---

## 7.5 Creating User Templates (Mallar)

To make the creation of users more efficient, I created a dedicated OU called **Mallar** for user templates.

Inside this OU, I selected:

**New → User**

and created the template: AnstalldMall

The password was set to **Pa55w0rd**, and I activated the setting **Password never expires**.

Inside the **Profile** tab, I configured the home directory: Connect to: H:
Path: \DC01\Hem$%USERNAME%
The variable **%USERNAME%** ensures that Windows automatically creates the correct home folder for each user.

When the main template was finished, I used the **Copy** function to create the other templates:

- ChefMall  
- SaljarMall  
- EkonomiMall  

I then added each template to the correct security groups such as *Anställda*, *Ledning*, *Försäljning*, and *Ekonomi*.

---

## 7.6 Testing the User Template System

To verify the setup, I created a test user with the classic name:Test Testsson
The home folder, group membership, and permissions worked correctly.  
After this successful test, I created all ten required users using the templates.

Once I confirmed that each user had the correct home directory and group membership, I continued with the next stage of the project.

---

