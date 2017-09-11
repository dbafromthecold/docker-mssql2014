# using windows server core image
FROM dbafromthecold/windowsservercore:v1

# create directory to hold iso
RUN powershell -Command (mkdir C:\SQL2014)

# copy media into container
COPY sql_server_2014_dev_sp1 C:\SQL2014

# copy start.ps1 into container
COPY start.ps1 /
WORKDIR /

# install SQL Server
RUN C:\SQL2014\setup.exe /q /ACTION=Install /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER /SECURITYMODE=SQL /SAPWD=Testing11@@ /SQLSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS

# remove installation media
RUN powershell -Command (rm C:\SQL2014 -recurse)

# stop sqlserver
CMD ["net stop MSSQLSERVER"]

# perform healthcheck
HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

# run start.ps1
RUN powershell -Command (.\start -sa_password Testing1122 -ACCEPT_EULA Y -Verbose)
