import { window } from '@kit.ArkUI';

class AppColors {
  static readonly primary: ResourceColor = '#1976D2';
  static readonly secondary: ResourceColor = '#607D8B';
  static readonly tertiary: ResourceColor = '#757575';
  static readonly background: ResourceColor = '#ECEFF1';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#CFD8DC';
  static readonly outline: ResourceColor = '#B0BEC5';
  static readonly success: ResourceColor = '#4CAF50';
  static readonly warning: ResourceColor = '#FFC107';
  static readonly error: ResourceColor = '#F44336';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#263238';
  static readonly onSurface: ResourceColor = '#263238';
}

class AppTypographyTokens {
  static readonly displaySize: number = 36;
  static readonly headlineSize: number = 24;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;

  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineWeight: number = 600;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class AppTokens {
  static readonly topBarHeight: number = 64;
}

interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

@Component
struct LayerItemView {
  @Prop layer: StoryLayer;
  @Prop isSelected: boolean;
  onSelect: () => void = () => {
  };

  build() {
    Column({ space: AppSpacing.sm }) {
      Stack()
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.isSelected ? '#33FFFFFF' : AppColors.surfaceVariant)

      Text(this.layer.type)
        .fontSize(AppTypographyTokens.labelSize)
        .fontWeight(AppTypographyTokens.labelWeight)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .opacity(this.isSelected ? 1 : 0.7)

      Text(this.layer.content)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.bodyWeight)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(130)
    .padding({
      left: AppSpacing.xxl,
      right: AppSpacing.xxl,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: 1,
      color: this.isSelected ? AppColors.primary : AppColors.outline
    })
    .onClick(() => {
      this.onSelect();
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private textOpacity: number = 1.0;
  @State private uploadProgress: number = 0.65;
  @State private selectedLayer: number = 3;
  @State private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        Row() {
          Text('Exit')
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(AppColors.onBackground)
            .padding({
              left: AppSpacing.sm,
              right: AppSpacing.sm
            })
            .onClick(() => {
            })

          Blank()
            .layoutWeight(1)

          Text('Story Editor')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(AppTypographyTokens.titleWeight)
            .fontColor(AppColors.onSurface)

          Blank()
            .layoutWeight(1)

          Text('Post')
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(AppColors.onPrimary)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .margin({
              left: AppSpacing.sm,
              right: AppSpacing.sm
            })
            .onClick(() => {
            })
        }
        .width('100%')
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppColors.surface)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            Stack({ alignContent: Alignment.Center }) {
              Text('Your Story Preview')
                .fontSize(AppTypographyTokens.headlineSize)
                .fontWeight(AppTypographyTokens.headlineWeight)
                .fontColor(AppColors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(200)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.large)
            .shadow({
              radius: 3,
              color: '#1A000000',
              offsetX: 0,
              offsetY: 1
            })
            .margin({
              left: AppSpacing.lg,
              right: AppSpacing.lg
            })

            Column({ space: AppSpacing.sm }) {
              Text('Upload Status')
                .fontSize(AppTypographyTokens.labelSize)
                .fontWeight(AppTypographyTokens.labelWeight)
                .fontColor(AppColors.secondary)

              Stack({ alignContent: Alignment.Start }) {
                Stack()
                  .width('100%')
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.surfaceVariant)
                  .borderRadius(4)

                Stack()
                  .width(`${this.uploadProgress * 100}%`)
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.success)
                  .borderRadius(4)
              }
              .width('100%')
              .height(AppSpacing.sm)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg
            })

            Column({ space: AppSpacing.sm }) {
              Text('Story Layers')
                .fontSize(AppTypographyTokens.labelSize)
                .fontWeight(AppTypographyTokens.labelWeight)
                .fontColor(AppColors.secondary)
                .padding({
                  left: AppSpacing.lg,
                  right: AppSpacing.lg
                })

              Scroll() {
                Row({ space: AppSpacing.lg }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    LayerItemView({
                      layer: layer,
                      isSelected: layer.id === this.selectedLayer,
                      onSelect: () => {
                        this.selectedLayer = layer.id;
                      }
                    })
                  }, (layer: StoryLayer) => layer.id.toString())
                }
                .padding({
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  top: AppSpacing.md,
                  bottom: AppSpacing.md
                })
              }
              .width('100%')
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({
            top: AppSpacing.lg,
            bottom: AppSpacing.lg
          })
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(AppColors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.md }) {
        Text('Layer Properties')
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.secondary)

        Row() {
          Text('Opacity')
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(AppColors.onSurface)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01
          })
            .layoutWeight(1)
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .onChange((value: number) => {
              this.textOpacity = value;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 6,
        color: '#1A000000',
        offsetX: 0,
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}