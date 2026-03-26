# ArkTrans: A Heuristic-guided LLM Approach for Translating Declarative UIs to HarmonyOS

## 1 Overview

As an emerging operating system, HarmonyOS has a significant demand for software migration from platforms such as Android and iOS, where the User Interface (UI) translation accounts for a critical link. However, the latest UI development has shifted to declarative paradigms, e.g., Kotlin Jetpack Compose (KJC) for Android, SwiftUI for iOS, and ArkUI for HarmonyOS, rendering prior translation approaches inapplicable, as they target either backend logic or legacy imperative UIs.

ArkTrans overcomes two salient challenges during the translation: (1) PL unfamiliarity, and (2) severe syntactic chaos. Towards the first challenge, ArkTrans heuristically constructs ArkUI skeletons by extracting metadata from source PL, thereby guiding LLMs' initial translation. As for the second challenge, ArkTrans executes empirically revealed post-fixing rules via pattern matching to repair most of the remaining syntactic errors.

Extensive experiments demonstrate that LLMs with direct/one-shot prompting cannot translate a single compilable UI page. In contrast, at most 90.67% ArkTrans-translated files can be successfully compiled with high visual fidelity.



## 2 Quick Start

### 2.1 Prerequisites

- Python 3.10+
- OpenAI API key (or compatible LLM endpoint)
- Android 16 (API 36), iOS 18.6, and HarmonyOS 6.0.2

### 2.2 Installation

```bash
pip install -r requirements.txt
```

**Note:** The evaluation tools require PyTorch. For GPU support, install the CUDA version of PyTorch separately following [official instructions](https://pytorch.org/get-started/locally/).

### 2.3 Configuration

Set your LLM API key in `.env`:

```bash
OPENAI_API_KEY="your-api-key"
```

### 2.4 Run Translation

**Kotlin → ArkTS:**
```bash
cd scripts/kt2ets

# Full pipeline (all 4 steps)
python pipeline.py /path/to/kotlin/file.kt -o output_dir --provider <provider>

# Process entire directory
python pipeline.py /path/to/kotlin/dir -o output_dir --provider <provider>

# Run single step only
python pipeline.py /path/to/kotlin/file.kt -o output_dir --step 3 --provider <provider>
```

**Swift → ArkTS:**
```bash
cd scripts/swift2ets

# Full pipeline (all 4 steps)
python pipeline_swift.py /path/to/swift/file.swift -o output_dir --provider <provider>

# Process entire directory
python pipeline_swift.py /path/to/swift/dir -o output_dir --provider <provider>

# Run single step only
python pipeline_swift.py /path/to/swift/file.swift -o output_dir --step 3 --provider <provider>
```

**`<provider>`**: Select from supported models (run `--help` to see available options)



## 3 Evaluation

### 3.1 Generate ArkUI Screenshots

We provide a minimal HarmonyOS project for rendering ArkUI pages and capturing screenshots.

**Setup:**
1. Open `evaluate/etssingleui/` in DevEco Studio
2. Replace `entry/src/main/ets/pages/Index.ets` with your generated ArkUI code
3. Run on emulator or device (fullscreen, status bar hidden)
4. Take screenshots and save to your evaluation directory

### 3.2 Run Metrics

**Global Metrics (CLIP + Color Histogram):**
```bash
cd evaluate
python evaluate_global.py
```

This evaluates CLIP semantic similarity and color histogram similarity between reference and generated images. Results are saved to `evaluation_results/`.

**Local Metrics (Position + Size + Color + Text):**
```bash
cd evaluate
python evaluation_pipeline.py --kotlin-dir <dir> --swift-dir <dir> --output-dir <dir>
```

Arguments:
- `--kotlin-dir`: Directory containing Kotlin-generated images (default: `kt_post`)
- `--swift-dir`: Directory containing Swift-generated images (default: `swift_post`)
- `--output-dir`: Output directory for results (default: `evaluation_results`)

This evaluates four local metrics: Position, Size, Color, and Text integrity.

**Result Structure:**

All experimental results are organized in the `result/` directory:

```
result/
├── img/                    # Generated ArkUI screenshots
├── Global Metrics/         # Global evaluation results (CLIP + Color Histogram)
└── Local Metrics/          # Local evaluation results (Position + Size + Color + Text)
```



## 4 Benchmark

To our knowledge, there is no existing benchmark for assessing KJC/SwiftUI-to-ArkUI translation. In addition, files are the primary compilation unit in UI pages. Thus, we manually construct a file-level UI migration benchmark in this work, which costs 200 person-hours.

To construct the dataset, three software engineers, each with over three years of professional mobile development experience, manually implemented various UI effects derived from open-source Android projects using KJC. These implementations were then manually ported to SwiftUI to create functionally equivalent counterparts. The development process strictly adhered to standardized naming and layout conventions; consequently, each implementation was engineered as a standalone page file, maintaining zero dependencies on external files or third-party libraries.

![](https://blogxiaozheng.oss-cn-beijing.aliyuncs.com/images/20260326205908425.png)

The benchmark is available in the `suc/` directory:
- `suc/kotlin/` - Kotlin Jetpack Compose source files
- `suc/swift/` - SwiftUI source files
- `suc/kotlin_img/` / `suc/swift_img/` - Rendered UI screenshots



## 5 Approach

ArkTrans accepts UI files of source-PLs (KJC or SwiftUI) as inputs and outputs semantically equivalent ArkUI code. Overall, ArkTrans consists of four main stages:

![](https://blogxiaozheng.oss-cn-beijing.aliyuncs.com/images/flowchart.png)

**(1) Metadata Extraction (ME):** This stage parses the source UI file to extract its component hierarchies and associated properties for UI tree construction in JSON format.

**(2) Skeleton Construction (SC):** Using the above UI tree, ArkTrans generates an ArkUI skeleton by topology with partial ArkUI code while ensuring the maximum preservation of the metadata that cannot be migrated with heuristics. A component mapping dictionary (see `scripts/kt2ets/mappings/components.json` and `scripts/swift2ets/mappings/components.json`) defines the mappable components, properties, and modifiers from source PLs (KJC/SwiftUI) to their ArkUI counterparts.

**(3) LLM-driven Translation (LT):** This stage invokes an LLM to populate the skeleton and offer a one-shot example from the ArkUI skeleton to its corresponding code, enabling the LLM to generate syntactically correct code while strictly adhering to the pre-defined layout topology.

**(4) Post-Fixing (PF):** To maximize the compilability of the migrated code, this stage includes a series of heuristic rules revealed by our empirical analysis of common LLM failures during UI migration.



## 6 One-Shot Examples

We provide three one-shot examples for guiding LLM translation:

### 6.1 Basic One-Shot Example (Kotlin → ArkTS)

Used in `basic_oneshot.py` for Kotlin to ArkTS translation.

**Input (Kotlin):**

~~~kotlin
package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                CompactOneShot()
            }
        }
    }
}

