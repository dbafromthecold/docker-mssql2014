### docker-mssql2014
Dockerfile to create a container running SQL Server 2014

### Instructions

1. Extract SQL Server 2014 installation media into a folder called sql_server_2014
2. Download start.ps1 & dockerfile from this repo into the same location and run: - </br>
  docker build -t sqlserver2014build .
4. Wait until the verbose output reads "Started SQL Server"
5. Then in another shell, run: - </br>
  docker stop _containerID_ </br>
  docker commit _containerID_ sqlserver2014

