// entry/src/main/ets/pages/Index.ets
// 需在 resources/base/profile/main_pages.json 的 pages 数组中注册 "pages/Index"

import { AppColors, AppShapes, AppSpacing, AppTypography, StoryLayer } from '../common/AppTokens';

@Component
struct LayerItemView {
  @Prop layerType: string = '';
  @Prop content: string = '';
  @Prop isSelected: boolean = false;
  onSelect: () => void = () => {
  };

  build() {
    Column({ space: AppSpacing.sm }) {
      Circle({ width: 32, height: 32 })
        .fill(this.isSelected ? '#33FFFFFF' : AppColors.surfaceVariant)

      Text(this.layerType)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onPrimary : '#B3263238')

      Text(this.content)
        .fontSize(AppTypography.bodySize)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(130)
    .height(130)
    .padding({
      left: AppSpacing.xxl,
      right: AppSpacing.xxl,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: this.isSelected ? AppColors.primary : AppColors.outline })
    .onClick(() => {
      this.onSelect();
    })
  }
}

@Entry
@Component
struct Index {
  @State textOpacity: number = 1.0;
  @State uploadProgress: number = 0.65;
  @State selectedLayer: number = 3;
  @State layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ];

  build() {
    Column() {
      this.TopBar()
      this.ContentArea()
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  TopBar() {
    Row() {
      Row() {
        Button('Exit', { type: ButtonType.Normal })
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onBackground)
          .backgroundColor(Color.Transparent)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
          .onClick(() => {
          })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)

      Text('Story Editor')
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Row() {
        Button('Post', { type: ButtonType.Normal })
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .height(36)
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .onClick(() => {
          })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height(AppSpacing.topBarHeight)
    .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
  }

  @Builder
  ContentArea() {
    Scroll() {
      Column({ space: AppSpacing.lg }) {
        // 预览卡片
        Stack() {
          Column() {
          }
          .width('100%')
          .height('100%')
          .backgroundColor(AppColors.tertiary)
          .borderRadius(AppShapes.large)
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })

          Text('Your Story Preview')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onTertiary)
            .opacity(this.textOpacity)
            .textAlign(TextAlign.Center)
        }
        .width('calc(100% - 32vp)')
        .height(200)

        // 上传进度
        Column({ space: AppSpacing.sm }) {
          Text('Upload Status')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)

          Stack({ alignContent: Alignment.Start }) {
            Row() {
            }
            .width('100%')
            .height(AppSpacing.sm)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)

            Row() {
            }
            .width(this.uploadProgress * 100 + '%')
            .height(AppSpacing.sm)
            .backgroundColor(AppColors.success)
            .borderRadius(AppShapes.small)
          }
          .width('100%')
          .height(AppSpacing.sm)
        }
        .width('calc(100% - 32vp)')
        .alignItems(HorizontalAlign.Start)

        // 图层横向列表
        Column({ space: AppSpacing.sm }) {
          Text('Story Layers')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

          Scroll() {
            Row({ space: AppSpacing.lg }) {
              ForEach(this.layers, (item: StoryLayer) => {
                LayerItemView({
                  layerType: item.type,
                  content: item.content,
                  isSelected: item.id === this.selectedLayer,
                  onSelect: () => {
                    this.selectedLayer = item.id;
                  }
                })
              }, (item: StoryLayer) => item.id.toString())
            }
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.md,
              bottom: AppSpacing.md
            })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
    }
    .layoutWeight(1)
    .align(Alignment.Top)
    .width('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  BottomBar() {
    Column({ space: AppSpacing.md }) {
      Text('Layer Properties')
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Row({ space: AppSpacing.md }) {
        Text('Opacity')
          .fontSize(AppTypography.bodySize)
          .fontColor(AppColors.onBackground)
          .width(80)
          .textAlign(TextAlign.Start)

        Slider({
          value: this.textOpacity,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .layoutWeight(1)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.surface)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.textOpacity = value;
          })
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
  }
}