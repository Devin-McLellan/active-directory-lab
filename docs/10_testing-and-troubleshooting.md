# 10. Troubleshooting and Lessons Learned

This section describes the main problems I encountered during the project and what I learned from solving them. Troubleshooting is an important part of working with Active Directory, because even small mistakes can cause major issues in the environment.

---

## 10.1 Initial Problems After Configuration

When I first tested the environment by logging in with different users on KLIENT01, I quickly noticed that many things were not working as expected.  
Some examples:

- Folder redirection did not work  
- Certain users could not access their department folders  
- Drive mappings were inconsistent  
- Home directories were not created correctly  

I spent many hours troubleshooting. I searched online, tested different configurations, and asked both teachers and classmates for help.  
Every time I fixed one issue, another problem appeared.

Eventually, I realized that the entire AD implementation had become unstable because of early mistakes in my structure and configuration.

---

## 10.2 Rebuilding the Active Directory Environment

After analysing the problems, I understood that the safest solution was to rebuild the AD environment instead of patching it.  
I created a new structure called: FöretagetV2

In this new version, I followed a clearer plan:

- A clean OU structure from the beginning  
- Correct NTFS permissions  
- Proper share configuration  
- Accurate security group membership  
- Updated GPO settings  
- Careful testing after each step  

This approach created a much more stable and reliable environment.

---

## 10.3 Results After Rebuilding

When everything was reconfigured, I tested the environment again.  
This time, all components worked as expected:

- Users automatically received the correct network drives  
- Home folders were created properly  
- Department folders were accessible only to the correct groups  
- Project Echo worked for its members  
- Folder redirection stored documents on the server  
- NTFS permissions applied correctly  

The new structure was more organized, professional, and easier to maintain.

---

## 10.4 Key Lessons Learned

During the project, I learned several important things:

- **Planning is essential.** A clear structure from the beginning prevents many issues later.  
- **Active Directory is sensitive to configuration order.** Doing steps in the wrong sequence can break things.  
- **DNS controls almost everything.** Incorrect DNS settings cause domain join failures and GPO issues.  
- **NTFS permissions and shares must match the design.** Even one incorrect inheritance setting can cause major problems.  
- **Checkpoints save time.** Being able to return to a stable point is extremely useful when experimenting.  
- **Small mistakes can break the whole environment.** Attention to detail is critical when working with AD.

---

## 10.5 Final Reflections

This project gave me practical experience in building a complete AD environment using:

- Windows Server 2019  
- Windows 10 Education  
- Hyper-V virtualization  
- DNS, GPOs, NTFS permissions, and domain structure  

I improved my skills in system administration, troubleshooting, and understanding how a secure and stable IT environment is built.

The final result is a working, well-structured domain environment that reflects how small companies organize their IT infrastructure in real life.

---
