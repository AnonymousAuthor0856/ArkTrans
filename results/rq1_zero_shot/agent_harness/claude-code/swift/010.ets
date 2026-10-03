import promptAction from '@ohos.promptAction';

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = class {
    static readonly primary: ResourceColor = 0xFF1976D2;
    static readonly secondary: ResourceColor = 0xFF607D8B;
    static readonly tertiary: ResourceColor = 0xFF757575;
    static readonly background: ResourceColor = 0xFFECEFF1;
    static readonly surface: ResourceColor = 0xFFFFFFFF;
    static readonly surfaceVariant: ResourceColor = 0xFFCFD8DC;
    static readonly outline: ResourceColor = 0xFFB0BEC5;
    static readonly success: ResourceColor = 0xFF4CAF50;
    static readonly warning: ResourceColor = 0xFFFFC107;
    static readonly error: ResourceColor = 0xFFF44336;
    static readonly onPrimary: ResourceColor = 0xFFFFFFFF;
    static readonly onSecondary: ResourceColor = 0xFFFFFFFF;
    static readonly onTertiary: ResourceColor = 0xFFFFFFFF;
    static readonly onBackground: ResourceColor = 0xFF263238;
    static readonly onSurface: ResourceColor = 0xFF263238;
  };

  static readonly Spacing = class {
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
    static readonly xxl: number = 32;
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

// MARK: - Layer Item View
@Component
struct LayerItemView {
  @Link layer: StoryLayer;
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Circle({ width: 32, height: 32 })
        .fill(this.isSelected ? 'rgba(255,255,255,0.2)' : AppTokens.Colors.surfaceVariant);

      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : 'rgba(38,50,56,0.7)');

      Text(this.layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis });
    }
    .padding({
      left: AppTokens.Spacing.xxl,
      right: AppTokens.Spacing.xxl,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .width(130)
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline
    })
    .onClick(() => {
      this.onSelect();
    });
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
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top bar
        Row() {
          Text('Exit')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
            .onClick(() => {
              promptAction.showToast({ message: 'Exit' });
            });

          Text('Story Editor')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center);

          Text('Post')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(8)
            .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
            .onClick(() => {
              promptAction.showToast({ message: 'Post' });
            });
        }
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppTokens.Colors.surface);

        // Main content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Preview card
            Stack() {
              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center);
            }
            .width('100%')
            .height(200)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(12)
            .shadow({
              radius: 3,
              color: 'rgba(0,0,0,0.1)',
              offsetX: 0,
              offsetY: 1
            })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

            // Upload status
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.secondary);

              // Custom progress bar
              Stack({ alignContent: Alignment.Start }) {
                // Track
                Row()
                  .width('100%')
                  .height(AppTokens.Spacing.sm)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(4);

                // Progress
                Row()
                  .width(this.uploadProgress * 100 + '%')
                  .height(AppTokens.Spacing.sm)
                  .backgroundColor(AppTokens.Colors.success)
                  .borderRadius(4);
              }
              .width('100%')
              .height(AppTokens.Spacing.sm);
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

            // Story layers - horizontal scroll
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.secondary)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

              Scroll() {
                Row({ space: AppTokens.Spacing.lg }) {
                  ForEach(this.layers, (item: StoryLayer, index: number) => {
                    LayerItemView({
                      layer: item,
                      isSelected: item.id === this.selectedLayer,
                      onSelect: () => {
                        this.selectedLayer = item.id;
                      }
                    });
                  }, (item: StoryLayer) => item.id.toString());
                }
                .padding({
                  left: AppTokens.Spacing.lg,
                  right: AppTokens.Spacing.lg,
                  top: AppTokens.Spacing.md,
                  bottom: AppTokens.Spacing.md
                });
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%');
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start);
          }
          .width('100%')
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg });
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background);
      }
      .width('100%')
      .height('100%');

      // Bottom bar
      Column({ space: AppTokens.Spacing.md }) {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary);

        Row() {
          Text('Opacity')
            .fontSize(14)
            .width(80)
            .textAlign(TextAlign.Start);

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value;
            });
        }
        .width('100%');
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 6,
        color: 'rgba(0,0,0,0.1)',
        offsetX: 0,
        offsetY: -2
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}
