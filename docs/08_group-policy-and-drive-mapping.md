# 8. Group Policy and Drive Mapping

This section describes how I worked with Group Policy in my domain environment, including password policies, folder redirection, and automatic drive mapping based on security groups. Group Policies are an important part of the project because they make it possible to manage users and resources in a centralized and structured way.

---

## 8.1 Editing the Default Domain Policy

I opened **Group Policy Management** on DC01 and edited the **Default Domain Policy**.  
This policy controls several global security settings in the domain.

I configured the password policy by navigating to:

**Computer Configuration → Windows Settings → Security Settings → Account Policies → Password Policy**

Based on the lab instructions, I set:

- Minimum password length: **4 characters**  
- No requirement for password complexity  

I also enabled the requirement for users to press **CTRL + ALT + DEL** when signing in.

To make sure the changes were applied immediately, I ran:  gpupdate /force

---

## 8.2 Folder Redirection for Documents

Next, I created a separate GPO for folder redirection of the **Documents** folder.  
The goal of this configuration is to store user documents on the server instead of the local machine.

Under:

**User Configuration → Policies → Windows Settings → Folder Redirection → Documents**

I set the path to: \DC01\Hem$%USERNAME%\Documents

This ensures that every user has their *Documents* folder stored inside their home directory on the server.

I ran `gpupdate /force` again to apply the settings.

To verify the configuration, I restarted **KLIENT01** and logged in with a domain user.  
At first, I received an error message during login.  
The issue was caused by Hyper-V Enhanced Session Mode. After disabling this mode, the user could log in normally, and folder redirection worked as expected.

---

## 8.3 Preparing Department Folders for Drive Mapping

To enable automatic drive mapping later, I created a new folder on DC01 called **Shares**.  
Inside this directory, I created four subfolders that represent the company's departments:

- Anställda  
- Ekonomi  
- Försäljning  
- Ledning  

These folders are used together with Group Policy Preferences to map drives based on group membership.

---

## 8.4 Creating the Drive Mapping GPO

In **Group Policy Management**, I created a new GPO dedicated to drive mapping.

Inside the GPO, I navigated to:

**User Configuration → Preferences → Windows Settings → Drive Maps**

Here I added the following network drives:

| Drive Letter | Purpose                     |
|--------------|------------------------------|
| **A:**       | Anställda                    |
| **X:**       | Ekonomi                      |
| **Y:**       | Försäljning                  |
| **Z:**       | Ledning                      |
| **P:**       | Project folder (Echo)        |

Each drive mapping uses **Item-Level Targeting** to limit access based on **Security Group** membership.

For example:

- Drive **X:** is only mapped for users in the *Ekonomi* group.  
- Drive **Y:** is only mapped for users in the *Försäljning* group.  
- Drive **Z:** is only mapped for the *Ledning* group.  
- Drive **P:** is mapped for the project members.

This makes sure that every user receives exactly the drives and folders that belong to their role in the company.

Additionally, members of the management group (*Ledning*) were given access to all department folders.

---

## 8.5 Result and Verification

After applying the policy, I logged in with several test users.  
Each user received the correct network drives automatically, depending on:

- Their department  
- Their project participation  
- Their security group membership  

This confirmed that the drive-mapping system was functioning correctly and that Group Policy was applied as intended.

---
