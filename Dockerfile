# using my windows server core image
FROM dbafromthecold/windowsservercore:v1

# create directory to hold iso
RUN powershell -Command (mkdir C:\SQL2014)

# copy media into container
COPY sql_server_2014_dev_sp2 C:\SQL2014

# install SQL Server
RUN C:\SQL2014\setup.exe /q /ACTION=Install /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER /SECURITYMODE=SQL /SAPWD=Testing1122 /SQLSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS

# remove installation media
RUN powershell -Command (rm C:\SQL2014 -recurse)

# make sure service is set to automatic
RUN powershell -Command (set-service MSSQLSERVER -StartupType Automatic)

# switch shell to powershell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY start.ps1 /
WORKDIR /

ENV SA_PASSWORD _
ENV ACCEPT_EULA _

# run start.ps1
CMD .\start -sa_password $env:SA_PASSWORD -ACCEPT_EULA $env:ACCEPT_EULA -Verbose
