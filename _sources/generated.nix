# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  awesomewm = {
    pname = "awesomewm";
    version = "7ed4dd620bc73ba87a1f88e6f126aed348f94458";
    src = fetchFromGitHub ({
      owner = "awesomeWM";
      repo = "awesome";
      rev = "7ed4dd620bc73ba87a1f88e6f126aed348f94458";
      fetchSubmodules = false;
      sha256 = "sha256-o69if8HQw2u0fp5J7jkS4WQeAXVuiFwpDLzGFscP4mM=";
    });
  };
  picom = {
    pname = "picom";
    version = "a6b4e285f833c13b217c0e30ca71a903ec2464b5";
    src = fetchFromGitHub ({
      owner = "yshui";
      repo = "picom";
      rev = "a6b4e285f833c13b217c0e30ca71a903ec2464b5";
      fetchSubmodules = false;
      sha256 = "sha256-l76TyxuBjHhIHG1FWzgdAy2obELdVdgtCkdGrfXTK44=";
    });
  };
  powerlevel10k = {
    pname = "powerlevel10k";
    version = "862440ae112603c8e2d202f6edb94eeaa1509120";
    src = fetchgit {
      url = "https://github.com/romkatv/powerlevel10k.git";
      rev = "862440ae112603c8e2d202f6edb94eeaa1509120";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-iJ35ZmlarMpwb5TOno273QrAaQJUmOBLDdGDowOo+qM=";
    };
  };
  rtl8812au = {
    pname = "rtl8812au";
    version = "04f600ee54a414b871aea509fcd4709838c8c522";
    src = fetchgit {
      url = "https://github.com/aircrack-ng/rtl8812au.git";
      rev = "04f600ee54a414b871aea509fcd4709838c8c522";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-QhE3h0Jw0J5TynWCSNcSz/Iw53B+pdk0SS/oaR8RtTE=";
    };
  };
  stfork = {
    pname = "stfork";
    version = "36d225d71d448bfe307075580f0d8ef81eeb5a87";
    src = fetchgit {
      url = "https://github.com/LukeSmithxyz/st.git";
      rev = "36d225d71d448bfe307075580f0d8ef81eeb5a87";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-u8E8/aqbL3T4Sz0olazg7VYxq30haRdSB1SRy7MiZiA=";
    };
  };
  themixgui = {
    pname = "themixgui";
    version = "6d9f49cafe8d18ef13dff7c619aee6f293052617";
    src = fetchgit {
      url = "https://github.com/themix-project/themix-gui.git";
      rev = "6d9f49cafe8d18ef13dff7c619aee6f293052617";
      fetchSubmodules = true;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-PvMcAMt+KxnWEcNRSRHq4ntm22CTTrfbS3lFtiDrhj8=";
    };
  };
  wezterm = {
    pname = "wezterm";
    version = "fec90ae04bf448d4b1475ba1d0ba1392846a70d6";
    src = fetchgit {
      url = "https://github.com/wez/wezterm.git";
      rev = "fec90ae04bf448d4b1475ba1d0ba1392846a70d6";
      fetchSubmodules = true;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-7eMeNdmo8vpSnoPamShdLSTAUcK/mCiEpL30t+5spvc=";
    };
  };
  zsh-nix-shell = {
    pname = "zsh-nix-shell";
    version = "406ce293f5302fdebca56f8c59ec615743260604";
    src = fetchgit {
      url = "https://github.com/chisui/zsh-nix-shell.git";
      rev = "406ce293f5302fdebca56f8c59ec615743260604";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-dE86o8LfEfswIIP9r0BJpxWvkoYdu7VQcJOKTLYqtWs=";
    };
  };
}