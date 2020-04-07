# -*- coding: utf-8 -*-
import os

def get_config_env():
    config = {
        'API_KEY': os.getenv('API_KEY')
    }
    return config