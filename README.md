# system-hunter
System-Hunter will be a systemd service that analyzes suspicious and malicious
systemd services and configurations on linux systems. ATT&CK T1501 is the technique
of creating or modifying system processes, specifically the systemd service.
Adversaries modify or create these services to establish persistence and escalate
privileges. Many adversaries set malicious binaries to execute on reboot, this tool aims
to mitigate this. It will scan the systemd directories to include the user level paths and
identify any suspicious or malicious services running by referencing a hash whitelist,
checking modification dates, and validating services associated with their specific
distributions. The scan finding will be recorded as a .csv file which will allow for
integration into other analysis platforms.
