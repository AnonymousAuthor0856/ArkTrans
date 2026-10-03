// Story Editor UI (SwiftUI -> ArkTS).

// MARK: - AppTokens
interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface FontSpec {
  size: number;
  weight: FontWeight;
}

interface AppTypography {
  display: FontSpec;
  headline: FontSpec;
  title: FontSpec;
  body: FontSpec;
  label: FontSpec;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppSpacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static readonly Colors: AppColors = {
    primary: '#1976D2',
    secondary: '#607D8B',
    tertiary: '#757575',
    background: '#ECEFF1',
    surface: '#FFFFFF',
    surfaceVariant: '#CFD8DC',
    outline: '#B0BEC5',
    success: '#4CAF50',
    warning: '#FFC107',
    error: '#F44336',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#263238',
    onSurface: '#263238'
  };

  static readonly TypographyTokens: AppTypography = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Semibold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: AppShapes = {
    small: 4, medium: 8, large: 12
  };

  static readonly Spacing: AppSpacing = {
    sm: 8, md: 12, lg: 16, xl: 24, xxl: 32
  };

  static readonly topBarHeight: number = 64;
}

// MARK: - Data Models
class StoryLayer {
  id: number;
  type: string;
  content: string;

  constructor(id: number, type: string, content: string) {
    this.id = id;
    this.type = type;
    this.content = content;
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0;
  @State uploadProgress: number = 0.65;
  @State layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ];
  @State selectedLayer: number = 3;

  build() {
    Stack() {
      // 主内容区域
      Column({ space: 0 }) {
        // 顶部栏
        Row() {
          Button('Exit')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
            .onClick(() => {})

          Blank()

          Text('Story Editor')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Button('Post')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
            .onClick(() => {})
        }
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppTokens.Colors.surface)

        // 主要内容区域
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // 预览卡片
            Stack() {
              Text('Your Story Preview')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .height(200)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })

            // 上传状态
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Upload Status')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.secondary)

              // 自定义进度条
              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(AppTokens.Spacing.sm)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(4)

                Row()
                  .width(this.uploadProgress * 100 + '%')
                  .height(AppTokens.Spacing.sm)
                  .backgroundColor(AppTokens.Colors.success)
                  .borderRadius(4)
              }
              .width('100%')
              .height(AppTokens.Spacing.sm)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // 图层列表
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Story Layers')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.secondary)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

              Scroll() {
                Row({ space: AppTokens.Spacing.lg }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    LayerItemView({
                      layer: layer,
                      isSelected: layer.id === this.selectedLayer,
                      onSelect: () => { this.selectedLayer = layer.id; }
                    })
                  }, (layer: StoryLayer) => layer.id.toString())
                }
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        }
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')

      // 底部栏
      Column() {
        Blank()

        Column({ space: AppTokens.Spacing.md }) {
          Text('Layer Properties')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.secondary)

          Row() {
            Text('Opacity')
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .width(80)
              .textAlign(TextAlign.Start)

            Slider({ value: this.textOpacity, min: 0, max: 1 })
              .selectedColor(AppTokens.Colors.primary)
              .layoutWeight(1)
              .onChange((value: number) => { this.textOpacity = value; })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 6, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -2 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - Layer Item View
@Component
struct LayerItemView {
  @Prop layer: StoryLayer = new StoryLayer(0, '', '');
  @Prop isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Button() {
      Column({ space: AppTokens.Spacing.sm }) {
        Circle()
          .width(32)
          .height(32)
          .fill(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surfaceVariant)
          .opacity(this.isSelected ? 0.2 : 1)

        Text(this.layer.type)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .opacity(this.isSelected ? 1 : 0.7)

        Text(this.layer.content)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(2)
      }
      .padding({ left: AppTokens.Spacing.xxl, right: AppTokens.Spacing.xxl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .width(130)
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(8)
      .border({ width: 1, color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline })
    }
    .onClick(() => { this.onSelect(); })
  }
}
