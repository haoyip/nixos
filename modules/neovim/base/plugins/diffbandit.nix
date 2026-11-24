{diffbanditPlugin, ...}: {
  config.vim.lazy.plugins.diffbandit = {
    package = diffbanditPlugin;
    setupModule = "diffbandit";
    setupOpts = {};

    cmd = [
      "DiffBandit"
      "DiffBanditBuffers"
      "DiffBanditGit"
      "DiffBanditGitCurrent"
      "DiffBanditCommitPanel"
      "DiffBanditGitMenu"
      "DiffBanditGitLog"
      "DiffBanditGitCommit"
      "DiffBanditGitCompare"
      "DiffBanditGitCheckout"
      "DiffBanditMerge"
      "DiffBanditFolderDiff"
      "DiffBanditClose"
      "DiffBanditLaunch"
      "DiffBanditToggleStageHunk"
      "DiffBanditStageHunk"
      "DiffBanditUnstageHunk"
      "DiffBanditDiscardHunk"
      "DiffBanditApplyLeftHunk"
      "DiffBanditApplyRightHunk"
      "DiffBanditApplyLeftOthers"
      "DiffBanditApplyRightOthers"
      "DiffBanditUndo"
    ];
  };
}
