# Communicators are the mechanism Packer uses to upload files, execute scripts, etc. with the machine being created. 
# none(Blocks a lot of provisioners), ssh, winrm
build {

  # Further defines source defined outside of build block
  source "" {

  }

  # Customizes machine image after booting
  provisioner "shell" {
    inline = []
    # We can run provisioners on only specific sources, keywords only and except
    # We can also override provisioners based on the source defined


    # We can pause before running a provisioner
    pause_before = "10s"

    # Allows the provisioner to be retried in case of failure
    max_retries = 5

    # Time to wait before considering the configuration as failed
    timeout = "5m"
  }

  # Special kind of provisioner, only one is allowed, runs in case of failure and before instance shuts down
  error-cleanup-provisioner "shell-local" {
    inline = ["echo 'rubber ducky'> ducky.txt"]
  }


  # Runs after each defined build, takes artifact after a build
  post-processor "checksum" {               # checksum image
    checksum_types      = ["md5", "sha512"] # checksum the artifact
    keep_input_artifact = true              # keep the artifact

    # Supports only and except keywords to limit which builds get post processeded
  }


  # It is possible to access the name and type of your source from provisioners and post-processors:
  provisioner "shell-local" {
    inline = ["echo ${source.name} and ${source.type}"]
  }

  # Build variables will allow you to access connection information and basic instance state information for a builder. All special build variables are stored in the build variable.
  provisioner "shell-local" {
    environment_vars = ["TESTVAR=${build.PackerRunUUID}"]
    inline = ["echo source.name is ${source.name}.",
      "echo build.name is ${build.name}.",
    "echo build.PackerRunUUID is $TESTVAR"]
  }

  # Example of interpolation 
  provisioner "shell-local" {
    environment_vars = ["TESTVAR=${build.PackerRunUUID}"]
    inline           = ["echo ${upper(build.ID)}"]
  }

  # Makes a simple breakpoint, like in any programming language
  provisioner "breakpoint" {
    disable = false
    note    = "this is a breakpoint"
  }

  # The file Packer provisioner uploads files to machines built by Packer. 
  provisioner "file" {
    source      = "app.tar.gz"
    destination = "/tmp/app.tar.gz"
  }

  # list of provisioners https://developer.hashicorp.com/packer/docs/provisioners
  # Custom provisioners, for example https://github.com/rgl/packer-plugin-windows-update


  # Post processors run after defined builds
  # The manifest post-processor writes a JSON file with a list of all of the artifacts packer produces during a run. I
  post-processor "manifest" {}

  # Run some shell scripts
  post-processor "shell-local" {
    inline = ["echo foo"]
  }

  # Artifice post builder overrides the list of artifacts, making it possible to build an app inside a vm image and mark build output as an artifact





}





