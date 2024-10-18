resource "aws_launch_template" "web" {
  name_prefix   = "web-template"
  image_id      = "ami-081de88a280aaa300" 
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.lb_security_group_id]
    # subnet_id = aws_subnet.public[0].id
  }
  user_data = base64encode(<<-EOF
              #!/bin/bash
              docker swarm join --token SWMTKN-1-5q23kgw0mfaeqkplhm4i4jemhl9gomps4387dlc7u4v2780txf-4y6hlkrn2vnbr79djvbf8js18 10.0.1.35:2377
              EOF
)
}

resource "aws_key_pair" "my_key" {
  key_name   = "my_key_name" 
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCcbWfotPkZQb4C7IP5riw+Keac6oTEeR4g5PlXGWh2429kZDgW7+jqlufWHFjaw+UDx0j3nV450+kGM+ainJhuIt9EjaNsFoPjM8KJhVKW5eiZlI9C6QmGOGmfiAHJ3yh/8e+gr+hVIRLnk+4RM4/x6yLxjLf93WcYrYxZpDCsSEl3sgiNaxixC1gLJ6NI2Wk9xcnCSzDiyjuzuKDLZ3zmZsOiqJWewxbUEFV+e/0XOoL2YCuElAGrWZOhAkT85pwuwxJBeG77q2g+1BVd0mkaS27y+4gHRZzStIVoLwrLrl7zEB9FC+wf+JdkCLLHF7NoX9eQtVxhBAzVD0UZNU87yhu6DsqQQy6HXshsdmZx0lR7uCXav2/NGy6GqPCUEf5ILj6k03MP0c/OHhzPGvv3pJnLtbL1KuPy5eSTDf9JYjN54f2VH+ow8lVPqbauuPnZsK2mHwkk4BD2OkD6oiizw/DFtbzh0l+yhEq1RtzZ1L/rDiUfI39IjEvVQiGCEzg9vItVDWS/PFP2l7rDASkfZDO6bJZxNzqEc64SAd0QhvXCX+BRLObRzbjEilXbfP7nDwN8sqxMv2HUrKdbrzzMAApvjmpGQM+wmPwB4r3zSvxKL0IiaiH9v3OQq2NMwA2ZvEtjXveLWV2PDbqiCk6gTkMC0tTBPDE6FMZUE1D1aQ== ay012941@gmail.com"  
}


