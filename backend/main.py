"""CutBG backend – BiRefNet inference.

Bezstavová FastAPI služba: přijme fotku, vrátí 8bitovou masku (PNG).
Nic se na serveru neukládá – historie žije 100% v mobilní aplikaci.
"""

import io
import os

from fastapi import FastAPI, File, Header, HTTPException, UploadFile
from fastapi.responses import Response

app = FastAPI(title='CutBG API', version='0.1.0')


def _check_api_key(x_api_key: str | None) -> None:
    expected = os.environ.get('API_KEY', '')
    if expected and x_api_key != expected:
        raise HTTPException(status_code=401, detail='Neplatný API klíč.')


@app.get('/v1/health')
async def health() -> dict:
    """Health check – pokryje i studený start GPU kontejneru."""
    return {'status': 'ok'}


@app.post('/v1/remove-background')
async def remove_background(
    file: UploadFile = File(...),
    x_api_key: str | None = Header(default=None),
) -> Response:
    """Odstranění pozadí: vstup fotka, výstup PNG maska."""
    _check_api_key(x_api_key)
    data = await file.read()
    if not data:
        raise HTTPException(status_code=400, detail='Prázdný soubor.')

    # TODO: načíst BiRefNet (lazy singleton na GPU), inference, práh masky.
    # Dočasně vracíme 501, dokud není model zapojený.
    _ = io.BytesIO(data)
    raise HTTPException(
        status_code=501, detail='Model BiRefNet zatím není nasazený.'
    )
