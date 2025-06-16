FROM public.ecr.aws/lambda/python:3.11

# Copy function code
COPY lambda_function.py ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler (could be handler.lambda_handler)
CMD [ "lambda_function.lambda_handler" ]