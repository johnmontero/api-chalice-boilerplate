import json
from chalicelib.utils.constants import HTTP_OK
from chalicelib.utils.exceptions import ExceptionHandler

class StatusResource(object):

    def __init__(self, config, app):
        self.config = config
        self.app = app

    def on_get(self, request):
        self.app.log.info("Procesando petición de status")
        response = {
            'code': HTTP_OK,
            'message':f'Response was successfully.',
            'data': {
                'status': 'ok'
            }
        }
        
        return response