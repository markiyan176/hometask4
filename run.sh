aws ec2 run-instances \
    --image-id ami-053b0d53c279acc90 \
    --instance-type t3.micro \
    --key-name  key-pair \
    --user-data file://data.sh \
    --security-group-ids sg-08b084dacb4d715a7 \
    --subnet-id subnet-0f6b23530167077ac \
    --iam-instance-profile Name=AmazonSSMManagedInstanceCore