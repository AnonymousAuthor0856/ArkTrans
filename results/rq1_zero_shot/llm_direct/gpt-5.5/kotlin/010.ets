const NAME: string = '007_StoryEditor_en';
const UI_TYPE: string = 'Social';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

import window from '@ohos.window';
import common from '@ohos.app.ability.common';

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

const AppTokens = {
  Colors: {
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
  },
  TypographyTokens: {
    display: {
      fontSize: 36,
      fontWeight: FontWeight.Bold,
      letterSpacing: -0.5
    },
    headline: {
      fontSize: 24,
      fontWeight: FontWeight.Medium,
      letterSpacing: 0
    },
    title: {
      fontSize: 18,
      fontWeight: FontWeight.Medium,
      letterSpacing: 0.1
    },
    body: {
      fontSize: 14,
      fontWeight: FontWeight.Regular,
      letterSpacing: 0.25
    },
    label: {
      fontSize: 12,
      fontWeight: FontWeight.Medium,
      letterSpacing: 0.5
    }
  },
  Shapes: {
    small: 4,
    medium: 8,
    large: 12
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16
  },
  ElevationMapping: {
    level1: {
      elevation: 1,
      radius: 3,
      dy: 1,
      opacity: 0.1
    } as ShadowSpec,
    level2: {
      elevation: 3,
      radius: 6,
      dy: 2,
      opacity: 0.1
    } as ShadowSpec
  }
};

function rgba(r: number, g: number, b: number, a: number): string {
  return `rgba(${r}, ${g}, ${b}, ${a})`;
}

@Entry
@Component
struct RootScreen {
  @State private textOpacity: number = 1.0;
  @State private uploadProgress: number = 0.65;
  @State private selectedLayer: number = 3;

  private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ];

  aboutToAppear(): void {
    const context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  @Builder
  TopBar() {
    Stack() {
      Text('Story Editor')
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .letterSpacing(AppTokens.TypographyTokens.title.letterSpacing)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)

      Row() {
        Button('Exit', { type: ButtonType.Normal, stateEffect: true })
          .backgroundColor(Color.Transparent)
          .fontColor(AppTokens.Colors.onBackground)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .height(40)
          .onClick(() => {
          })

        Blank()

        Button('Post', { type: ButtonType.Normal, stateEffect: true })
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .height(40)
          .onClick(() => {
          })
      }
      .width('100%')
      .height('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.Colors.surface)
  }

  @Builder
  StoryPreviewCard() {
    Column() {
      Stack() {
        Text('Your Story Preview')
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .letterSpacing(AppTokens.TypographyTokens.headline.letterSpacing)
          .fontColor(rgba(255, 255, 255, this.textOpacity))
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .layoutWeight(1)
    .backgroundColor(AppTokens.Colors.tertiary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: rgba(0, 0, 0, AppTokens.ElevationMapping.level1.opacity),
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
    .margin({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.lg
    })
  }

  @Builder
  UploadStatus() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Upload Status')
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .letterSpacing(AppTokens.TypographyTokens.label.letterSpacing)
        .fontColor(AppTokens.Colors.secondary)

      Progress({
        value: this.uploadProgress * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(AppTokens.Spacing.sm)
        .color(AppTokens.Colors.success)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .style({ strokeWidth: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg
    })
  }

  @Builder
  LayerItem(layer: StoryLayer) {
    Column({ space: AppTokens.Spacing.sm }) {
      Circle()
        .width(32)
        .height(32)
        .fill(this.selectedLayer === layer.id ? rgba(255, 255, 255, 0.2) : AppTokens.Colors.surfaceVariant)

      Text(layer.type)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .letterSpacing(AppTokens.TypographyTokens.label.letterSpacing)
        .fontColor(this.selectedLayer === layer.id ? AppTokens.Colors.onPrimary : rgba(38, 50, 56, 0.7))
        .textAlign(TextAlign.Center)

      Text(layer.content)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .letterSpacing(AppTokens.TypographyTokens.body.letterSpacing)
        .fontColor(this.selectedLayer === layer.id ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(100)
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.selectedLayer === layer.id ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: this.selectedLayer === layer.id ? AppTokens.Colors.primary : AppTokens.Colors.outline
    })
    .onClick(() => {
      this.selectedLayer = layer.id;
    })
  }

  @Builder
  LayerList() {
    Scroll() {
      Row({ space: AppTokens.Spacing.md }) {
        ForEach(this.layers, (layer: StoryLayer) => {
          this.LayerItem(layer)
        }, (layer: StoryLayer) => layer.id.toString())
      }
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  BottomBar() {
    Column() {
      Text('Layer Properties')
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .letterSpacing(AppTokens.TypographyTokens.label.letterSpacing)
        .fontColor(AppTokens.Colors.secondary)

      Row() {
        Text('Opacity')
          .width(80)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .letterSpacing(AppTokens.TypographyTokens.body.letterSpacing)
          .fontColor(AppTokens.Colors.onSurface)

        Slider({
          value: this.textOpacity * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .layoutWeight(1)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .blockColor(AppTokens.Colors.primary)
          .onChange((value: number) => {
            this.textOpacity = value / 100;
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: rgba(0, 0, 0, AppTokens.ElevationMapping.level2.opacity),
      offsetY: -AppTokens.ElevationMapping.level2.dy
    })
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: AppTokens.Spacing.lg }) {
        this.StoryPreviewCard()
        this.UploadStatus()
        this.LayerList()
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}