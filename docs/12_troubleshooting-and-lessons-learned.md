This document describes issues encountered during the configuration of the Windows Server 2019 and Active Directory environment, as well as how they were resolved. The purpose of this file is to document the learning process and provide insight into common mistakes and their solutions in a domain environment.

---

## Roaming Profiles Not Working

### Problem  
After configuring roaming profiles and assigning the profile path in Active Directory, user profiles were not loaded correctly when logging in on different client machines. In some cases, a temporary profile was created instead.

### Investigation  
I verified that:
- The profile path was correctly set in the user properties
- The shared folder existed on the server
- The share name was correct and accessible from the client

Despite this, the issue persisted.

### Root Cause  
The problem was caused by incorrect NTFS permissions on the profile folder. The permissions did not fully follow the principle of least privilege, and the user was not able to correctly create or access their own profile folder.

### Solution  
NTFS permissions were corrected so that:
- The individual user has Full Control on their own profile folder
- Administrators have Full Control
- No other users can access the folder

After correcting the permissions and logging in again, the roaming profile was created and loaded correctly.

---

## Folder Redirection Not Applying

### Problem  
Folder redirection was configured through Group Policy, but user folders such as Documents were still stored locally on the client instead of being redirected to the server.

### Investigation  
To troubleshoot this issue, I:
- Ran `gpupdate /force` on the client
- Checked that the GPO was linked to the correct OU
- Verified that the user account was located in the correct OU

### Root Cause  
The GPO was linked at the wrong level in the OU structure, which caused it not to apply to the intended users.

### Solution  
The GPO was moved and linked to the correct OU containing the user accounts. After updating group policy and logging out/in, folder redirection worked as expected.

---

## DNS Issues Affecting Active Directory

### Problem  
Clients were able to reach the network but failed to join the domain or authenticate properly. Active Directory-related services behaved inconsistently.

### Investigation  
I checked:
- Client network settings
- DNS server configuration on the domain controller
- The DNS server address used by the clients

### Root Cause  
The clients were using an external DNS server instead of the internal DNS hosted on the domain controller. Since Active Directory relies heavily on DNS, this caused authentication and domain-related issues.

### Solution  
The clients were reconfigured to use the domain controller as their primary DNS server. After this change, domain join and authentication worked correctly.

---

## Group Policy Not Applying as Expected

### Problem  
Some Group Policy settings, such as drive mapping and security policies, were not applied to users or computers.

### Investigation  
I verified:
- GPO link location
- Security filtering
- That the correct users and computers were within the target OU

### Root Cause  
Security filtering was misconfigured, which prevented the GPO from being applied to the intended users.

### Solution  
The security filtering was corrected so that the appropriate groups had permission to apply the GPO. After running `gpupdate /force`, the policies applied correctly.

---

## Renaming Shared Folders Broke Mappings

### Problem  
After renaming a shared folder used for drive mapping, mapped network drives stopped working for users.

### Investigation  
I checked:
- Drive mapping configuration in Group Policy
- The UNC path used for the share
- The actual share name on the server

### Root Cause  
The share name in the GPO no longer matched the renamed folder on the server.

### Solution  
The drive mapping GPO was updated with the correct share name. After a policy update, the drives were mapped correctly again.

---

## Lessons Learned

- Active Directory is highly dependent on DNS, and incorrect DNS settings can break many services
- Correct NTFS permissions are critical for roaming profiles and folder redirection
- OU structure and GPO link placement are just as important as the policy settings themselves
- Small changes, such as renaming a shared folder, can have wide effects in a domain environment
- Documenting mistakes and fixes improves understanding and helps avoid repeating the same issues

---

