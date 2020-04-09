# oracle.provisioning
<p>This started as project to help a customer get off Solaris server onto RHEL and also upgrade their Oracle 12c database to Oracle 18c - cross platform migration upgrade.</p>
<p>Here are the scripts I wrote to achive the cross platform migration upgrade (obviously I've removed customer specfic data).</p>
<p>
  ./preInstall.sh<br />
  ./install.sh<br />
  ./postInstall.sh<br />
  ./createDatabase.sh {DBName} <br />
  ./importData.sh {DBName}
</p>
<p>
  ./deleteDatabase.sh {DBName}
</p>

