import os
import json
import logging

logger = logging.getLogger()
logger.setLevel(os.environ.get("LOG_LEVEL", "INFO"))

def lambda_handler(event, context):
    logger.info(f"Received event: {json.dumps(event)}")

    if 'Records' in event:
        for record in event['Records']:
            if 's3' in record:
                bucket_name = record['s3']['bucket']['name']
                object_key = record['s3']['object']['key']
                logger.info(f"File uploaded to S3: Bucket='{bucket_name}', Key='{object_key}'")
            else:
                logger.warning("Record does not contain S3 event data.")
    else:
        logger.warning("Event does not contain 'Records' key, or is not an S3 event.")

    return {
        'statusCode': 200,
        'body': json.dumps('Lambda processed the S3 event successfully!')
    }