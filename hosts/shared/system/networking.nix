{
  networking = {
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      unmanaged = [
        "docker0" 
        "rndis0"
      ];
    };

    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };
}