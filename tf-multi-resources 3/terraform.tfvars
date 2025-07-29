ec2_config = [{
  ami           = "ami-0f918f7e67a3323f0" #ubantu
  instance_type = "t3.micro"
  }, {
  ami           = "ami-0d0ad8bb301edb745" #amazon linux
  instance_type = "t3.micro"
}]



ec2_map = {
  "ubantu" = {

    ami           = "ami-0f918f7e67a3323f0" #ubantu
    instance_type = "t3.micro"


  },
  "amazon_linux" = {

    ami           = "ami-0d0ad8bb301edb745" #amazon linux
    instance_type = "t3.micro"

  }
}
