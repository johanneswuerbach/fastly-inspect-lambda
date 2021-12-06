NAME := fastly-inspect-lambda
IMG := johanneswuerbach/$(NAME)

build:
	docker build -t $(IMG) .
	docker rm $(NAME) || true
	docker create --name $(NAME) $(IMG)
	docker cp $(NAME):/lambda/function.zip ./lambda.zip
	docker rm $(NAME)
