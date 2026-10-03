# ArkTrans

Artifact for the paper *ArkTrans: A Skeleton-guided Approach for Lightweight LLMs to Translate Declarative UIs to HarmonyOS*.

ArkTrans translates declarative UI code (Jetpack Compose / SwiftUI) into ArkUI through a
four-step pipeline: **Metadata Extraction** (tree-sitter parse of the source UI tree),
**Skeleton Construction** (mapping dictionary `D` builds an ArkTS skeleton), **LLT
Translation** (a lightweight LLM fills the skeleton with a reference screenshot), and
**Compiler-guided Repair** (a real hvigor compiler feeds diagnostics back, within a
bounded budget).

## Repository layout

```
ArkTrans/
├── benchmark/
│   ├── parallel_100pages/     100 parallel pages (001-100): kotlin/, swift/, kotlin_img/, swift_img/
│   └── realworld_52pages/     52 pages (101+) from 9 open-source apps, same layout
├── results/
│   ├── rq1_zero_shot/         LLM direct calls, agent harnesses (Claude Code, Codex, DSH), CodeArts IDE plugin
│   ├── rq2_common_strategies/ reference image / compiler repair / both, plus 10-round budget runs
│   ├── rq3_error_analysis/    full compiler diagnostic log (rq3_full_error_log.txt)
│   └── rq4_arktrans/          full method, ablations (no skeleton / no image / no repair), 52 real pages, 10-round budget
├── scripts/
│   ├── rq1_zero_shot/         llm_direct/ (multi-model direct translation), claudecode/, codex/, codearts/
│   ├── rq2_common_strategies/ direct translation with image / iterative repair, round extensions
│   ├── rq4_arktrans/          framework.py (4-step pipeline) + kt2ets/, swift2ets/ (ME/SC implementation)
│   └── evaluate/              visual metrics, screenshot render pipeline, minimal_hos + etssingleui templates
├── error_analysis.pdf         error taxonomy: 5 families, 14 sub-classes, annotated examples
├── requirements.txt
└── LICENSE
```

## Results conventions

- Language pairs are written `a/b` = kotlin/swift.
- Every repair round is kept: `NNN/NNN_iter0..K.ets` (iteration runs) or
  `NNN/{Index.ets, repairN.code.ets}` (ArkTrans runs); runs that stop early keep their
  finals only.
- Rendered screenshots (720x1280) live under `<run>/screenshots/{kotlin,swift}/`.
- Compilation status and per-round token/error counts are in each run's `trace.json`
  (kept in the internal workspace; the artifact stores code and screenshots).

## Setup

```bash
pip install -r requirements.txt
cp scripts/.env.example scripts/.env   # fill in API keys and tool paths
```

Toolchain: DevEco Studio (hvigorw, hdc, emulator), JDK 17, and the HarmonyOS / ArkUI-X
SDKs; `scripts/.env` points to all of them (`ARKTRANS_ROOT`, `HVIGORW`, `JAVA_HOME`,
`HOS_SDK_DIR`, provider keys).

## Usage pointers

- ArkTrans pipeline: `python scripts/rq4_arktrans/compact_skill.py --help`
- Direct translation baselines (plain / +image / +iterate): `python scripts/rq1_zero_shot/llm_direct/direct_translate.py --help`
- Screenshot + evaluation in one command: `python scripts/evaluate/render/screenshot_eval_pipeline.py --help`
- Compile-only check: `python scripts/rq4_arktrans/framework.py` (real hvigor on the
  `minimal_hos` template)

## Real-world benchmark sources

The 52 pages in `benchmark/realworld_52pages/` come from open-source apps
(Kotlin files 101-132, Swift files 101-120; the two movie apps form one thematic
group, giving 6 Android + 3 iOS apps):

| App | Platform | Pages | Source |
|---|---|---|---|
| Another Notes | Android | 101-108 | [maltaisn/another-notes-app](https://github.com/maltaisn/another-notes-app) |
| AudioNote | Android | 109-114 | [certified84/AudioNote](https://github.com/certified84/AudioNote) |
| EasyNotes | Android | 115-118 | [Kin69/EasyNotes](https://github.com/Kin69/EasyNotes) |
| Grit | Android | 119-128 | [shub39/Grit](https://github.com/shub39/Grit) |
| M-Pesa UI Clone | Android | 129 | [Breens-Mbaka/MpesaUiCloneAndroid](https://github.com/Breens-Mbaka/MpesaUiCloneAndroid) |
| Todo app | Android | 130-132 | [Ashish0077/ToDo_App_Android](https://github.com/Ashish0077/ToDo_App_Android) |
| Clean Pad | iOS | 101-113 | [urielortega/clean-pad](https://github.com/urielortega/clean-pad) |
| Movie apps | iOS | 114, 115, 119, 120 | [rphlfc/MovieApp](https://github.com/rphlfc/MovieApp), [V8tr/ModernMVVM](https://github.com/V8tr/ModernMVVM) |
| Weather | iOS | 116-118 | [bpisano/Weather](https://github.com/bpisano/Weather) |

## License

The code in this repository is released under the [MIT License](LICENSE). The benchmark
pages belong to their upstream projects and follow their respective licenses.
