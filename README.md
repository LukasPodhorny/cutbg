# CutBG – odstranění pozadí z fotky (BiRefNet)

Mobilní aplikace pro automatické i ruční odstraňování a nahrazování pozadí
z fotografií. Návrh projektu: [`docs/`](/home/lukaspodhorny/projects/cutbg/docs).

- **Aplikace (Flutter):** import z galerie / fotoaparátu, automatické odstranění
  pozadí přes API, ruční oprava masky štětcem, lokální historie (SQLite),
  náhrada pozadí a export PNG/JPEG.
- **Backend (FastAPI na Modal GPU):** bezstavová inference modelu BiRefNet,
  viz [`backend/README.md`](/home/lukaspodhorny/projects/cutbg/backend/README.md).
  Server nic neukládá.

## Struktura

```text
cutbg/
├── lib/
│   ├── main.dart                  # vstupní bod (+ načtení .env)
│   ├── app.dart                   # MaterialApp + DI (Bloc, repozitáře)
│   ├── core/
│   │   ├── config/app_env.dart    # typovaný přístup k .env
│   │   ├── theme/app_theme.dart   # světlý / tmavý motiv
│   │   └── utils/image_utils.dart # EXIF + škálování v Isolatu
│   ├── data/
│   │   ├── db/app_database.dart   # SQLite: projects, user_settings
│   │   ├── models/                # ProjectRecord, UserSettings
│   │   └── repositories/          # CRUD nad historií
│   ├── services/
│   │   ├── api/bg_removal_api.dart # volání backendu (health, maska)
│   │   ├── media/media_service.dart # image_picker (galerie/fotoaparát)
│   │   └── export/export_service.dart # uložení do galerie, sdílení
│   └── features/
│       ├── home/view/home_page.dart       # domov / historie + import
│       ├── editor/                        # Editor (Bloc) + CustomPainter masky
│       └── export/view/export_page.dart   # formát, rozlišení, uložit/sdílet
├── backend/          # FastAPI + Modal (BiRefNet inference)
├── test/             # widget testy
├── docs/             # projektový návrh (PDF)
├── android/ ios/     # podporované platformy (desktop/web smazány)
├── .env.example      # šablona prostředí → zkopírovat do .env
└── pubspec.yaml      # knihovny viz níže
```

## Knihovny

| Balíček | Účel (funkce z návrhu) |
|---|---|
| `flutter_bloc`, `equatable` | state management editoru (nahrávání, maska, undo/redo) |
| `image_picker` | import z galerie / fotoaparátu |
| `image` | EXIF orientace, škálování velkých fotek |
| `http` | volání backendu (`/v1/health`, `/v1/remove-background`) |
| `sqflite`, `path`, `path_provider` | lokální historie projektů + nastavení |
| `uuid` | ID projektů |
| `flutter_dotenv` | konfigurace z `.env` |
| `share_plus`, `gal` | sdílení a ukládání exportu do galerie |
| `bloc_test`, `mocktail` (dev) | testy bloců |

## Oprávnění

- **Android** (`android/app/src/main/AndroidManifest.xml`):
  `INTERNET` (API), `CAMERA`, `READ_MEDIA_IMAGES` (Android 13+),
  `READ_EXTERNAL_STORAGE` (max SDK 32). Ukládání jde přes MediaStore.
- **iOS** (`ios/Runner/Info.plist`): `NSCameraUsageDescription`,
  `NSPhotoLibraryUsageDescription`, `NSPhotoLibraryAddUsageDescription`.

## Rychlý start (aplikace)

```sh
flutter pub get
cp .env.example .env   # a doplň API_BASE_URL na svůj backend
flutter analyze
flutter test
flutter run
```

## Backend

```sh
cd backend
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000   # lokálně
modal deploy modal_app.py               # produkční GPU deploy
```

Detaily viz [`backend/README.md`](/home/lukaspodhorny/projects/cutbg/backend/README.md).
