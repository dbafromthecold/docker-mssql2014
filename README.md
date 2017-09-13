### docker-mssql2014
Dockerfile to create SQL Server 2014 container images

Dockerfile will create a container running SQL Server 2014 Developer/Express Edition.

Pre-requisities (for developer edition): <br>
SQL Server 2014 SP2 downloaded and extracted into a folder named sql_server_2014_dev_sp2

Build command: <br>
docker build -t sqlserver2014 .
