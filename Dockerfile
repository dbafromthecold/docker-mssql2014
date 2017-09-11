# using windows server core image
FROM dbafromthecold/windowsservercore:v1

# create directory to hold iso
RUN powershell -Command (mkdir C:\SQL2014)

# copy media into container
COPY sql_server_2014_dev_sp1 C:\SQL2014

# install SQL Server
RUN C:\SQL2014\setup.exe /q /ACTION=Install /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER /SECURITYMODE=SQL /SAPWD=Testing11@@ /SQLSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /TCPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS

# remove installation media
RUN powershell -Command (rm C:\SQL2014 -recurse)

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

# start sqlserver
CMD ["net start MSSQLSERVER"]