@Composable
fun CompactOneShot() {
    var v by remember { mutableStateOf(50f) }

    Box(
        modifier = Modifier
            .fillMaxSize()
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(Color(0xFFF5F5F5))
                .padding(16.dp)
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(56.dp)
                    .background(Color.White)
                    .shadow(4.dp, shape = RoundedCornerShape(0.dp))
                    .padding(start = 16.dp, end = 16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = "Title",
                    fontSize = 20.sp,
                    fontWeight = androidx.compose.ui.text.font.FontWeight.Medium,
                    color = Color.Black
                )
                Spacer(modifier = Modifier.weight(1f))
                Box(
                    modifier = Modifier
                        .size(24.dp)
                        .background(Color(0xFFE0E0E0))
                )
            }

            Spacer(modifier = Modifier.height(12.dp))

            LazyColumn(
                modifier = Modifier.weight(1f),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                item {
                    TextField(
                        value = "",
                        onValueChange = {},
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(44.dp),
                        shape = RoundedCornerShape(8.dp),
                        colors = TextFieldDefaults.colors(
                            focusedContainerColor = Color.White,
                            unfocusedContainerColor = Color.White,
                            focusedIndicatorColor = Color.Transparent,
                            unfocusedIndicatorColor = Color.Transparent,
                            disabledIndicatorColor = Color.Transparent,
                            errorIndicatorColor = Color.Transparent
                        ),
                        singleLine = true
                    )
                }
                item {
                    Divider(
                        modifier = Modifier.height(1.dp),
                        color = Color(0xFFE0E0E0)
                    )
                }
                item {
                    LinearProgressIndicator(
                        progress = { v / 100f },
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(4.dp),
                        color = Color(0xFF6750A4),
                        trackColor = Color(0xFFE0E0E0)
                    )
                }
                item {
                    Slider(
                        value = v,
                        onValueChange = { v = it },
                        valueRange = 0f..100f,
                        modifier = Modifier.fillMaxWidth()
                    )
                }
                item {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        Box(
                            modifier = Modifier
                                .weight(1f)
                                .background(Color.White, shape = RoundedCornerShape(8.dp))
                                .padding(20.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            Text("A", color = Color.Black)
                        }
                        Box(
                            modifier = Modifier
                                .weight(1f)
                                .background(Color.White, shape = RoundedCornerShape(8.dp))
                                .padding(20.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            Text("B", color = Color.Black)
                        }
                    }
                }
            }
        }

        Button(
            onClick = {},
            modifier = Modifier
                .size(56.dp)
                .align(Alignment.BottomEnd)
                .offset(x = (-24).dp, y = (-24).dp),
            shape = RoundedCornerShape(16.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFFEADDFF)
            ),
            elevation = ButtonDefaults.buttonElevation(
                defaultElevation = 6.dp,
                pressedElevation = 6.dp,
                focusedElevation = 6.dp,
                hoveredElevation = 6.dp
            )
        ) {
            Text(
                text = "Button",
                color = Color.White,
                fontSize = 14.sp
            )
        }
    }
}
~~~

