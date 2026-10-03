// ============================================================
//  InvoiceScanner — ArkTS (HarmonyOS ArkUI) port of ContentView.swift
// ============================================================

// MARK: - 1. Design tokens (equivalent of AppTokens)
class AppTokens {
  // Colors (ArkUI uses #AARRGGBB)
  static readonly primary: string = '#FF06B6D4';
  static readonly secondary: string = '#FF3B82F6';
  static readonly tertiary: string = '#FF8B5CF6';
  static readonly background: string = '#FFF0F9FF';
  static readonly surface: string = '#E6FFFFFF';        // white @ 90%
  static readonly surfaceVariant: string = '#FFE0F2FE';
  static readonly outline: string = '#FFBAE6FD';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSurface: string = '#FF0F172A';

  // Gradient stops (secondary 30% -> background -> primary 30%)
  static readonly gradientTop: string = '#4D3B82F6';
  static readonly gradientMiddle: string = '#FFF0F9FF';
  static readonly gradientBottom: string = '#4D06B6D4';

  // Elevation level2 -> shadow(radius 8, x 0, y 4, opacity 0.18)
  static readonly shadowLevel2: string = '#2E000000';

  // Shapes
  static readonly shapeSmall: number = 6;
  static readonly shapeMedium: number = 12;
  static readonly shapeLarge: number = 20;

  // Spacing
  static readonly spacingSm: number = 8;
  static readonly spacingMd: number = 12;
  static readonly spacingLg: number = 16;
  static readonly spacingXl: number = 24;

  // Typography
  static readonly fontDisplay: number = 28;
  static readonly fontTitle: number = 18;
  static readonly fontBody: number = 14;
  static readonly fontLabel: number = 12;
}

// MARK: - 2. Data model
class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// MARK: - 3. Root screen
@Entry
@Component
struct Index {
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ];
  @State scanning: boolean = false;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // Equivalent of the SwiftUI Canvas draw closure
  private drawScene(): void {
    const ctx: CanvasRenderingContext2D = this.context;
    const w: number = ctx.width;
    const h: number = ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }
    ctx.clearRect(0, 0, w, h);

    // Inner circle (surfaceVariant), radius = minDimension / 2.5
    const centerX: number = w / 2;
    const centerY: number = h / 2;
    const radius: number = Math.min(w, h) / 2.5;
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.surfaceVariant;
    ctx.fill();

    // Markers (primary), radius 12
    for (let i = 0; i < this.markers.length; i++) {
      const marker: Marker = this.markers[i];
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.primary;
      ctx.fill();
    }
  }

  private addMarker(): void {
    if (!this.scanning) {
      return;
    }
    const x: number = 80 + Math.random() * (580 - 80);
    const y: number = 150 + Math.random() * (650 - 150);
    this.markers.push(new Marker(x, y, 'N' + (this.markers.length + 1)));
    this.drawScene();
  }

  build() {
    Column() {
      // ---------- Top bar (CenterAlignedTopAppBar) ----------
      Text('Invoice Scanner')
        .fontSize(AppTokens.fontDisplay)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.spacingLg, bottom: AppTokens.spacingLg })
        .backgroundColor(AppTokens.background)

      // ---------- Main content (gradient column) ----------
      Column({ space: AppTokens.spacingLg }) {

        // Surface card containing the Canvas
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawScene();
            })
        }
        .width('100%')
        .height(400)
        .padding(AppTokens.spacingMd)
        .borderRadius(AppTokens.shapeLarge)
        .backgroundColor(AppTokens.surface)
        .shadow({
          radius: 8,
          color: AppTokens.shadowLevel2,
          offsetX: 0,
          offsetY: 4
        })

        // Scanning Active row + custom toggle
        Row() {
          Text('Scanning Active')
            .fontSize(AppTokens.fontTitle)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onSurface)

          Blank()

          Stack({ alignContent: this.scanning ? Alignment.End : Alignment.Start }) {
            // Track
            Row()
              .width(50)
              .height(30)
              .borderRadius(15)
              .backgroundColor(this.scanning ? AppTokens.secondary : AppTokens.surfaceVariant)

            // Thumb
            Circle()
              .width(26)
              .height(26)
              .fill(this.scanning ? AppTokens.secondary : AppTokens.outline)
              .margin(2)
          }
          .width(50)
          .height(30)
          .onClick(() => {
            animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
              this.scanning = !this.scanning;
            });
          })
        }
        .width('100%')

        // Add Marker button
        Button('Add Marker')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .fontSize(AppTokens.fontTitle)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onPrimary)
          .backgroundColor(AppTokens.primary)
          .borderRadius(AppTokens.shapeMedium)
          .onClick(() => {
            this.addMarker();
          })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.spacingLg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.gradientTop, 0.0],
          [AppTokens.gradientMiddle, 0.5],
          [AppTokens.gradientBottom, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}