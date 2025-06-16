FROM public.ecr.aws/lambda/python:3.11

WORKDIR ${LAMBDA_TASK_ROOT}

# Copy function code
COPY lambda_fuction.py ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler (could be handler.lambda_handler)
CMD [ "lambda_function.lambda_handler" ]