**Output (ArkTS):**

~~~typescript
@Entry
@Component
struct CompactOneShot {
  @State v: number = 50

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: 12 }) {
        Row({ space: 12 }) {
          Text('Title').fontSize(20).fontWeight(FontWeight.Medium)
          Blank()
          Image('').width(24).height(24).backgroundColor('#E0E0E0')
        }.width('100%').height(56).padding(16).backgroundColor('#FFF').shadow({ radius: 4, color: '#1F000000' })

        List({ space: 8 }) {
          ListItem() { TextInput().width('100%').height(44).backgroundColor('#FFF').borderRadius(8) }
          ListItem() { Divider().height(1).color('#E0E0E0') }
          ListItem() { Progress({ value: this.v, total: 100, type: ProgressType.Linear }).width('100%').height(4).color('#6750A4') }
          ListItem() { Slider({ value: this.v, min: 0, max: 100 }).width('100%') }
          ListItem() {
            Grid() {
              GridItem() { Column() { Text('A') }.backgroundColor('#FFF').padding(20).borderRadius(8) }
              GridItem() { Column() { Text('B') }.backgroundColor('#FFF').padding(20).borderRadius(8) }
            }.columnsTemplate('1fr 1fr').columnsGap(8).width('100%')
          }
        }.width('100%').layoutWeight(1)

        Blank()
      }.width('100%').height('100%').padding(16).backgroundColor('#F5F5F5')

      Button() { Text('Button') }.width(56).height(56).backgroundColor('#EADDFF').fontColor('#FFF').borderRadius(16).shadow({ radius: 6, color: '#3F000000' }).margin(24)
    }.width('100%').height('100%')
  }
}
~~~

---

### 6.2 Basic One-Shot Example (Swift → ArkTS)

Used in `basic_oneshot.py` for SwiftUI to ArkTS translation.

**Input (Swift):**

~~~swift
import SwiftUI

struct CompactOneShot: View {
    @State private var value: Double = 50
    @State private var inputText = ""

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    Text("Title")
                        .font(.system(size: 20, weight: .medium))

                    Spacer(minLength: 0)

                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color(hex: 0xE0E0E0))
                        .frame(width: 24, height: 24)
                }
                .frame(maxWidth: .infinity, minHeight: 56)
                .padding(16)
                .background(Color.white)
                .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        TextField("", text: $inputText)
                            .textFieldStyle(.plain)
                            .padding(.horizontal, 12)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                        Rectangle()
                            .fill(Color(hex: 0xE0E0E0))
                            .frame(height: 1)

                        ProgressView(value: value, total: 100)
                            .progressViewStyle(.linear)
                            .tint(Color(hex: 0x6750A4))
                            .frame(maxWidth: .infinity)

                        Slider(value: $value, in: 0 ... 100)
                            .tint(Color(hex: 0x6750A4))

                        LazyVGrid(columns: columns, spacing: 8) {
                            gridCard("A")
                            gridCard("B")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(16)
            .background(Color(hex: 0xF5F5F5))

            Button(action: {}) {
                Text("Button")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(hex: 0xEADDFF))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)
            .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 3)
            .padding(24)
        }
    }

    @ViewBuilder
    private func gridCard(_ title: String) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

private extension Color {
    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: 1
        )
    }
}

#Preview {
    CompactOneShot()
}
~~~

**Output (ArkTS):** Same as Kotlin example above.

---

### 6.3 Pipeline One-Shot Example (Skeleton → ArkTS)

Used in `pipeline.py` / `pipeline_swift.py` for skeleton-guided translation.

**Input (Skeleton with Metadata):**

