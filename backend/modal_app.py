# CutBG API na serverless GPU (Modal).
#
# Deploy:
#   pip install -r requirements.txt
#   modal deploy modal_app.py
#
# Lokální vývoj:
#   uvicorn main:app --reload --port 8000

import modal

image = modal.Image.debian_slim(python_version='3.11').pip_install(
    'fastapi',
    'python-multipart',
    'pillow',
    'torch',
    'torchvision',
)

app = modal.App('cutbg-api')


@app.function(
    image=image,
    gpu='T4',
    timeout=300,
    secrets=[modal.Secret.from_name('cutbg-env')],
)
@modal.asgi_app()
def api():
    import main

    return main.app
