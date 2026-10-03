import { curves } from '@kit.ArkUI';

// ============ Design Tokens ============
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#C08552';
    export const secondary: string = '#9BB1C8';
    export const tertiary: string = '#E6CFAF';
    export const background: string = '#F3EFE6';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E7DDCF';
    export const outline: string = '#D4C5B6';
    export const success: string = '#6BB187';
    export const warning: string = '#E2A458';
    export const error: string = '#D66B5D';
    export const onPrimary: string = '#2A1C13';
    export const onSecondary: string = '#15202B';
    export const onTertiary: string = '#2C1F10';
    export const onBackground: string = '#261E19';
    export const onSurface: string = '#2E251D';
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 32;
    export const xxxl: number = 48;
  }

  export namespace Radius {
    export const small: number = 12;
    export const medium: number = 16;
    export const large: number = 20;
  }

  export namespace FontSize {
    export const display: number = 30;
    export const headline: number = 22;
    export const title: number = 18;
    export const body: number = 14;
    export const label: number = 12;
  }
}

// ============ Data Models ============
interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

// ============ Top App Bar ============
@Component
struct TopBar {
  build() {
    Row() {
      Button('Back', { type: ButtonType.Normal, stateEffect: true })
        .backgroundColor(Color.Transparent)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.FontSize.label)
        .fontWeight(FontWeight.Medium)
        .height(36)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

      Text('Study Focus Split')
        .fontSize(AppTokens.FontSize.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button('Share', { type: ButtonType.Normal, stateEffect: true })
        .backgroundColor(Color.Transparent)
        .fontColor(AppTokens.Colors.secondary)
        .fontSize(AppTokens.FontSize.label)
        .fontWeight(FontWeight.Medium)
        .height(36)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.Colors.surface)
    .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}

// ============ Bottom Bar ============
@Component
struct BottomBar {
  build() {
    Row() {
      Column() {
        Text('Next checkpoint')
          .fontSize(AppTokens.FontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text('12:40 Studio')
          .fontSize(AppTokens.FontSize.body)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Launch session', { type: ButtonType.Normal })
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.FontSize.label)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Radius.medium)
        .height(40)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.sm,
      bottom: AppTokens.Spacing.sm
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 10, color: '#29000000', offsetY: -2 })
  }
}

// ============ Module Pager Card ============
@Component
struct ModuleCard {
  module: StudyModule = { name: '', progress: 0, summary: '' };

  build() {
    Column() {
      Card() {
        Column() {
          Text(this.module.name)
            .fontSize(AppTokens.FontSize.headline)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.sm })

          Text(this.module.summary)
            .fontSize(AppTokens.FontSize.body)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.8)
            .margin({ bottom: AppTokens.Spacing.sm })

          Divider()
            .color(AppTokens.Colors.outline)
            .margin({ bottom: AppTokens.Spacing.sm })

          Row() {
            Text('Progress')
              .fontSize(AppTokens.FontSize.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            Text(`${this.module.progress}%`)
              .fontSize(AppTokens.FontSize.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ bottom: AppTokens.Spacing.sm })

          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(12)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Radius.small)

            Row()
              .width(`${this.module.progress}%`)
              .height(12)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Radius.small)
          }
          .width('100%')
          .height(12)
          .margin({ bottom: AppTokens.Spacing.sm })

          Button('Review outline', { type: ButtonType.Normal })
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.FontSize.label)
            .fontWeight(FontWeight.Medium)
            .borderRadius(AppTokens.Radius.medium)
            .height(36)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .width('100%')
      .borderRadius(AppTokens.Radius.large)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .padding({ left: 2, right: 2 })
  }
}

// ============ Focus Board Card ============
@Component
struct FocusBoardCard {
  tasks: TaskItem[] = [];

  build() {
    Column() {
      Text('Focus board')
        .fontSize(AppTokens.FontSize.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      ForEach(this.tasks, (task: TaskItem) => {
        Column() {
          Text(task.title)
            .fontSize(AppTokens.FontSize.body)
            .fontColor(AppTokens.Colors.onSurface)
          Text(task.duration)
            .fontSize(AppTokens.FontSize.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(AppTokens.Spacing.sm)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Radius.small)
        .margin({ bottom: AppTokens.Spacing.sm })
        .opacity(0.9)
      })

      Button('Add checkpoint', { type: ButtonType.Normal })
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.FontSize.label)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Radius.medium)
        .height(36)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xs })
    }
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .layoutWeight(1)
  }
}

// ============ Reflection Card ============
@Component
struct ReflectionCard {
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

  build() {
    Column() {
      Text('Reflection')
        .fontSize(AppTokens.FontSize.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      Column() {
        Text(this.focusNote)
          .fontSize(AppTokens.FontSize.body)
          .fontColor(AppTokens.Colors.onSurface)
          .padding(AppTokens.Spacing.md)
          .width('100%')
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Radius.medium)
      .margin({ bottom: AppTokens.Spacing.sm })

      Button('Shuffle note', { type: ButtonType.Normal })
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.FontSize.label)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Radius.medium)
        .height(36)
        .width('100%')
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique';
        })
    }
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Radius.large)
    .layoutWeight(1)
  }
}

// ============ Root Screen ============
@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;

  private modules: StudyModule[] = [
    { name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
    { name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
    { name: 'Morph Lab', progress: 83, summary: 'Color blending' },
    { name: 'Studio Review', progress: 28, summary: 'Peer critique' },
  ];

  private tasks: TaskItem[] = [
    { title: 'Research layering', duration: '45m' },
    { title: 'Feedback sync', duration: '30m' },
    { title: 'Practice recall', duration: '20m' },
  ];

  build() {
    Column() {
      // Top Bar
      TopBar()

      // Scrollable Content
      Scroll() {
        Column() {
          // Tab Row
          Row() {
            ForEach(this.modules, (module: StudyModule, index: number) => {
              Column() {
                Text(module.name)
                  .fontSize(AppTokens.FontSize.label)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                  .padding({
                    top: AppTokens.Spacing.sm,
                    bottom: AppTokens.Spacing.sm,
                    left: AppTokens.Spacing.xs,
                    right: AppTokens.Spacing.xs
                  })
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Divider()
                  .color(this.selectedTab === index ? AppTokens.Colors.primary : Color.Transparent)
                  .strokeWidth(2)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)
              .onClick(() => {
                this.selectedTab = index;
              })
            })
          }
          .width('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .margin({ bottom: AppTokens.Spacing.lg })

          // Pager (Swiper)
          Swiper() {
            ForEach(this.modules, (module: StudyModule) => {
              ModuleCard({ module: module })
            })
          }
          .index(this.selectedTab)
          .width('100%')
          .height(240)
          .indicator(false)
          .loop(false)
          .curve(curves.springMotion())
          .onChange((index: number) => {
            this.selectedTab = index;
          })
          .margin({ bottom: AppTokens.Spacing.lg })

          // Dual Pane Row
          Row() {
            FocusBoardCard({ tasks: this.tasks })

            Blank().width(AppTokens.Spacing.md)

            ReflectionCard()
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .margin({ bottom: AppTokens.Spacing.lg })
        }
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}