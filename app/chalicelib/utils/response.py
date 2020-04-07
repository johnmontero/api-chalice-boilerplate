import json
from chalice import Chalice, Response    
from .exceptions import ErrorHTTPStatusCode

_CONTENT_TYPE_JSON = "application/json"
_HTTP_STATUS_CODE_OK = 200

def custom_response(status_code, message, data={}):

    response = Response(
        body={
            'code': status_code,
            'message': message,
            'data': data
        },
        headers={'Content-Type': _CONTENT_TYPE_JSON},
        status_code=status_code
    )

    return response


def validate_response_metadata(response):
    http_status_code = response['ResponseMetadata']['HTTPStatusCode']
    if not http_status_code == _HTTP_STATUS_CODE_OK:
        raise ErrorHTTPStatusCode('Error HTTPStatusCode: {}'.format(http_status_code))