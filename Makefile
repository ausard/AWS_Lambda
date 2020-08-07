default:
	aws cloudformation package --template-file template.yml --output-template-file sam-template-output.yaml --s3-bucket sam-deployment-bucket-ausard
	aws cloudformation deploy --template-file sam-template-output.yaml --stack-name HelloSAMApp --capabilities CAPABILITY_IAM
sam:	
	sam build
	sam deploy
sam-libs:
	sam build --template-file template_with_lib.yml
	sam deploy --template-file template_with_lib.yml
sam-p:
	sam package \
    --template-file template_p.yml \
    --output-template-file packaged.yml \
    --s3-bucket sam-deployment-bucket-ausard
	sam deploy --template-file packaged.yml



