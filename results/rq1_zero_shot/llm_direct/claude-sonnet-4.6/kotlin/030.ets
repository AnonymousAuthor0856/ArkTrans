import { display } from '@kit.ArkUI';

// App Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF007BFF';
    export const secondary: string = '#FF6C757D';
    export const tertiary: string = '#FF17A2B8';
    export const background: string = '#FFF8F9FA';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFE9ECEF';
    export const outline: string = '#FFDEE2E6';
    export const success: string = '#FF28A745';
    export const warning: string = '#FFFFC107';
    export const error: string = '#FFDC3545';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FFFFFFFF';
    export const onTertiary: string = '#FFFFFFFF';
    export const onBackground: string = '#FF212529';
    export const onSurface: string = '#FF212529';
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export namespace ShapeRadius {
    export const small: number = 4;
    export const medium: number = 8;
    export const large: number = 12;
  }
}

interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

const clipboardItemsData: ClipboardItem[] = [
  { id: 1, content: 'https://www.example.com/modern-design', type: 'Link', timestamp: '5 min ago', progress: 0.2 },
  { id: 2, content: 'Final project review notes have been updated.', type: 'Text', timestamp: '23 min ago', progress: 0.5 },
  { id: 3, content: '#007BFF', type: 'Color', timestamp: '1 hour ago', progress: 0.8 },
  { id: 4, content: 'Meeting at 3 PM with the design team.', type: 'Text', timestamp: '3 hours ago', progress: 0.9 },
  { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: 'File', timestamp: 'Yesterday', progress: 1.0 },
];

@Component
struct ClipboardCard {
  item: ClipboardItem = { id: 0, content: '', type: '', timestamp: '', progress: 0 };

  build() {
    Column() {
      Row() {
        Box()
          .width(24)
          .height(24)
          .borderRadius(AppTokens.ShapeRadius.small)
          .backgroundColor(AppTokens.Colors.primary)

        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.sm })

        Blank()

        Text(this.item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.item.content)
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ top: AppTokens.Spacing.sm })

      Progress({
        value: this.item.progress * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(4)
        .borderRadius(AppTokens.ShapeRadius.small)
        .color(AppTokens.Colors.tertiary)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.ShapeRadius.large)
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant })
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text(Math.round(this.sliderValue).toString())
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .blockColor(AppTokens.Colors.primary)
        .onChange((value: number) => {
          this.sliderValue = value;
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 6, color: '#1A000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24;
  private clipboardItems: ClipboardItem[] = clipboardItemsData;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.ShapeRadius.medium)
          .height(36)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .margin({ right: AppTokens.Spacing.md })
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)
      .padding({ left: AppTokens.Spacing.lg })

      // Clipboard List
      List({ space: AppTokens.Spacing.md }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .backgroundColor(AppTokens.Colors.background)

      // Settings Pane
      SettingsPane({ sliderValue: $sliderValue })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}