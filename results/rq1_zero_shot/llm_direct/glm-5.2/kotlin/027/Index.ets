/**
 * This is an auto-generated ArkTS code from Kotlin Compose code.
 * It uses the ArkUI declarative paradigm.
 */

// --- Design Tokens ---
class AppTokens {
  static Colors = {
    primary: '#A0C4FF',
    secondary: '#B7E4C7',
    tertiary: '#FFDDC1',
    background: '#F8F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F0F5',
    outline: '#D9D9E3',
    success: '#B4E4C7',
    warning: '#FFDDC1',
    error: '#FFB4AB',
    onPrimary: '#001D3D',
    onSecondary: '#003720',
    onTertiary: '#3E2800',
    onBackground: '#1B1B1F',
    onSurface: '#1B1B1F',
  };

  static Typography = {
    display: { fontSize: 45, fontWeight: FontWeight.Bold },
    headline: { fontSize: 24, fontWeight: FontWeight.Medium },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, letterSpacing: 0.5 },
  };

  static Shapes = {
    small: 4,
    medium: 8,
    large: 12,
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };

  static ElevationMapping = {
    level1: { elevation: 1, radius: 2, dy: 1, opacity: 0.08 },
    level2: { elevation: 3, radius: 4, dy: 2, opacity: 0.10 },
    level3: { elevation: 6, radius: 8, dy: 4, opacity: 0.12 },
  };
}

// --- Models ---
class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

// --- Components ---
@Component
export struct AnnotationToolButton {
  @Prop icon: string;
  @Prop toolName: string;
  @Prop selectedTool: string;
  onClick: () => void = () => {};

  build() {
    Button(this.icon, { type: ButtonType.Circle })
      .width(40)
      .height(40)
      .backgroundColor(this.toolName === this.selectedTool ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .fontColor(this.toolName === this.selectedTool ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .fontWeight(FontWeight.Bold)
      .padding(0)
      .onClick(() => {
        this.onClick();
      });
  }
}

@Component
export struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = "pen";
  private pages: number[] = Array.from({ length: 12 }, (_, i) => i + 1);

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row()
          .width(24)
          .height(24)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .margin({ left: AppTokens.Spacing.lg });

        Text("Document.pdf")
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Button("Share")
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .margin({ right: AppTokens.Spacing.lg });
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      // Main Content
      Row() {
        // Page List
        Scroll() {
          Grid() {
            ForEach(this.pages, (page: number) => {
              GridItem() {
                Column() {
                  Text(page.toString())
                    .fontSize(AppTokens.Typography.label.fontSize)
                    .fontWeight(AppTokens.Typography.label.fontWeight)
                    .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface);
                }
                .width('100%')
                .aspectRatio(0.7)
                .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .border(this.selectedPage === page ? { width: 2, color: AppTokens.Colors.primary } : { width: 0, color: Color.Transparent })
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .onClick(() => {
                  this.selectedPage = page;
                });
              }
            })
          }
          .columns(2)
          .columnsGap(AppTokens.Spacing.sm)
          .rowsGap(AppTokens.Spacing.sm)
          .padding(AppTokens.Spacing.sm);
        }
        .width(150)
        .height('100%')
        .scrollBar(BarState.Off);

        // Spacer
        Column().width(AppTokens.Spacing.md);

        // PDF Viewer Area
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            // PDF Card
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level1.dy
              });

            Text(`Page ${this.selectedPage}`)
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface);

            // Annotation Tools
            Column() {
              AnnotationToolButton({ icon: "P", toolName: "pen", selectedTool: this.selectedTool, onClick: () => { this.selectedTool = "pen"; } });
              AnnotationToolButton({ icon: "H", toolName: "highlighter", selectedTool: this.selectedTool, onClick: () => { this.selectedTool = "highlighter"; } });
              AnnotationToolButton({ icon: "T", toolName: "text", selectedTool: this.selectedTool, onClick: () => { this.selectedTool = "text"; } });
              AnnotationToolButton({ icon: "S", toolName: "shape", selectedTool: this.selectedTool, onClick: () => { this.selectedTool = "shape"; } });
            }
            .align(Alignment.Start)
            .padding(AppTokens.Spacing.sm)
            .backgroundColor('rgba(255,255,255,0.8)')
            .border({ width: 1, color: AppTokens.Colors.outline })
            .borderRadius(AppTokens.Shapes.large)
            .margin({ left: AppTokens.Spacing.md });
          }
          .width('100%')
          .height('100%')
          .layoutWeight(1);
        }
        .layoutWeight(1)
        .height('100%')
        .padding(AppTokens.Spacing.md);
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%');
  }
}

@Entry
@Component
struct MainActivity {
  build() {
    RootScreen();
  }
}