function aws --description 'SSH into AWS VM for EECS 340 Project 2'
        ssh -i ~/Security/EECS340Project2.pem \
            ec2-user@ec2-18-217-45-103.us-east-2.compute.amazonaws.com \
            $argv
end
