locals {
  // Comments examples
  /* Values which are calculated from others, including data source and variables
      Use singular block to mark a local as sensitive */
  class = "2024"


  // path.cwd: the directory from where Packer was started.
  # path.root: the directory of the input HCL file or the input folder.
  settings_file  = "${path.cwd}/settings.txt"
  scripts_folder = "${path.root}/scripts"
  root           = path.root


  # Packer wants all files UTF-8 encoded


  # Expressions
  make_a_list = [for s in var.list : upper(s)]
  make_a_map  = { for s in var.list : s => upper(s) }


}