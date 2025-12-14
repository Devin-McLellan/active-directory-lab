# Troubleshooting-and-lessons

---

This document describes issues that I have encountered during the configuration of the Windows Server 2019 and Active Directory environment, also I will explain how the problems were resolved. The purpose of this file is to document the learning process and provide information of common mistakes and I were able to solve them during the project.

---

One of the main challenges during the implementation of Active Directory was understanding how different components depend on each other. Many settings in AD are not isolated, and a small misconfiguration can affect users, logins, or policies across the domain.

Another challenge was understanding how Group Policy inheritance works. Some policies were not applied because they were blocked or overridden by other GPOs. By using Group Policy Management tools, such as Group Policy Results and Group Policy Modeling, I was able to verify which policies were applied and correct the linking order.

Implementing user accounts and permissions was also challenging. Incorrect group membership or NTFS permissions caused users to either have too much access or no access at all. This was solved by following the principle of least privilege and testing with a dedicated test user.

Overall, these issues helped me better understand how Active Directory, Group Policy, and security settings interact in a real environment, and how important testing and verification are during deployment.

---
