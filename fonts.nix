{ config, pkgs, ... }:

{
  # Font packages
  fonts.packages = with pkgs; [
    monaspace
    font-awesome
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # MacOS-like font rendering configuration
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting = {
      enable = true;
      style = "full";
    };
    subpixel = {
      lcdfilter = "light";
      rgba = "rgb";
    };
    defaultFonts = {
      serif = ["Monaspace Xenon Frozen"];
      sansSerif = ["Monaspace Argon Frozen"];
      monospace = [ "Monaspace Krypton Frozen" ];
      emoji = ["Font Awesome 6 Free"];
    };
    localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <!-- MacOS-like font rendering settings -->
        <match target="font">
          <edit name="antialias" mode="assign">
            <bool>true</bool>
          </edit>
          <edit name="hinting" mode="assign">
            <bool>true</bool>
          </edit>
          <edit name="hintstyle" mode="assign">
            <const>hintfull</const>
          </edit>
          <edit name="rgba" mode="assign">
            <const>rgb</const>
          </edit>
          <edit name="lcdfilter" mode="assign">
            <const>lcdlight</const>
          </edit>
          <edit name="autohint" mode="assign">
            <bool>false</bool>
          </edit>
        </match>
        
        <!-- Monaspace-specific optimizations -->
        <match target="font">
          <test name="family" compare="contains">
            <string>Monaspace</string>
          </test>
          <edit name="hinting" mode="assign">
            <bool>true</bool>
          </edit>
          <edit name="hintstyle" mode="assign">
            <const>hintslight</const>
          </edit>
          <edit name="autohint" mode="assign">
            <bool>false</bool>
          </edit>
        </match>
        
        <!-- Enable font features for Monaspace -->
        <match target="font">
          <test name="family" compare="contains">
            <string>Monaspace</string>
          </test>
          <edit name="fontfeatures" mode="append">
            <string>calt on</string>
            <string>liga on</string>
            <string>dlig on</string>
            <string>ss01 on</string>
            <string>ss02 on</string>
            <string>ss03 on</string>
            <string>ss04 on</string>
            <string>ss05 on</string>
            <string>ss06 on</string>
            <string>ss07 on</string>
            <string>ss08 on</string>
          </edit>
        </match>
        
        <!-- Better rendering for small sizes -->
        <match target="font">
          <test name="size" compare="less">
            <double>12</double>
          </test>
          <edit name="hintstyle" mode="assign">
            <const>hintslight</const>
          </edit>
        </match>
        
        <!-- Ultrawide monitor optimizations -->
        <!-- Enable embeddedbitmap for better rendering at higher resolutions -->
        <match target="font">
          <edit name="embeddedbitmap" mode="assign">
            <bool>false</bool>
          </edit>
        </match>
        
        <!-- Improve contrast and sharpness for larger displays -->
        <match target="font">
          <edit name="embolden" mode="assign">
            <bool>false</bool>
          </edit>
          <edit name="rgba" mode="assign">
            <const>rgb</const>
          </edit>
          <!-- Better gamma correction for wider displays -->
          <edit name="gamma" mode="assign">
            <double>1.0</double>
          </edit>
        </match>
        
        <!-- DPI settings optimized for modern displays -->
        <match target="pattern">
          <edit name="dpi" mode="assign">
            <double>96</double>
          </edit>
        </match>
        
        <!-- Monaspace-specific DPI handling -->
        <match target="font">
          <test name="family" compare="contains">
            <string>Monaspace</string>
          </test>
          <edit name="pixelsize" mode="assign">
            <times>
              <name>size</name>
              <double>1.0</double>
            </times>
          </edit>
        </match>
        
        <!-- Enhanced stem darkening for better readability -->
        <match target="font">
          <edit name="stem_darkening" mode="assign">
            <bool>false</bool>
          </edit>
          <edit name="stem_darkening_for_light_weights" mode="assign">
            <bool>false</bool>
          </edit>
        </match>
        
        <!-- Monaspace rendering improvements -->
        <match target="font">
          <test name="family" compare="contains">
            <string>Monaspace</string>
          </test>
          <edit name="embolden" mode="assign">
            <bool>false</bool>
          </edit>
          <edit name="embeddedbitmap" mode="assign">
            <bool>false</bool>
          </edit>
          <edit name="spacing" mode="assign">
            <const>proportional</const>
          </edit>
        </match>
      </fontconfig>
    '';
  };
}