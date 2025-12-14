# Configuration Overview – Visual Documentation

The images below show different parts of the configuration and setup of the environment. They are used to document the work and to verify that each step has been implemented correctly.

## Active Directory Structure
<img width="821" height="610" alt="ROAMING_PROFILES" src="https://github.com/user-attachments/assets/1f9fb3a3-aa57-4bf5-9e03-acfde5f7e645" />![ACTIVE_DIRECTORY_STRUCTURE](https://github.com/user-attachments/assets/35c37a48-378b-4a14-bdb8-e31b9eb51ea0)

## Drive Maps
### Shows the general structure of Active Directory, including OUs, users, and groups that are used throughout the configuration.
![DRIVE_MAPS](https://github.com/user-attachments/assets/8ba1e601-7d1f-456a-9b31-98697f1d8206)
### Shows the configured drive mappings that are applied to users through Group Policy.

## Flowchart
<img width="1501" height="871" alt="FLOWCHART" src="https://github.com/user-attachments/assets/000d2fa5-70aa-42e0-86f0-63f1185a511f" />
### Shows the overall flow of the project and how different configuration steps are connected.

## Group Policies
![GROUP_POLCY](https://github.com/user-attachments/assets/16318e34-6532-455f-93a2-7b07b8a8d83a)
### Shows the Group Policy Objects that are created and applied to users and computers, such as security and login settings.

## Hard Drive Partitioning
![HARDDRIVE_PARTION](https://github.com/user-attachments/assets/275882e1-a06e-4ec0-b665-4c708a372abe)
### Shows how the server hard drive is partitioned and formatted before being used for data and profiles.

## Hyper-V Settings
![HYPER_V_SETTINGS](https://github.com/user-attachments/assets/2de9dcdb-10cf-4761-990c-2b230b62345b)
### Shows the virtual machine settings in Hyper-V, including network and system configuration.

## Login Policy (Ctrl + Alt + Del)
![LOGIN_POLICY_CTRL_ALT_DEL](https://github.com/user-attachments/assets/cb240058-316d-4e24-bcc5-5447de6bad80)
### Shows the login policy that requires users to press Ctrl + Alt + Del when signing in.

## NAT Switch (PowerShell)
<img width="960" height="989" alt="NAT_SWITCH_POWERSHELL" src="https://github.com/user-attachments/assets/a7fc483d-7c05-47a2-adb4-5b8c8a7f3f54" />
### Shows the creation of a NAT switch in Hyper-V using PowerShell to provide network access for the virtual machines.

## Password Settings
![PASSWORD_SETTINGS](https://github.com/user-attachments/assets/4c4c7362-7ffe-4287-a2ce-7b76d96b0cba)
### Shows the configured password policy, including complexity and length requirements.

## Roaming Profiles
<img width="821" height="610" alt="ROAMING_PROFILES" src="https://github.com/user-attachments/assets/130c2dfc-6f70-4547-8850-a3f3367c299a" />
### Shows the roaming profile setup that allows user data and settings to follow the user between different computers.

## NTFS Security Settings
![SECURITY_SETTING_NTFS](https://github.com/user-attachments/assets/eecb7ed4-d6de-4830-a16e-0b78f66fc86e)
### Shows the NTFS permissions used to control access to folders and shared resources.

## Test User
![TEST_USER](https://github.com/user-attachments/assets/b14afe86-c28c-4c14-b11c-5bc6ff4f2130)
### Shows a test user that is used to verify that policies, permissions, drive maps, and roaming profiles work as expected.
