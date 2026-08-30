# TrailAnalyzer

Create ML training project for official Develop in Swift tutorial "Model training with Create ML" / "Train a Core ML model". Completed 30 Aug 2026. This is Create ML training, NOT an iOS app. Path: `/Users/zathras/Developer/TrailAnalyzer`.

Apple zip `TrailData.zip` was 404. Official `TrailExamples.csv` (14 rows) plus reconstructed `Trail1k.csv` (1000) and `Trail10k.csv` (10000) from the official examples' risk formula:

```
risk = distance + (elevation // 200) + terrain_bonus + dangerous*50
terrain_bonus: paved=0, dirt=10, sand=30, rocky=40
```

Formula used only to reconstruct missing zip data, not as a wrap extra.

Create ML GUI skipped (`/Applications/Xcode.app/Contents/Applications/Create ML.app` exists; GUI not driven). Trained with Create ML framework (`train.swift`). Target `risk`. Features `distance`, `elevation`, `terrain`, `dangerous`. Train on Trail10k, test on Trail1k, preview on TrailExamples. Algorithms: Automatic, then Decision Tree, then Linear Regression.

Compile (succeeded; deprecation warnings only):

```
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
SDK=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX26.5.sdk
SWIFTC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swiftc
"$SWIFTC" -sdk "$SDK" -target arm64-apple-macosx14.0 \
  -F "$SDK/System/Library/Frameworks" -framework CreateML -framework Foundation \
  -o /Users/zathras/Developer/TrailAnalyzer/train \
  /Users/zathras/Developer/TrailAnalyzer/train.swift
```

Mechanical fix: `MLRegressor.write(to: url, metadata: nil)` (SDK requires metadata). Categorical terrain accepted; no numeric encoding.

Metrics:

- Automatic: train maxError=0.410877 rmse=0.280949; valid maxError=0.410252 rmse=0.282212; test maxError=0.410685 rmse=0.279805; examples maxError=0.370798 rmse=0.330248
- Decision Tree (worse): train maxError=30.748352 rmse=9.493822; valid maxError=27.277771 rmse=9.796010; test maxError=31.251648 rmse=9.478694; examples maxError=18.026814 rmse=10.917365
- Linear Regression (similar to Automatic): train maxError=0.409679 rmse=0.280978; valid maxError=0.408098 rmse=0.282826; test maxError=0.409355 rmse=0.279744; examples maxError=0.370438 rmse=0.330807

Saved models:

- `/Users/zathras/Developer/TrailAnalyzer/TrailAnalyzer.mlmodel` (600 bytes) — Automatic
- `/Users/zathras/Developer/TrailAnalyzer/TrailAnalyzer Automatic.mlmodel` (600 bytes)
- `/Users/zathras/Developer/TrailAnalyzer/TrailAnalyzer Decision Tree.mlmodel` (3252 bytes)
- `/Users/zathras/Developer/TrailAnalyzer/TrailAnalyzer Linear Regression.mlmodel` (600 bytes)

Accounts empty, no ADP, CODE_SIGNING n/a (macOS CLI). Wrap extras skipped (Linear Regression param tweaks, TrailData1k vs 10k extra experiment, reverse-engineer as extra, non-risk target models).

Official quiz: (1) Choosing the correct algorithm. (2) False — validation data is not used in the trained model. (3) Choose the algorithm that best fits the data.

Import models with Core ML / Custom models with Core ML is NOT started. Model saved only; not imported into an app. SignDecoder, HikingSurvey, and GratefulMoments left as-is.
