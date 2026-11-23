{
  security.audit.enable = true;
  security.auditd.enable = true;

  security.audit.rules = [
    "-a always,exit -F arch=b64 -S execve -S execveat -F auid>=1000 -F auid!=4294967295 -k app-usage"
  ];
}