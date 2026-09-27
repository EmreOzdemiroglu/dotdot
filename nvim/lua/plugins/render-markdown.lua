return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    heading = { width = "block", left_pad = 1, right_pad = 2 },
    code = { width = "block" },
    pipe_table = { preset = "round" },
  },
}
