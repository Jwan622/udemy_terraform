provider "aws" {
  region = "us-west-2"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "jeff web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld  "
  }
}
