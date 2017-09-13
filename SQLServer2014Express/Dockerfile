# using my windows server core image
FROM dbafromthecold/windowsservercore:v1

LABEL maintainer "Andrew Pruski"

WORKDIR /

RUN powershell -Command (Invoke-WebRequest -URI "http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAndTools%2064BIT/SQLEXPRWT_x64_ENU.exe" -OutFile setup.exe)

# install SQL Server
RUN C:\setup.exe /q /ACTION=Install /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER /SECURITYMODE=SQL /SAPWD=Testing1122 /SQLSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS

# remove installation media
RUN powershell -Command (rm C:\setup.exe)

# switch shell to powershell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY start.ps1 /

ENV SA_PASSWORD _
ENV ACCEPT_EULA _

# run start.ps1
CMD .\start -sa_password $env:SA_PASSWORD -ACCEPT_EULA $env:ACCEPT_EULA -Verbose
