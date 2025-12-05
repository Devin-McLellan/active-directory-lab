# 11. Conclusions and Reflection

This project has given me practical experience in building and managing a complete Active Directory environment using Windows Server 2019, Windows 10 Education, and Hyper-V.  
Working through each step helped me understand how the different components in a domain depend on each other, and how important it is to configure them in the correct order.

---

## 11.1 Final Outcome

In the end, I created a fully functional environment that includes:

- Two domain controllers  
- Two Windows 10 clients  
- A NAT switch for internal and external communication  
- A structured AD with OUs, users, templates, and groups  
- Server-hosted home folders and department folders  
- Automatic drive mapping based on group membership  
- Folder redirection  
- Correct NTFS permissions and share permissions  
- Project folder access for specific teams  

All parts of the system work together as intended, and each user receives the correct resources when logging in.

---

## 11.2 What I Learned

Throughout the project I learned several important lessons:

**Planning matters.**  
A clear structure from the start saves a lot of time later. When I rushed some steps, I had to redo large parts of the project.

**DNS is critical.**  
Almost every AD problem is related to DNS. A single wrong DNS entry can cause domain join failures, GPO issues, or missing folder redirection.

**NTFS permissions must be exact.**  
Even small mistakes, such as inheritance settings, can break access for whole groups of users.

**Troubleshooting is part of the process.**  
Many issues only became clear when trying to log in as different users. Testing often revealed configuration mistakes that were not obvious earlier.

**Checkpoints are valuable.**  
Being able to restore the system when something goes wrong made the project easier to handle and prevented unnecessary reinstallation.

---

## 11.3 Personal Reflection

Working on this project increased my confidence with Windows Server, Active Directory, DNS, and Group Policy.  
Before starting, these topics felt complex, but building everything step by step helped me understand how they work in a real network environment.

I also learned how easy it is to break something by changing one small setting. At one point, renaming the **Hem$** share caused several functions to stop working.  
Mistakes like this taught me to slow down and think before making changes.

The rebuilding of *FöretagetV2* was an important moment. It showed me that sometimes the best solution is to start fresh instead of trying to repair a broken structure. In the end, this made the environment much cleaner and more stable.

---

## 11.4 Final Thoughts

This project gave me useful experience that I can apply in real IT environments. I now have a stronger understanding of:

- Network administration  
- System configuration  
- AD management  
- Troubleshooting and problem-solving  
- Structuring an IT environment for a small company  

The result is a working, organized, and secure domain setup that reflects professional standards.  
The skills I developed here will help me in future courses and in real-world system administration work.

---