~~~typescript
@Entry
@Component
struct CompactOneShot {
  @State v: number = 50

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.BottomEnd }
    // children: 2
    Stack() {
      // === Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#F5F5F5' }
      // children: 3
      Column() {
        // === Row ===
        // props: { space: 12 }
        // modifier: { width: '100%', height: 56, padding: 16, backgroundColor: '#FFF', shadow: { radius: 4, color: '#1F000000' } }
        // children: 3
        Row() {
          // === Text ===
          // props: { text: 'Title' }
          // modifier: { fontSize: 20, fontWeight: FontWeight.Medium }
          Text() {}
          // === Blank ===
          Blank() {}
          // === Image ===
          // modifier: { width: 24, height: 24, backgroundColor: '#E0E0E0' }
          Image() {}
        }

        // === List ===
        // props: { space: 8 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 5
        List() {
          ListItem() {
            // === TextInput ===
            // modifier: { width: '100%', height: 44, backgroundColor: '#FFF', borderRadius: 8 }
            TextInput() {}
          }
          ListItem() {
            // === Divider ===
            // modifier: { height: 1, color: '#E0E0E0' }
            Divider() {}
          }
          ListItem() {
            // === Progress ===
            // props: { value: this.v, total: 100, type: ProgressType.Linear }
            // modifier: { width: '100%', height: 4, color: '#6750A4' }
            Progress() {}
          }
          ListItem() {
            // === Slider ===
            // props: { value: this.v, min: 0, max: 100 }
            // modifier: { width: '100%' }
            Slider() {}
          }
          ListItem() {
            // === Grid ===
            // props: { columnsTemplate: '1fr 1fr', columnsGap: 8 }
            // modifier: { width: '100%' }
            // children: 2
            Grid() {
              GridItem() {
                // === Column ===
                // modifier: { backgroundColor: '#FFF', padding: 20, borderRadius: 8 }
                // children: 1
                Column() {
                  // === Text ===
                  // props: { text: 'A' }
                  Text() {}
                }
              }
              GridItem() {
                Column() {
                  // === Text ===
                  // props: { text: 'B' }
                  Text() {}
                }
              }
            }
          }
        }

        // === Blank ===
        Blank() {}
      }

      // === Button ===
      // modifier: { width: 56, height: 56, backgroundColor: '#EADDFF', fontColor: '#FFF', borderRadius: 16, shadow: { radius: 6, color: '#3F000000' }, margin: 24 }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: 'Button' }
        Text() {}
      }
    }
    // modifier: { width: '100%', height: '100%' }
  }
}
~~~

**Output (ArkTS):** Same as Kotlin example above.



## 7 Prompts

### 7.1 Basic Zero-Shot (`basic_translate.py`)

Direct translation without any example.

**System Prompt:**

~~~
Convert {Kotlin Compose UI/SwiftUI} code to ArkTS. Output code only.
~~~

**User Prompt:**

~~~
{Kotlin/Swift}:
```
{source_code}
```

ArkTS:
~~~

---

### 7.2 Basic One-Shot (`basic_oneshot.py`)

Translation with a source-code-to-ArkTS example (see examples above).

**System Prompt:**

~~~
Convert {Kotlin Compose UI/SwiftUI} code to ArkTS. Output code only.
~~~

**User Prompt:**

~~~
{Kotlin/Swift}:
```
[Basic One-Shot Example (Kotlin/Swift) shown above]
```

ArkTS:
```
[Corresponding ArkTS output shown above]
```

{Kotlin/Swift}:
```
{source_code}
```

ArkTS:
~~~

---

### 7.3 Pipeline One-Shot (`pipeline.py` / `pipeline_swift.py`)

Skeleton-guided translation with a skeleton-to-ArkTS example. The skeleton is an ArkTS-style IR with metadata comments.

**System Prompt:**

~~~
You are an expert ArkTS developer. Convert this ArkTS-style {Kotlin Compose UI/SwiftUI} skeleton to compilable ArkTS code.

Follow the code style and patterns shown in the example above.

{One-Shot Example shown above}

Output compilable ArkTS code only.
~~~

**User Prompt:**

~~~
Generate compilable ArkTS code based on the ArkTS-style {Kotlin Compose UI/SwiftUI} skeleton below.

**Theme Colors:**
{color_refs}

**UI Structure (Skeleton with Metadata):**
```
{skeleton_code}
```

Requirements:
1. Use ONLY: Stack, Column, Row, Grid, List, Text, Button, Image, Progress, Slider, Blank, Divider, TextInput
2. Column/Row: constructor takes { space: N }, chain methods come AFTER { }
3. List children MUST use ListItem(), Grid children MUST use GridItem()
4. State variables use this. prefix
5. Replace all // comments with actual implementation based on the metadata

Output compilable ArkTS code only:
~~~



## 8 Results

For KJC/SwiftUI-to-ArkUI translations with GPT-5.2 as the backbone, ArkTrans achieves a Compilation Success Rate at 53.33%–90.67%. Regarding the visual fidelity, ArkTrans obtains a CLIP Similarity score of 45.59%–78.89% and a Color Histogram Similarity score of 30.23%–56.01% from the perspective of global metrics. Towards the local metrics, ArkTrans still maintains its superiority. It achieves a Position Score of 23.00%–46.60%, a Size Score of 24.70%–46.20%, a Color Score of 23.70%–45.40%, and a Text Integrity score of 47.70%–82.50%.

In contrast, all SOTA LLMs under test with direct and one-shot prompting cannot even generate a compilable file, not to mention the visual fidelity after file rendering.

![](https://blogxiaozheng.oss-cn-beijing.aliyuncs.com/images/20260326205556642.png)
