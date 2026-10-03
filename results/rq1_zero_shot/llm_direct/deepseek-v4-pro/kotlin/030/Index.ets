import { Component, State, Prop, Builder } from '@kit.ArkUI';

// AppTokens - Design tokens
class AppTokens {
  static readonly Colors = {
    primary: '#007BFF',
    secondary: '#6C757D',
    tertiary: '#17A2B8',
    background: '#F8F9FA',
    surface: '#FFFFFF',
    surfaceVariant: '#E9ECEF',
    outline: '#DEE2E6',
    success: '#28A745',
    warning: '#FFC107',
    error: '#DC3545',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#212529',
    onSurface: '#212529'
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly Radius = {
    small: 4,
    medium: 8,
    large: 12
  };

  static readonly FontSize = {
    display: 36,
    headline: 28,
    title: 22,
    body: 16,
    label: 14
  };
}

// Data model
class ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;

  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id;
    this.content = content;
    this.type = type;
    this.timestamp = timestamp;
    this.progress = progress;
  }
}

// Clipboard Card Component
@Component
struct ClipboardCard {
  @Prop item: ClipboardItem;

  build() {
    Column() {
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          // Type icon box
          Column()
            .width(24)
            .height(24)
            .borderRadius(AppTokens.Radius.small)
            .backgroundColor(AppTokens.Colors.primary)

          Text(this.item.type)
            .fontSize(AppTokens.FontSize.label)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
        }
        .alignItems(VerticalAlign.Center)

        Blank()
          .layoutWeight(1)

        Text(this.item.timestamp)
          .fontSize(AppTokens.FontSize.label)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(AppTokens.Spacing.sm)

      Text(this.item.content)
        .fontSize(AppTokens.FontSize.body)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      Blank()
        .height(AppTokens.Spacing.md)

      // Progress bar
      Progress({ value: this.item.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(AppTokens.Colors.tertiary)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Radius.small)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant })
    .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.1)', offsetY: 1 })
  }
}

// Settings Pane Component
@Component
struct SettingsPane {
  @Prop sliderValue: number;
  onSliderChange: (value: number) => void = () => {};

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTokens.FontSize.label)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()
          .layoutWeight(1)

        Text(Math.round(this.sliderValue).toString())
          .fontSize(AppTokens.FontSize.body)
          .fontWeight(FontWeight.Medium)
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
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .blockColor(AppTokens.Colors.primary)
        .onChange((value: number) => {
          this.onSliderChange(value);
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.1)', offsetY: 2 })
  }
}

// Root Screen Component
@Component
struct RootScreen {
  @State clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ];
  @State sliderValue: number = 24;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Clipboard History')
          .fontSize(AppTokens.FontSize.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Clear')
          .fontSize(AppTokens.FontSize.label)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.medium)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .padding({ left: AppTokens.Spacing.lg, right: 0 })

      // Clipboard List
      List({ space: AppTokens.Spacing.md }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .scrollBar(BarState.Off)

      // Settings Pane
      SettingsPane({
        sliderValue: this.sliderValue,
        onSliderChange: (value: number) => {
          this.sliderValue = value;
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Main Entry Component
@Entry
@Component
struct MainPage {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}