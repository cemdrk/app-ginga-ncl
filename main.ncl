<ncl id="appFood" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
  <head>
    <regionBase>
      <region id="regApp" width="100%" height="100%" />
    </regionBase>
    <descriptorBase>
      <descriptor id="desApp" region="regApp" />
    </descriptorBase>
  </head>
  <body>
    <port id="pApp" component="app" />
    <media id="app" type="application/x-ginga-NCLua" src="lua/main.lua" descriptor="desApp" />
  </body>
</ncl>