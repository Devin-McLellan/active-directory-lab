# 9. Project Echo and Department Structure

This section explains how I created the Project Echo environment in Active Directory and structured the organizational units (OUs) for the different departments in the company. These steps make the AD environment more organized, easier to manage, and better aligned with how a real company works.

---

## 9.1 Creating Project Echo

After reviewing the earlier steps with my teacher and confirming that everything worked correctly, I continued with setting up **Project Echo**.

I opened **Active Directory Users and Computers (ADUC)** and created a new Organizational Unit called: Project

Inside this OU, I created a security group for the project members.  
In the **Properties → Members** tab, I added the users who should be part of the project.

I also updated the permissions for the **Echo** project folder so that only the assigned group members could access it.  
This ensures that project files are protected and only available to the correct users.

---

## 9.2 Creating Department OUs

To organize the company's structure more clearly, I opened ADUC and navigated to the domain level.  
There, I created separate OUs for each department by selecting:

**New → Organizational Unit**

I created the following department OUs:

- **Ekonomi**  
- **Försäljning**  
- **Ledning**  
- **Anställda**  

After creating these OUs, I moved each user into their correct department.  
This results in a cleaner and more logical structure, where users are grouped according to their role in the organization.

Having a well-organized OU structure also makes it easier to apply Group Policies and manage permissions later in the project.

---

## 9.3 Results of the Department Structure

With the new OUs in place:

- Users are no longer mixed together in one location  
- Drive mappings apply correctly based on department membership  
- Permissions are easier to manage and troubleshoot  
- The AD environment becomes more realistic and professional  

These changes improved both usability and security, since each department is now isolated and managed independently.

---
