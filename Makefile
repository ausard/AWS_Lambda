default:
	aws cloudformation package --template-file template.yml --output-template-file sam-template-output.yaml --s3-bucket sam-deployment-bucket-ausard
	aws cloudformation deploy --template-file sam-template-output.yaml --stack-name HelloSAMApp --capabilities CAPABILITY_IAM
sam:	
	sam build
	sam deploy



