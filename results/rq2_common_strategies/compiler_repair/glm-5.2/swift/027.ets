// Index.ets

class ColorTokens {
  primary: string = '#FFA0C4FF';
  secondary: string = '#FFB7E4C7';
  tertiary: string = '#FFFFDDC1';
  background: string = '#FFF8F7FF';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFF0F0F5';
  outline: string = '#FFD9D9E3';
  success: string = '#FFB4E4C7';
  warning: string = '#FFFFDDC1';
  error: string = '#FFFFB4AB';
  onPrimary: string = '#FF001D3D';
  onSecondary: string = '#FF003720';
  onTertiary: string = '#FF3E2800';
  onBackground: string = '#FF1B1B1F';
  onSurface: string = '#FF1B1B1F';
}

class TypographyTokens {
  display: FontConfig = { size: 45, weight: FontWeight.Bold };
  headline: FontConfig = { size: 24, weight: FontWeight.Medium };
  title: FontConfig = { size: 18, weight: FontWeight.Medium };
  body: FontConfig = { size: 14, weight: FontWeight.Normal };
  label: FontConfig = { size: 12, weight: FontWeight.Medium };
}

class SpacingTokens {
  xs: number = 4.0;
  sm: number = 8.0;
  md: number = 12.0;
  lg: number = 16.0;
  xl: number = 24.0;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
  color: string;

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: string = '#000000') {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    this.color = color;
  }
}

class ElevationTokens {
  level1: ShadowSpec = new ShadowSpec(1.0, 2.0, 1.0, 0.08);
  level2: ShadowSpec = new ShadowSpec(3.0, 4.0, 2.0, 0.10);
  level3: ShadowSpec = new ShadowSpec(6.0, 8.0, 4.0, 0.12);
}

class AppTokens {
  static Colors: ColorTokens = new ColorTokens();
  static Typography: TypographyTokens = new TypographyTokens();
  static Spacing: SpacingTokens = new SpacingTokens();
  static Elevation: ElevationTokens = new ElevationTokens();
}

interface FontConfig {
  size: number;
  weight: FontWeight;
}

@Component
export struct AnnotationToolButton {
  @Prop icon: string;
  @Prop toolName: string;
  @Prop selectedTool: string;
  onToolClick: () => void = () => {};

  get isSelected(): boolean {
    return this.toolName === this.selectedTool;
  }

  build() {
    Button(this.icon, { type: ButtonType.Circle })
      .fontSize(17)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .width(40)
      .height(40)
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .onClick(() => {
        this.onToolClick();
      })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = "pen";

  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation Icon
        Button() {
          Circle({ width: 24, height: 24 }).fill(AppTokens.Colors.surfaceVariant)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)

        Blank() // Spacer

        Text("Document.pdf")
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank() // Spacer

        // Share Button
        Button("Share")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(4)
          .padding({
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs,
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm
          })
      }
      .width('100%')
      .height(56)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md
      })
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content Area
      Row() {
        // Left side: Grid for pages
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Button() {
                Text(page.toString())
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              }
              .width('100%')
              .height('100%')
              .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .borderRadius(8)
              .border(this.selectedPage === page ? { width: 2, color: AppTokens.Colors.primary } : { width: 0, color: Color.Transparent })
              .onClick(() => {
                this.selectedPage = page;
              })
            }
            .aspectRatio(0.7)
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.sm)
        .columnsGap(AppTokens.Spacing.sm)
        .width(150)
        .height('100%')
        .padding(AppTokens.Spacing.sm)

        // Right side: Main document view
        Stack({ alignContent: Alignment.Start }) {
          // Main document card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(12)
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: `${AppTokens.Elevation.level1.color}${Math.round(AppTokens.Elevation.level1.opacity * 255).toString(16).padStart(2, '0')}`,
            offsetX: 0,
            offsetY: AppTokens.Elevation.level1.dy
          })
          .justifyContent(FlexAlign.Center)

          // Annotation tools column
          Column({ space: AppTokens.Spacing.sm }) {
            AnnotationToolButton({ icon: "P", toolName: "pen", selectedTool: this.selectedTool, onToolClick: () => {
              this.selectedTool = "pen";
            } })
            AnnotationToolButton({ icon: "H", toolName: "highlighter", selectedTool: this.selectedTool, onToolClick: () => {
              this.selectedTool = "highlighter";
            } })
            AnnotationToolButton({ icon: "T", toolName: "text", selectedTool: this.selectedTool, onToolClick: () => {
              this.selectedTool = "text";
            } })
            AnnotationToolButton({ icon: "S", toolName: "shape", selectedTool: this.selectedTool, onToolClick: () => {
              this.selectedTool = "shape";
            } })
          }
          .padding(AppTokens.Spacing.sm)
          .backgroundColor(AppTokens.Colors.surface + 'CC') // 0.8 opacity
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .margin(AppTokens.Spacing.md)
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}