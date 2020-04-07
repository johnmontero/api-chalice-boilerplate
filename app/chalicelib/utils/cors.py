from chalice import CORSConfig

cors_config =  CORSConfig(
        allow_origin='*',
        allow_headers=[
            'Authorization',
            'Content-Type',
            'X-Amz-Date',
            'X-Amz-Security-Token',
            'X-Api-Key',
            'token']
    )