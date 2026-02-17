build-Function:
	GOOS=linux GOARCH=arm64 CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -tags lambda.norpc -o bootstrap main.go
	cp bootstrap $(ARTIFACTS_DIR)/.