import promptAction from '@ohos.promptAction';

// MARK: - AppTokens Colors
class AppColors {
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
}

// MARK: - AppTokens Spacing
class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// MARK: - AppTokens
class AppTokens {
  static readonly topBarHeight: number = 64;
}

// MARK: - Data Models
@Observed
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
  @ObjectLink layer: StoryLayer;
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Column({ space: AppSpacing.sm }) {
      Circle({ width: 32, height: 32 })
        .fill(this.isSelected ? 'rgba(255,255,255,0.2)' : AppColors.surfaceVariant);

      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onPrimary : 'rgba(38,50,56,0.7)');

      Text(this.layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis });
    }
    .padding({
      left: AppSpacing.xxl,
      right: AppSpacing.xxl,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .width(130)
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? AppColors.primary : AppColors.outline
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
            .fontColor(AppColors.onBackground)
            .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
            .onClick(() => {
              promptAction.showToast({ message: 'Exit' });
            });

          Text('Story Editor')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center);

          Text('Post')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onPrimary)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
            .backgroundColor(AppColors.primary)
            .borderRadius(8)
            .margin({ left: AppSpacing.sm, right: AppSpacing.sm })
            .onClick(() => {
              promptAction.showToast({ message: 'Post' });
            });
        }
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppColors.surface);

        // Main content
        Scroll() {
          Column({ space: AppSpacing.lg }) {
            // Preview card
            Stack() {
              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center);
            }
            .width('100%')
            .height(200)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(12)
            .shadow({
              radius: 3,
              color: 'rgba(0,0,0,0.1)',
              offsetX: 0,
              offsetY: 1
            })
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg });

            // Upload status
            Column({ space: AppSpacing.sm }) {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary);

              // Custom progress bar
              Stack({ alignContent: Alignment.Start }) {
                // Track
                Row()
                  .width('100%')
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.surfaceVariant)
                  .borderRadius(4);

                // Progress
                Row()
                  .width(this.uploadProgress * 100 + '%')
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.success)
                  .borderRadius(4);
              }
              .width('100%')
              .height(AppSpacing.sm);
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg });

            // Story layers - horizontal scroll
            Column({ space: AppSpacing.sm }) {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg });

              Scroll() {
                Row({ space: AppSpacing.lg }) {
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
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  top: AppSpacing.md,
                  bottom: AppSpacing.md
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
          .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg });
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.background);
      }
      .width('100%')
      .height('100%');

      // Bottom bar
      Column({ space: AppSpacing.md }) {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary);

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
            .blockColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .selectedColor(AppColors.primary)
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value;
            });
        }
        .width('100%');
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 6,
        color: 'rgba(0,0,0,0.1)',
        offsetX: 0,
        offsetY: -2
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
