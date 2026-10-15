# CutBG backend (FastAPI + BiRefNet, běh na Modal GPU)

Bezstavová API služba – neukládá žádné fotky ani uživatelská data.

## Endpoints

- `GET /v1/health` – health check (i studený start)
- `POST /v1/remove-background` – vstup `multipart/form-data` s polem `file`,
  výstup PNG maska; volitelná hlavička `X-API-Key`

## Lokální běh

```sh
cd backend
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # a doplň API_KEY
uvicorn main:app --reload --port 8000
```

## Deploy na Modal

```sh
modal deploy modal_app.py
```

URL nasazené služby zapiš do kořenového `.env` jako `API_BASE_URL`.
