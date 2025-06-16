import json
import logging
import os
from typing import Dict, Any

# Configure logging
logger = logging.getLogger()
logger.setLevel(os.environ.get('LOG_LEVEL', 'INFO'))

def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Any]:
    """
    Lambda function to process S3 events and log filenames to CloudWatch.
    
    Args:
        event: S3 event data
        context: Lambda context object
    
    Returns:
        Dictionary with status and processed files count
    """
    
    logger.info(f"Received event: {json.dumps(event)}")
    
    processed_files = []
    
    try:
        # Process each record in the S3 event
        for record in event.get('Records', []):
            # Extract S3 information
            s3_info = record.get('s3', {})
            bucket_name = s3_info.get('bucket', {}).get('name', 'Unknown')
            object_key = s3_info.get('object', {}).get('key', 'Unknown')
            event_name = record.get('eventName', 'Unknown')
            
            # Log the file information
            log_message = f"S3 Event: {event_name} | Bucket: {bucket_name} | File: {object_key}"
            logger.info(log_message)
            
            processed_files.append({
                'bucket': bucket_name,
                'key': object_key,
                'event': event_name
            })
            
            # Additional processing can be added here
            # For example: validate file type, process content, etc.
            
    except Exception as e:
        logger.error(f"Error processing S3 event: {str(e)}")
        raise e
    
    response = {
        'statusCode': 200,
        'body': {
            'message': f'Successfully processed {len(processed_files)} files',
            'processedFiles': processed_files
        }
    }
    
    logger.info(f"Lambda execution completed. Response: {json.dumps(response)}")
    
    return response

def validate_file_type(object_key: str) -> bool:
    """
    Validate if the uploaded file type is allowed.
    
    Args:
        object_key: S3 object key (filename)
    
    Returns:
        Boolean indicating if file type is valid
    """
    allowed_extensions = ['.txt', '.json', '.csv', '.pdf', '.jpg', '.png']
    
    file_extension = os.path.splitext(object_key.lower())[1]
    return file_extension in allowed_extensions

def get_file_size_info(s3_object: Dict[str, Any]) -> str:
    """
    Extract and format file size information.
    
    Args:
        s3_object: S3 object information from event
    
    Returns:
        Formatted file size string
    """
    size_bytes = s3_object.get('size', 0)
    
    if size_bytes < 1024:
        return f"{size_bytes} bytes"
    elif size_bytes < 1024 * 1024:
        return f"{size_bytes / 1024:.2f} KB"
    else:
        return f"{size_bytes / (1024 * 1024):.2f} MB"