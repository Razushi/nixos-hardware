{
  config,
  lib,
  ...
}:
{
  # Backward-compat for 24.05, can be removed after we drop 24.05 support
  options = {
    hardware.graphics = lib.optionalAttrs (lib.versionOlder lib.version "24.11pre") {
      enable = lib.mkOption {
        type = lib.types.nullOr lib.types.bool;
        default = null;
      };
      enable32Bit = lib.mkOption {
        type = lib.types.nullOr lib.types.bool;
        default = null;
      };
      extraPackages = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.package);
        default = null;
      };
      extraPackages32 = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.package);
        default = null;
      };
    };
  };

  config = {
    hardware.opengl = lib.optionalAttrs (lib.versionOlder lib.version "24.11pre") {
      enable = lib.mkIf (config.hardware.graphics != null) config.hardware.graphics.enable;
      driSupport32Bit = lib.mkIf (config.hardware.graphics.enable32Bit != null) config.hardware.graphics.enable32Bit;
      extraPackages = lib.mkIf (config.hardware.graphics.extraPackages != null) config.hardware.graphics.extraPackages;
      extraPackages32 = lib.mkIf (config.hardware.graphics.extraPackages32 != null) config.hardware.graphics.extraPackages32;
    };
  };
}
