# install
aws-cli<br>
sam-cli

# deploy

### 環境変数
```bash
export AppName="fix-ip-lambda"
export FixIPEnabled="true"
export TargetRegion="us-east-2"
export BucketName="${AppName}-${TargetRegion}"
export URL="https://httpbin.org/ip"
```

### S3
```bash
aws cloudformation deploy \
	--region "${TargetRegion}" \
    --stack-name "${AppName}-s3" \
    --template-file template-s3.yaml \
    --parameter-overrides BucketName="${BucketName}"
```

### VPC
```bash
aws cloudformation deploy \
    --region "${TargetRegion}" \
    --stack-name "${AppName}-vpc" \
    --template-file template-vpc.yaml \
    --capabilities CAPABILITY_IAM
```

### Lambda
```bash
# ビルド (Makefileを使用)
sam build --template-file template-lambda.yaml

# デプロイ
sam deploy \
	--region "${TargetRegion}" \
    --stack-name "${AppName}-exec" \
    --s3-bucket "${BucketName}" \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
        URL="${URL}" \
        FixIPEnabled="${FixIPEnabled}"
```